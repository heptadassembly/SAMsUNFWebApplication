-- Function to get contactID from profile
delimiter $$
CREATE FUNCTION `fn_getContactID` (searchTerm varchar(50)) RETURNS int(11) DETERMINISTIC
begin
	declare contactID int;
   
    set contactID = 
		(select contact_id from profile where user_name = searchTerm);
        return (ifnull(contactID, -1));
	end$$
delimiter ;
 
-- add user_name to contact table.
alter table etl.contact
add contact_name varchar(20);

-- alter samsjacksonville.import_contact procedure to do two things:
-- 1) take only one update date (so it's consistent between create_dt and last_update_dt)
-- 2) take in contactName and put contact_id in it's proper place in samsjacksonville.contact table.

drop procedure `import_contact`;

DELIMITER $$
CREATE PROCEDURE `import_contact`()
BEGIN
    declare _count int;
    declare _schoolyear int;
    declare _contactName varchar(100);
    declare _currentDate datetime;
    
    SET SQL_SAFE_UPDATES = 0;
    set _schoolyear = (select school_year_id from samsjacksonville.vw_school_year limit 1);
    set _contactName = (select contact_name from etl.student limit 1);
    set _currentDate = now();
    /*Remove Duplicates*/
    
    delete es
    from etl.contact es
    inner join samsjacksonville.contact s on s.first_name = es.firstname and s.last_name = es.lastname and s.`position` = es.`position` and s.school_year_id = _schoolyear;
    
    set _count = 0;
    set _count = (select count(*) from etl.contact);
    
    select _count, _schoolyear;
    
	/*
    IF n > m THEN SET s = '>';
    ELSEIF n = m THEN SET s = '=';
    ELSE SET s = '<';
    END IF;
    */
    
    IF _count = 0 THEN select 'Error';
    else
		insert into
			samsjacksonville.contact
            (
                first_name,
                last_name,
                `position`,
                classroom, 
                room_number, 
				room_extension,
                email_address,
                cell_phone,
                school_id,
                school_year_id,
                create_contact_id,
                create_dt,
                last_update_contact_id,
                last_update_dt,
				is_deleted
			)
		select 
				s.`firstname`, 
                s.`lastname`, 
                s.`position`,
                s.`classroom`,
                s.`room`,
                s.`roomextension`,
                s.`email`,
                s.`cell`,
                samsjacksonville.fn_getSchoolID(s.`school`), 
				_schoolyear, 
                samsjacksonville.fn_getContactID(_contactName), 
                _currentDate, 
                samsjacksonville.fn_getContactID(_contactName), 
                _currentDate, 
                0
		from 
			etl.contact s;
	END IF;
    SET SQL_SAFE_UPDATES = 1;
    
    call samsjacksonville.import_homeroom();
    
	truncate table etl.contact;
    
END$$
DELIMITER ;

-- updating contacts.
drop procedure `import_homeroom`;
DELIMITER $$
CREATE PROCEDURE `import_homeroom`()
BEGIN
    declare _count int;
    declare _schoolyear int;
    declare _contactname varchar(20);
    declare _currentDate datetime;
    
    SET SQL_SAFE_UPDATES = 0;
    set _schoolyear = (select school_year_id from samsjacksonville.vw_school_year limit 1);
    set _currentDate = now();
    /*Get all Homerooms*/
    DROP TEMPORARY TABLE IF EXISTS homerooms;
    CREATE TEMPORARY TABLE IF NOT EXISTS homerooms AS (SELECT * FROM etl.contact);
    
    select * from homerooms;
    
    set _contactName = (select contact_name from homerooms limit 1);
    -- drop temporary table if exists homerooms;
    
    /*Update table to fix some of the data*/
    update homerooms
    set classroom = ''
    where classroom in ('-', '');
    
    /*Remove Duplicates*/
    delete es
    from homerooms es
    inner join samsjacksonville.homeroom s on s.homeroom_name = es.classroom and s.school_year_id = _schoolyear;
    
    delete es
    from homerooms es
    inner join samsjacksonville.homeroom s on s.homeroom_name = es.room and s.school_year_id = _schoolyear;
    
    /*Populate the Homeroom Table*/
    insert into samsjacksonville.homeroom 
    (
		homeroom_name, 
        room_number, 
        school_year_id, 
        school_id, 
        create_contact_id, 
        create_dt, 
        last_update_contact_id, 
        last_update_dt
	)
	(
		select 
			distinct h.classroom, 
            h.room, 
            _schoolyear, 
            samsjacksonville.fn_getSchoolID(h.school), 
            samsjacksonville.fn_getContactID(_contactName),
            _currentDate,
            samsjacksonville.fn_getContactID(_contactName),
            _currentDate
		from homerooms h where h.classroom not in (''));
    
    insert into samsjacksonville.homeroom (homeroom_name, room_number, school_year_id, school_id)
    (select distinct h.room, h.room, _schoolyear, samsjacksonville.fn_getSchoolID(h.school) from homerooms h where h.classroom in (''));
	
    SET SQL_SAFE_UPDATES = 1;
    
    select * from etl.contact;
    DROP TEMPORARY TABLE IF EXISTS homerooms;
    
END$$
DELIMITER ;



--add user_name to student table
alter table etl.student
add contact_name varchar(20);

use samsjacksonville;

-- alter samsjacksonville.import_student procedure to do two things:
-- 1) take only one update date (so it's consistent between create_dt and last_update_dt)
-- 2) take in contactName and put contact_id in it's proper place in samsjacksonville.student table.

drop procedure `import_student`;

DELIMITER $$
CREATE PROCEDURE `import_student`()
BEGIN
    declare _count int;
    declare _schoolyear int;
    declare _contactName varchar(20);
    declare _currentDate datetime;
    
    SET SQL_SAFE_UPDATES = 0;
    set _schoolyear = (select school_year_id from samsjacksonville.vw_school_year limit 1);
    set _currentDate = now();
    set _contactName = (select contact_name from etl.contact limit 1);
    /*Remove Duplicates*/
    
    delete es
    from etl.student es
    inner join samsjacksonville.student s on s.student_id_nk = es.studentid and s.school_year_id = _schoolyear;
    
    set _count = 0;
    set _count = (select count(*) from etl.student);
    
    select _count, _schoolyear;
    
	/*
    IF n > m THEN SET s = '>';
    ELSEIF n = m THEN SET s = '=';
    ELSE SET s = '<';
    END IF;
    */
    
    IF _count = 0 THEN select 'Error';
    else
		insert into
			samsjacksonville.student
            (
				student_id_nk,
                first_name, 
                last_name, 
                school_id, 
                school_year_id, 
				homeroom_id, 
                grade_id, 
                gender, 
                create_contact_id, 
                create_dt, 
                last_update_contact_id, 
                last_update_dt,
				is_deleted
			)
		select 
				s.studentid, 
                s.`first`, 
                s.`last`, 
                samsjacksonville.fn_getSchoolID(s.school), 
				_schoolyear, 
                -1, 
                samsjacksonville.fn_getGradeID(s.grade), 
                s.gender, 
                samsjacksonville.fn_getContactID(_contactName), 
                _currentDate, 
                samsjacksonville.fn_getContactID(_contactName), 
                _currentDate, 
                0
		from 
			etl.student s;
	END IF;
    SET SQL_SAFE_UPDATES = 1;
    truncate table etl.student;
    
END$$
DELIMITER ;

