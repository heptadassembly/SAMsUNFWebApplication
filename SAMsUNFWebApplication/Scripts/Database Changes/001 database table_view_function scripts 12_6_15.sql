drop database if exists samsjacksonville;
drop database if exists etl;

CREATE database etl;
USE ETL;

DROP TABLE if exists etl.student;

CREATE TABLE `student` (
  `studentid` varchar(800) DEFAULT NULL,
  `last` varchar(800) DEFAULT NULL,
  `first` varchar(800) DEFAULT NULL,
  `grade` varchar(800) DEFAULT NULL,
  `school` varchar(800) DEFAULT NULL,
  `gender` varchar(800) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE database SAMSJACKSONVILLE;
USE SAMSJACKSONVILLE;
/* remove views */
-- select 'dropping views' views;
DROP VIEW if exists samsjacksonville.vw_student;
DROP VIEW if exists samsjacksonville.vw_grade;
DROP VIEW if exists samsjacksonville.vw_code_of_conduct_violation;
DROP VIEW if exists samsjacksonville.vw_remedial_action;
DROP VIEW if exists samsjacksonville.vw_profile;
DROP VIEW if exists samsjacksonville.vw_contact;
DROP VIEW if exists samsjacksonville.vw_homeroom;
DROP VIEW if exists samsjacksonville.vw_school;
DROP VIEW if exists samsjacksonville.vw_content_course;
DROP VIEW if exists samsjacksonville.vw_office_visit;
DROP VIEW if exists samsjacksonville.vw_office_visit_remedial_action_assn;
DROP VIEW if exists samsjacksonville.vw_office_visit_offense_assn;
DROP VIEW if exists samsjacksonville.vw_school_year;

/* remove tables */
-- select 'dropping tables' `tables`;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE if exists samsjacksonville.office_visit_remedial_action_assn;
DROP TABLE if exists samsjacksonville.office_visit_offense_assn;
DROP TABLE if exists samsjacksonville.office_visit;
DROP TABLE if exists samsjacksonville.student;
DROP TABLE if exists samsjacksonville.grade;
DROP TABLE if exists samsjacksonville.code_of_conduct_violation;
DROP TABLE if exists samsjacksonville.remedial_action;
DROP TABLE if exists samsjacksonville.profile;
DROP TABLE if exists samsjacksonville.homeroom;
DROP TABLE if exists samsjacksonville.school;
DROP TABLE if exists samsjacksonville.content_course;
DROP TABLE if exists samsjacksonville.contact;
DROP TABLE if exists samsjacksonville.school_year;
DROP TABLE if exists samsjacksonville.gender;
SET FOREIGN_KEY_CHECKS = 1;

/* remove procedures and functions */
-- select 'creating functions' functions;
DROP FUNCTION  if exists samsjacksonville.fn_getTotalVisits;
DROP FUNCTION  if exists samsjacksonville.fn_getSchoolID;
DROP FUNCTION  if exists samsjacksonville.fn_getGradeID;
DROP FUNCTION  if exists samsjacksonville.fn_get_description_officevisit_remedial_actions;
DROP FUNCTION  if exists samsjacksonville.fn_get_description_officevisit_offenses;
DROP FUNCTION  if exists samsjacksonville.fn_getSchoolYear;
DROP PROCEDURE if exists samsjacksonville.import_student;
DROP PROCEDURE if exists samsjacksonville.update_school_year;
DROP PROCEDURE if exists samsjacksonville.import_contact;
DROP PROCEDURE IF EXISTS `samsjacksonville`.`import_contact`;
DROP PROCEDURE IF EXISTS `samsjacksonville`.`import_homeroom`;


-- CREATE TABLE School
SET FOREIGN_KEY_CHECKS = 0;
-- select 'creating schools' '';
CREATE TABLE if not exists samsjacksonville.school
(
	school_id int not null auto_increment unique,
    name varchar(200),
    create_contact_id int default -1,
    create_dt datetime default now(),
	last_update_contact_id int default -1,
	last_update_dt datetime default now(),
    is_deleted bit default 0,
    primary key (school_id)
);


-- select 'creating tables' tables;
-- CREATE TABLE School Year
CREATE TABLE if not exists samsjacksonville.school_year
(
	school_year_id int unique not null,
    is_current bit,
	create_contact_id  int default -1,
	create_dt datetime default now(),
	last_update_contact_id  int default -1,
	last_update_dt datetime default now(),
	is_deleted bit default 0,
    primary key (school_year_id)
);
SET FOREIGN_KEY_CHECKS = 1;

-- CREATE TABLE Contact
CREATE TABLE if not exists samsjacksonville.contact
(
	contact_id int unique auto_increment not null,
    first_name varchar(40),
    last_name varchar(40),
    position varchar(75),
    classroom varchar(50),
    room_number varchar(20),
    room_extension varchar(10),
    school_id int,
    email_address varchar(200),
    cell_phone varchar(20),
    school_year_id int,
    create_contact_id  int default -1,
    create_dt datetime default now(),
	last_update_contact_id  int default -1,
	last_update_dt datetime default now(),
    is_deleted bit not null default 0,
    primary key (contact_id),
    CONSTRAINT contact_frindx1 foreign key (school_year_id) references samsjacksonville.school_year(school_year_id),
    CONSTRAINT contact_school1 foreign key (school_id) references samsjacksonville.school(school_id)
);

create index _contactidx on samsjacksonville.contact(contact_id, school_year_id);

-- CREATE TABLE Grade
-- select 'creating grades' '';
CREATE TABLE if not exists samsjacksonville.grade
(
	grade_id int not null unique auto_increment,
    grade_value varchar(3),
    grade_text varchar(50),
    create_contact_id  int default -1,
    create_dt datetime default now(),
	last_update_contact_id int default -1,
	last_update_dt datetime default now(),
    is_deleted bit default 0,
    primary key (grade_id),
    foreign key (create_contact_id) references samsjacksonville.contact(contact_id),
    foreign key (last_update_contact_id) references samsjacksonville.contact(contact_id)
);

create index _gradeidx on grade(grade_value);

-- CREATE TABLE Profile
-- select 'creating profiles' '';
CREATE TABLE if not exists samsjacksonville.profile
(
	profile_id int not null unique auto_increment,
    contact_id int not null,
    user_name varchar(20),
    password varchar(100),
	school_year_id int,
    create_contact_id int default -1,
    create_dt datetime default now(),
	last_update_contact_id int default -1,
	last_update_dt datetime default now(),
    is_deleted bit not null default 0,
    primary key (profile_id),
    foreign key (contact_id) references samsjacksonville.contact(contact_id),
    foreign key (school_year_id) references samsjacksonville.school_year(school_year_id),
    foreign key (create_contact_id) references samsjacksonville.contact(contact_id),
    foreign key (last_update_contact_id) references samsjacksonville.contact(contact_id)
);

create index _profileidx on samsjacksonville.profile(profile_id, school_year_id);

-- CREATE TABLE HomeRoom
-- select 'creating hommerooms' '';
CREATE TABLE if not exists samsjacksonville.homeroom
(
	homeroom_id int not null unique auto_increment,
    class_room varchar(50),
    room_number varchar(20),
    school_id int,
    school_year_id int,
    create_contact_id int default -1,
    create_dt datetime default now(),
	last_update_contact_id int default -1,
	last_update_dt datetime default now(),
    is_deleted bit default 0,
    primary key (homeroom_id),
    foreign key (school_id) references samsjacksonville.school(school_id),
    foreign key (school_year_id) references samsjacksonville.school_year(school_year_id),
    foreign key (create_contact_id) references samsjacksonville.contact(contact_id),
    foreign key (last_update_contact_id) references samsjacksonville.contact(contact_id)
);


-- CREATE TABLE Student
-- select 'creating students' '';
CREATE TABLE if not exists samsjacksonville.student
(
	student_id int not null auto_increment,
    student_id_nk varchar(20) not null,
    first_name varchar(20),
    last_name varchar(20),
    school_id int,
    school_year_id int,
    homeroom_id int,
    grade_id int,
    gender varchar(15),
    create_contact_id int default -1,
    create_dt datetime default now(),
	last_update_contact_id int default -1,
	last_update_dt datetime default now(),
    is_deleted bit default 0,
    primary key (student_id),
    foreign key (school_year_id) references samsjacksonville.school_year(school_year_id),
    foreign key (homeroom_id) references samsjacksonville.homeroom(homeroom_id),
    foreign key (grade_id) references samsjacksonville.grade(grade_id),
    foreign key (create_contact_id) references samsjacksonville.contact(contact_id),
    foreign key (last_update_contact_id) references samsjacksonville.contact(contact_id),
    foreign key (school_id) references samsjacksonville.school(school_id)
);

-- CREATE TABLE Content Course
-- select 'creating courses' '';
CREATE TABLE if not exists samsjacksonville.content_course
(
	content_course_id int not null unique auto_increment,
    name varchar(200),
    create_contact_id int default -1,
    create_dt datetime default now(),
	last_update_contact_id int default -1,
	last_update_dt datetime default now(),
    is_deleted bit default 0,
    primary key (content_course_id),
    foreign key (create_contact_id) references samsjacksonville.contact(contact_id),
    foreign key (last_update_contact_id) references samsjacksonville.contact(contact_id)
);

-- CREATE TABLE Code of Conduct Violation
-- select 'creating code violations' '';
CREATE TABLE if not exists samsjacksonville.code_of_conduct_violation
(
	code_of_conduct_violation_id int unique not null auto_increment,
	duval_violation_code varchar(5),
	short_code varchar(3),
    name varchar(300),
    create_contact_id int default -1,
    create_dt datetime default now(),
	last_update_contact_id int default -1,
	last_update_dt datetime default now(),
    is_deleted bit default 0,
    school_year_id int,
    primary key (code_of_conduct_violation_id),
    foreign key (school_year_id) references samsjacksonville.school_year(school_year_id),
    foreign key (create_contact_id) references samsjacksonville.contact(contact_id),
    foreign key (last_update_contact_id) references samsjacksonville.contact(contact_id)
);

create index _cocidx on samsjacksonville.code_of_conduct_violation(code_of_conduct_violation_id, school_year_id);

-- CREATE TABLE for Remedial Action
-- select 'creating remedials' '';
CREATE TABLE if not exists samsjacksonville.remedial_action
(
	remedial_action_id int not null unique auto_increment,
    name varchar(200),
    school_year_id int,
    create_contact_id int default -1,
    create_dt datetime default now(),
	last_update_contact_id int default -1,
	last_update_dt datetime default now(),
    is_deleted bit default 0,
    primary key (remedial_action_id),
    foreign key (school_year_id) references samsjacksonville.school_year(school_year_id),
    foreign key (create_contact_id) references samsjacksonville.contact(contact_id),
    foreign key (last_update_contact_id) references samsjacksonville.contact(contact_id)
);

create index _remedialidx on samsjacksonville.remedial_action(remedial_action_id, school_year_id);

-- CREATE TABLE for UI for Gender Information
-- select 'creating genders' '';

CREATE TABLE if not exists samsjacksonville.gender
(
	gender varchar(20)
);

-- select 'creating table office visits' '';
/* ******************BEGIN OFFICE VISIT INSERTION*************************** */
/* table, views and populate office visit */
-- CREATE TABLE Office_Visit
CREATE TABLE samsjacksonville.office_visit(
	office_visit_id int NOT NULL AUTO_INCREMENT,   
	school_year_id int NOT NULL,  
	student_id int NOT NULL, 
	total_visits int NOT NULL, 
	content_course_id int NOT NULL,   
	sent_by_contact_id int NOT NULL DEFAULT -1,  
	office_visit_dt datetime default now(),   
	arrival_dt datetime default now(),   
	handled_by_contact_id int DEFAULT -1,   
	nap bit DEFAULT b'0',   
	comments varchar(255) DEFAULT NULL,   
	last_update_contact_id  INT NOT NULL DEFAULT -1,   
	last_update_dt datetime NOT NULL default now(),
    is_deleted bit not null default b'0',
    homeroom_id int NOT NULL,
	PRIMARY KEY (office_visit_id),   
	UNIQUE KEY office_visit_id_UNIQUE (office_visit_id),
	KEY office_visit_ibfk_2 (student_id),   
	KEY office_visit_ibfk_3 (content_course_id),   
	KEY office_visit_ibfk_4 (sent_by_contact_id),   
	KEY office_visit_ibfk_5 (handled_by_contact_id),   
	KEY office_visit_ibfk_6 (last_update_contact_id),
    KEY office_visit_ibfk_7 (homeroom_id),
	CONSTRAINT office_visit_ibfk_1 FOREIGN KEY (school_year_id) REFERENCES samsjacksonville.school_year (school_year_id),   
	CONSTRAINT office_visit_ibfk_2 FOREIGN KEY (student_id) REFERENCES samsjacksonville.student (student_id),   
	CONSTRAINT office_visit_ibfk_3 FOREIGN KEY (content_course_id) REFERENCES samsjacksonville.content_course (content_course_id),
	CONSTRAINT office_visit_ibfk_4 FOREIGN KEY (sent_by_contact_id) REFERENCES samsjacksonville.contact (contact_id),   
	CONSTRAINT office_visit_ibfk_5 FOREIGN KEY (handled_by_contact_id) REFERENCES samsjacksonville.contact (contact_id),   
	CONSTRAINT office_visit_ibfk_6 FOREIGN KEY (last_update_contact_id) REFERENCES samsjacksonville.contact (contact_id),
	CONSTRAINT office_visit_ibfk_7 FOREIGN KEY (homeroom_id) REFERENCES samsjacksonville.homeroom (homeroom_id)
 
);
ALTER TABLE office_visit AUTO_INCREMENT = 0;

-- select 'creating table office visit to remedials' '';
CREATE TABLE samsjacksonville.office_visit_remedial_action_assn (   
	office_visit_id int(11) NOT NULL,   
	remedial_action_id int(11) NOT NULL,   
	PRIMARY KEY (office_visit_id,remedial_action_id),   
	CONSTRAINT office_visit_remedial_action_assn_ibfk_1 FOREIGN KEY (office_visit_id) REFERENCES samsjacksonville.office_visit (office_visit_id),   
	CONSTRAINT office_visit_remedial_action_assn_ibfk_2 FOREIGN KEY (remedial_action_id) REFERENCES samsjacksonville.remedial_action (remedial_action_id)
);

ALTER TABLE samsjacksonville.office_visit_remedial_action_assn AUTO_INCREMENT = 0;

/* Add associations tables and views for offenses and remedial actions to office visits */
CREATE TABLE samsjacksonville.office_visit_offense_assn (   
	office_visit_id int(11) NOT NULL,   
	code_of_conduct_violation_id int(11) NOT NULL,   
	PRIMARY KEY (office_visit_id,code_of_conduct_violation_id),   
	CONSTRAINT office_visit_offense_assn_ibfk_1 FOREIGN KEY (office_visit_id) REFERENCES samsjacksonville.office_visit (office_visit_id),   
	CONSTRAINT office_visit_offense_assn_ibfk_2 FOREIGN KEY (code_of_conduct_violation_id) REFERENCES samsjacksonville.code_of_conduct_violation (code_of_conduct_violation_id)
);

/* resets the auto to zero */
ALTER TABLE samsjacksonville.office_visit_offense_assn AUTO_INCREMENT = 0;

/* Create Procedures/Functions */
delimiter $$
create function samsjacksonville.fn_getTotalVisits(studentId int) returns int deterministic
begin
	declare totalVisits int;
	
	set totalVisits = (select ifnull(count(studentId), 0) + 1 
    from samsjacksonville.office_visit ov
    inner join samsjacksonville.school_year sy on sy.school_year_id = ov.school_year_id
    where student_id = studentId and sy.is_current = 1);
    
    return (totalVisits);
end$$

--drop function samsjacksonville.fn_getSchoolYear;
delimiter $$
create function samsjacksonville.fn_getSchoolYear (param INT) RETURNS int(11)
	DETERMINISTIC
begin
	declare schoolYearID int;
    set schoolYearID = (select school_year_id from vw_school_year limit 1);
    return (ifnull(schoolYearID, -1));
end$$
delimiter;

delimiter $$
-- drop function samsjacksonville.fn_getSchoolID;
create function samsjacksonville.fn_getSchoolID(Schoolname varchar(50)) returns int deterministic
begin
	declare schoolID int;
    declare testID varchar(52);
    declare searchTerm varchar(52);
    
    set testID = 
		case when Schoolname like '%1271%' then 'Impact'
			 when Schoolname like '%0601%' then 'Voice'
             when Schoolname like '%5581%' then 'KJE'
			 else Schoolname
             end;
    
    set searchTerm = 
		case when testID in ('Impact', 'Voice', 'KJE') then concat('%', testID, '%')
		else concat('%', Schoolname, '%') end;
    
    set schoolID = (select school_id from samsjacksonville.school where name like searchTerm order by school_id LIMIT 1);
	return (ifnull(schoolID, -1));
end$$
delimiter ;

DELIMITER $$
CREATE FUNCTION `fn_getGradeID`(gradeValue varchar(50)) RETURNS int(11)
    DETERMINISTIC
begin
	declare gradeID int;
    declare searchTerm varchar(52);
    
    set gradeID = 
		case when gradeValue = 'KG' then (select grade_id from samsjacksonville.grade where grade_value = 'K')
         when gradeValue = '01' then (select grade_id from samsjacksonville.grade where grade_value = '1')
         when gradeValue = '02' then (select grade_id from samsjacksonville.grade where grade_value = '2')
         when gradeValue = '03' then (select grade_id from samsjacksonville.grade where grade_value = '3')
         when gradeValue = '04' then (select grade_id from samsjacksonville.grade where grade_value = '4')
         when gradeValue = '05' then (select grade_id from samsjacksonville.grade where grade_value = '5')
         when gradeValue = '06' then (select grade_id from samsjacksonville.grade where grade_value = '6')
         when gradeValue = '07' then (select grade_id from samsjacksonville.grade where grade_value = '7')
         when gradeValue = '08' then (select grade_id from samsjacksonville.grade where grade_value = '8')
         when gradeValue = '09' then (select grade_id from samsjacksonville.grade where grade_value = '9')
         when gradeValue = '10' then (select grade_id from samsjacksonville.grade where grade_value = '10')
         when gradeValue = '11' then (select grade_id from samsjacksonville.grade where grade_value = '11')
         when gradeValue = '12' then (select grade_id from samsjacksonville.grade where grade_value = '12')
        else (select -1) end;
	
	return (ifnull(gradeID, -1));
end$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `fn_get_description_officevisit_offenses`( p_visit_id INT) RETURNS varchar(255) CHARSET utf8
BEGIN

RETURN(
SELECT GROUP_CONCAT(cc.name SEPARATOR ', ')
FROM office_visit_offense_assn assn
INNER JOIN code_of_conduct_violation cc on 
cc.code_of_conduct_violation_id = assn.code_of_conduct_violation_id
where assn.office_visit_id =  p_visit_id
);

END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `fn_get_description_officevisit_remedial_actions`( p_visit_id INT) RETURNS varchar(255) CHARSET utf8
BEGIN
RETURN(
SELECT GROUP_CONCAT(ra.name SEPARATOR ', ')
FROM office_visit_remedial_action_assn assn
INNER JOIN remedial_action ra on 
ra.remedial_action_id = assn.remedial_action_id
where assn.office_visit_id =  p_visit_id
);

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `samsjacksonville`.`import_student`()
BEGIN
    declare _count int;
    declare _schoolyear int;
    
    SET SQL_SAFE_UPDATES = 0;
    set _schoolyear = (select school_year_id from samsjacksonville.vw_school_year limit 1);
    
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
                -1, 
                now(), 
                -1, 
                now(), 
                0
		from 
			etl.student s;
	END IF;
    SET SQL_SAFE_UPDATES = 1;
    truncate table etl.student;
    
END$$
DELIMITER ;

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

DELIMITER $$
CREATE PROCEDURE `import_homeroom`()
BEGIN
    declare _count int;
    declare _schoolyear int;
    
    SET SQL_SAFE_UPDATES = 0;
    set _schoolyear = (select school_year_id from samsjacksonville.vw_school_year limit 1);
    
    /*Get all Homerooms*/
    DROP TEMPORARY TABLE IF EXISTS homerooms;
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
    insert into samsjacksonville.homeroom (class_room, room_number, school_year_id, school_id)
	(select distinct h.classroom, h.room, _schoolyear, samsjacksonville.fn_getSchoolID(h.school) from homerooms h where h.classroom not in (''));
    
    insert into samsjacksonville.homeroom (class_room, room_number, school_year_id, school_id)
    (select distinct h.room, h.room, _schoolyear, samsjacksonville.fn_getSchoolID(h.school) from homerooms h where h.classroom in (''));
	
    SET SQL_SAFE_UPDATES = 1;
    
    select * from etl.contact;
    DROP TEMPORARY TABLE IF EXISTS homerooms;
    
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE update_school_year(IN schoolyear INT)
BEGIN
    UPDATE school_year
    set is_current = 1 
    where school_year_id = schoolyear;
    
    update school_year
    set is_current = 0
    where school_year_id <> schoolyear;
END $$
DELIMITER ;

/*Create Views*/
-- CREATE TABLE Office Visit Log
-- Insert Statement for Office Visit Log
-- select 'creating view student' '';
create view samsjacksonville.vw_student
as (
	select 
		s.student_id,
        s.student_id_nk,
		s.first_name,
		s.last_name,
		s.school_year_id,
		s.homeroom_id,
        s.school_id,
        sch.name,
        h.class_room,
        h.room_number,
		s.grade_id,
        g.grade_value,
        s.gender,
		s.create_contact_id,
        concat(cc.first_name, ' ', cc.last_name) as create_contact_name,
		s.create_dt,
		s.last_update_contact_id,
        concat(uc.first_name, ' ', uc.last_name) as last_update_contact_name,
		s.last_update_dt
	from 
		student s
	inner join samsjacksonville.school_year sy on 
		sy.school_year_id = s.school_year_id and 
		sy.is_current = 1
	inner join samsjacksonville.grade g on 
		g.grade_id = s.grade_id
	inner join samsjacksonville.contact cc on 
		cc.contact_id = s.create_contact_id
	inner join samsjacksonville.contact uc on 
		uc.contact_id = s.last_update_contact_id
	inner join samsjacksonville.school sch on
		sch.school_id = s.school_id
	left outer join samsjacksonville.homeroom h on
		h.homeroom_id = s.homeroom_id
	where
		s.is_deleted = 0 and
        g.is_deleted = 0 and
        sch.is_deleted = 0 and
        ifnull(h.is_deleted, 0) = 0
);

-- select 'creating view school_year' '';
create view samsjacksonville.vw_school_year
as (
	select
		school_year_id
	from
		samsjacksonville.school_year
	where
		is_current = 1 and
        is_deleted = 0
);

-- select 'creating view remedials' '';
create view samsjacksonville.vw_remedial_action
as (
	select
		ra.remedial_action_id,
		ra.name,
		ra.school_year_id,
		ra.create_contact_id,
        concat(rc.first_name, ' ' , rc.last_name) as create_contact_name,
		ra.create_dt,
		ra.last_update_contact_id,
        concat(uc.first_name, ' ', uc.last_name) as last_update_contact_name,
		ra.last_update_dt,
		ra.is_deleted
	from samsjacksonville.remedial_action ra
	inner join school_year sy 
			on sy.school_year_id = ra.school_year_id and 
			sy.is_current = 1
	inner join samsjacksonville.contact rc on rc.contact_id = ra.create_contact_id
    inner join samsjacksonville.contact uc on uc.contact_id = ra.last_update_contact_id
	where
		ra.is_deleted = 0 and
        sy.is_deleted = 0
);

-- select 'creating view code of conduct violation' '';
create view samsjacksonville.vw_code_of_conduct_violation
as 
(
	select
		ccv.code_of_conduct_violation_id,
		ccv.short_code,
		ccv.name,
		ccv.create_contact_id,
        concat(c.first_name, ' ', c.last_name) as create_contact_name,
		ccv.create_dt,
		ccv.last_update_contact_id,
        concat(u.first_name, ' ', u.last_name) as last_update_contact_name,
		ccv.last_update_dt,
		ccv.is_deleted,
		ccv.school_year_id 
    from samsjacksonville.code_of_conduct_violation ccv
    inner join samsjacksonville.school_year sy 
		on sy.school_year_id = ccv.school_year_id and 
        sy.is_current = 1
	inner join samsjacksonville.contact c on 
		c.contact_id = ccv.create_contact_id
	inner join samsjacksonville.contact u on
		u.contact_id = ccv.last_update_contact_id
	where
		ccv.is_deleted = 0 and
        sy.is_deleted = 0 and
        c.is_deleted = 0 and
        u.is_deleted = 0
);

-- select 'creating view homerooms' '';
create view samsjacksonville.vw_homeroom
as
(
	select
		h.homeroom_id,
		h.class_room,
        h.room_number,
		h.school_id,
		h.school_year_id,
		h.create_contact_id,
        concat(c.first_name, ' ', c.last_name) as create_contact_name,
		h.create_dt,
		h.last_update_contact_id,
        concat(u.first_name, ' ', u.last_name) as last_update_contact_name,
		h.last_update_dt,
		h.is_deleted
    from samsjacksonville.homeroom h
    inner join samsjacksonville.school_year sy on 
		sy.school_year_id = h.school_year_id and 
		sy.is_current = 1
	inner join samsjacksonville.contact c on
		c.contact_id = h.create_contact_id
	inner join samsjacksonville.contact u on
		u.contact_id = h.last_update_contact_id
	where
		h.is_deleted = 0 and
        sy.is_deleted = 0 and
        c.is_deleted = 0 and
        u.is_deleted = 0
);

-- select 'creating view profile' '';
create view samsjacksonville.vw_profile
as
(
	select
		p.profile_id,
		p.contact_id,
		p.user_name,
		p.password,
		p.school_year_id,
		p.create_contact_id,
        concat(c.first_name, ' ', c.last_name) as create_contact_name,
		p.create_dt,
		p.last_update_contact_id,
        concat(u.first_name, ' ', u.last_name) as last_update_contact_name,
		p.last_update_dt,
		p.is_deleted 
    from samsjacksonville.profile p
    inner join samsjacksonville.school_year sy on 
		sy.school_year_id = p.school_year_id and 
		sy.is_current = 1
	inner join samsjacksonville.contact c on
		c.contact_id = p.create_contact_id
	inner join samsjacksonville.contact u on
		u.contact_id = p.last_update_contact_id
	where
		p.is_deleted = 0 and
        sy.is_deleted = 0 and
        c.is_deleted = 0 and
        u.is_deleted = 0
);

-- select 'creating view contact' '';
create view samsjacksonville.vw_contact
as
(
	select
		c.contact_id,
		c.first_name,
        c.last_name,
        c.position,
        c.classroom,
        c.room_number,
        c.room_extension,
        s.name as school_name,
		s.school_id,
		c.email_address,
		c.cell_phone,
        c.school_year_id,
		c.create_contact_id,
		concat(cc.first_name, ' ', cc.last_name) as create_contact_name,
        c.create_dt,
		c.last_update_contact_id,
        concat(uc.first_name, ' ', uc.last_name) as last_update_contact_name,
		c.last_update_dt
    from samsjacksonville.contact c
    inner join samsjacksonville.school_year sy on 
		sy.school_year_id = c.school_year_id and 
		sy.is_current = 1
	inner join samsjacksonville.contact cc on cc.contact_id = c.create_contact_id
    inner join samsjacksonville.contact uc on uc.contact_id = c.last_update_contact_id
    inner join samsjacksonville.school s on s.school_id = c.school_id
    where
		c.is_deleted = 0 and
        cc.is_deleted = 0 and
        uc.is_deleted = 0 and
        sy.is_deleted = 0 and
        s.is_deleted = 0
);

-- select 'creating view grades' '';
create view samsjacksonville.vw_grade
as
(
	select
		g.grade_id,
		g.grade_value,
		g.grade_text,
		g.create_contact_id,
        concat(c.first_name , ' ' , c.last_name) as create_contact_name,
		g.create_dt,
		g.last_update_contact_id,
		g.last_update_dt,
        concat(u.first_name , ' ' , u.last_name) as last_update_contact_name
    from samsjacksonville.grade g
    inner join samsjacksonville.contact c on c.contact_id = g.create_contact_id
    inner join samsjacksonville.contact u on u.contact_id = g.last_update_contact_id
    where
		g.is_deleted = 0 and
        c.is_deleted = 0 and
        u.is_deleted = 0
);

-- select 'creating view schools' '';
create view samsjacksonville.vw_school
as
(
	select
		s.school_id,
		s.name,
		s.create_contact_id,
        concat(c.first_name , ' ' , c.last_name) as create_contact_name,
		s.create_dt,
		s.last_update_contact_id,
        concat(u.first_name , ' ' , u.last_name) as last_update_contact_name,
		s.last_update_dt
	from	
		samsjacksonville.school s
        inner join samsjacksonville.contact c on c.contact_id = s.create_contact_id
        inner join samsjacksonville.contact u on u.contact_id = s.last_update_contact_id
	where
		s.is_deleted = 0 and
        c.is_deleted = 0 and
        u.is_deleted = 0
);

-- select 'creating view content courses' '';
create view samsjacksonville.vw_content_course
as
(
	select
		c.content_course_id,
		c.name,
		c.create_contact_id,
        concat(cc.first_name , ' ' , cc.last_name) as create_contact_name,
		c.create_dt,
		c.last_update_contact_id,
        concat(u.first_name , ' ' , u.last_name) as last_update_contact_name,
		c.last_update_dt,
		c.is_deleted
    from samsjacksonville.content_course c
        inner join samsjacksonville.contact cc on cc.contact_id = c.create_contact_id
        inner join samsjacksonville.contact u on u.contact_id = c.last_update_contact_id
    where
		c.is_deleted = 0 and
        cc.is_deleted = 0 and
        u.is_deleted = 0
);

/*create view office visit */
create view samsjacksonville.vw_office_visit
as
(
	select
		ov.office_visit_id,
        ov.office_visit_dt,
        ov.student_id,
        vs.student_id_nk as 'student_number',
        concat(vs.last_name, ',', vs.first_name) as 'student_name',
        total_visits,
        ov.handled_by_contact_id,
        concat(handledby.first_name , ' ' , handledby.last_name) as handled_by_contact_name,
        ov.nap,
        ov.comments,
        ov.arrival_dt,
        ov.sent_by_contact_id,
        concat(sentby.first_name , ' ' , sentby.last_name) as sent_by_contact_name,
        ov.content_course_id,
        ctc.name as content_course_name,
        g.grade_value,
        sch.name as school_name,
        homeroom.class_room,
        homeroom.room_number,
        ov.last_update_contact_id,
        concat(lastupdate.first_name , ' ' , lastupdate.last_name) as last_update_contact_name,
        ov.last_update_dt,
		`fn_get_description_officevisit_offenses`(ov.office_visit_id) as 'offenses',
        `fn_get_description_officevisit_remedial_actions`(ov.office_visit_id) as 'consequences'

	from
		office_visit ov
        join vw_student vs on vs.student_id = ov.student_id
        join vw_content_course ctc on ctc.content_course_id = ov.content_course_id
        join vw_grade g on g.grade_id = vs.grade_id
        join vw_school sch on sch.school_id = vs.school_id
        join vw_homeroom homeroom on homeroom.homeroom_id = ov.homeroom_id
		join vw_contact sentby on sentby.contact_id = ov.sent_by_contact_id
        left join vw_contact handledby on handledby.contact_id = ov.handled_by_contact_id
	    left join vw_contact lastupdate on lastupdate.contact_id = ov.last_update_contact_id
);

-- select 'creating view offense' '';
/* resets the auto to zero */
create view samsjacksonville.vw_office_visit_offense_assn
as 
(
select
	ovo.office_visit_id,
	ovo.code_of_conduct_violation_id,
	ccv.short_code,
	ccv.name as 'code_conduct_violation_name'
from samsjacksonville.office_visit_offense_assn ovo
inner join code_of_conduct_violation ccv
      on ovo.code_of_conduct_violation_id = ccv.code_of_conduct_violation_id 
);

-- select 'creating view remedial action association' '';
create view samsjacksonville.vw_office_visit_remedial_action_assn
as 
(
select
ovr.office_visit_id,
ovr.remedial_action_id,
ra.name as 'remedial_action_name'

from samsjacksonville.office_visit_remedial_action_assn ovr

inner join remedial_action ra
      on ovr.remedial_action_id = ra.remedial_action_id  
);
