DROP PROCEDURE IF EXISTS `samsjacksonville`.`import_contact`;
DELIMITER $$
CREATE PROCEDURE `import_contact`()
BEGIN
    declare _count int;
    declare _schoolyear int;
    
    SET SQL_SAFE_UPDATES = 0;
    set _schoolyear = (select school_year_id from samsjacksonville.vw_school_year limit 1);
    
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
                -1, 
                now(), 
                -1, 
                now(), 
                0
		from 
			etl.contact s;
	END IF;
    SET SQL_SAFE_UPDATES = 1;
    
    call samsjacksonville.import_homeroom();
    
    truncate table etl.contact;
    
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `samsjacksonville`.`import_homeroom`;
DELIMITER $$
CREATE PROCEDURE `samsjacksonville`.`import_homeroom`()
BEGIN
    declare _count int;
    declare _schoolyear int;
    
    SET SQL_SAFE_UPDATES = 0;
    set _schoolyear = (select school_year_id from samsjacksonville.vw_school_year limit 1);
    
    /*Get all Homerooms*/
    CREATE TEMPORARY TABLE IF NOT EXISTS homerooms AS (SELECT * FROM etl.contact);
    select * from homerooms;
    -- drop temporary table if exists homerooms;
    
    /*Update table to fix some of the data*/
    update homerooms
    set classroom = ''
    where classroom in ('-', '');
    
    /*Remove Duplicates*/
    delete es
    from homerooms es
    inner join samsjacksonville.homeroom s on s.class_room = es.classroom and s.school_year_id = _schoolyear;
    
    delete es
    from homerooms es
    inner join samsjacksonville.homeroom s on s.class_room = es.room and s.school_year_id = _schoolyear;
    
    /*Populate the Homeroom Table*/
    insert into samsjacksonville.homeroom (class_room, school_year_id, school_id)
	(select distinct h.classroom, 20152016, samsjacksonville.fn_getSchoolID(h.school) from homerooms h where h.classroom not in (''));
    
    insert into samsjacksonville.home_room
    (select distinct room_number, _schoolyear from homerooms where classroom in (''));
	
    SET SQL_SAFE_UPDATES = 1;
    truncate table etl.contact;
    
END$$
DELIMITER ;
