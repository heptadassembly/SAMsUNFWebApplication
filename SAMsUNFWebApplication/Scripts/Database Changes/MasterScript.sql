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

/* Add SAMs User*/
GRANT ALL PRIVILEGES 
    ON `samsjacksonville` . * TO 'KIPPDemo'@'localhost' IDENTIFIED 
BY 'KIPPDemo';

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

DROP TABLE if exists etl.contact;
DROP TABLE if exists etl.student;

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
    homeroom_name varchar(50),
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

insert into gender values ('Unknown');
insert into gender values ('M - Male');
insert into gender values ('F - Female');

CREATE TABLE if not exists etl.contact
(
	lastname varchar(800),
	firstname varchar(800),
	`position` varchar(800),
	classroom varchar(800),
	school varchar(800),
	room varchar(800),
	roomextension varchar(800),
	email varchar(800),
	cell varchar(800)
);

CREATE TABLE if not exists etl.student
(
	studentid varchar(800),
	last varchar(800),
	first varchar(800),
	grade varchar(800),
	school varchar(800),
	gender varchar(800)
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
    inner join samsjacksonville.homeroom s on s.homeroom_name = es.classroom and s.school_year_id = _schoolyear;
    
    delete es
    from homerooms es
    inner join samsjacksonville.homeroom s on s.homeroom_name = es.room and s.school_year_id = _schoolyear;
    
    /*Populate the Homeroom Table*/
    insert into samsjacksonville.homeroom (homeroom_name, room_number, school_year_id, school_id)
	(select distinct h.classroom, h.room, _schoolyear, samsjacksonville.fn_getSchoolID(h.school) from homerooms h where h.classroom not in (''));
    
    insert into samsjacksonville.homeroom (homeroom_name, room_number, school_year_id, school_id)
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
        h.homeroom_name,
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

-- drop view samsjacksonville.vw_code_of_conduct_violation
-- select 'creating view code of conduct violation' '';
create view samsjacksonville.vw_code_of_conduct_violation
as 
(
	select
		ccv.code_of_conduct_violation_id,
        ccv.duval_violation_code,
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
		h.homeroom_name,
        h.room_number,
		h.school_id,
        sl.name as school_name,
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
	inner join samsjacksonville.school sl on
		sl.school_id = h.school_id
	where
		h.is_deleted = 0 and
        sy.is_deleted = 0 and
        c.is_deleted = 0 and
        u.is_deleted = 0
);

-- select 'creating view profile' '';
CREATE VIEW `samsjacksonville`.`vw_profile` 
AS
 (
	 SELECT 
			`p`.`profile_id` AS `profile_id`,
			`p`.`contact_id` AS `contact_id`,
			`p`.`user_name` AS `user_name`,
			`cc`.`first_name`,
			`cc`.`last_name`,
			`p`.`password` AS `password`,
			`p`.`school_year_id` AS `school_year_id`,
			`p`.`create_contact_id` AS `create_contact_id`,
			CONCAT(`c`.`first_name`, ' ', `c`.`last_name`) AS `create_contact_name`,
			`p`.`create_dt` AS `create_dt`,
			`p`.`last_update_contact_id` AS `last_update_contact_id`,
			CONCAT(`u`.`first_name`, ' ', `u`.`last_name`) AS `last_update_contact_name`,
			`p`.`last_update_dt` AS `last_update_dt`,
			`p`.`is_deleted` AS `is_deleted`
		FROM
			`samsjacksonville`.`profile` `p`
			JOIN `samsjacksonville`.`school_year` `sy` ON `sy`.`school_year_id` = `p`.`school_year_id`
				AND `sy`.`is_current` = 1
			JOIN `samsjacksonville`.`contact` `cc` ON `cc`.`contact_id` = `p`.`contact_id`
			JOIN `samsjacksonville`.`contact` `c` ON `c`.`contact_id` = `p`.`create_contact_id`
			JOIN `samsjacksonville`.`contact` `u` ON `u`.`contact_id` = `p`.`last_update_contact_id`
		WHERE
			`p`.`is_deleted` = 0
				AND `sy`.`is_deleted` = 0
				AND `c`.`is_deleted` = 0
				AND `u`.`is_deleted` = 0
);

-- drop view samsjacksonville.vw_contact
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
        case when length(
        concat("(",left(replace(replace(replace(replace(replace(c.cell_phone, '-', ''), '?', ''), '(', ''), ')', ''), ' ', ''), 3),") ",
			mid(replace(replace(replace(replace(replace(c.cell_phone, '-', ''), '?', ''), '(', ''), ')', ''), ' ', ''), 4, 3), "-",
            right(replace(replace(replace(replace(replace(c.cell_phone, '-', ''), '?', ''), '(', ''), ')', ''), ' ', ''), 4))) <> 14 then ''
            else 
            concat("(",left(replace(replace(replace(replace(replace(c.cell_phone, '-', ''), '?', ''), '(', ''), ')', ''), ' ', ''), 3),") ",
			mid(replace(replace(replace(replace(replace(c.cell_phone, '-', ''), '?', ''), '(', ''), ')', ''), ' ', ''), 4, 3), "-",
            right(replace(replace(replace(replace(replace(c.cell_phone, '-', ''), '?', ''), '(', ''), ')', ''), ' ', ''), 4))
            end
            as cell_phone,
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
        homeroom.homeroom_name,
        homeroom.room_number,
		homeroom.homeroom_id,
        ov.last_update_contact_id,
        concat(lastupdate.first_name , ' ' , lastupdate.last_name) as last_update_contact_name,
        ov.last_update_dt,
		`fn_get_description_officevisit_offenses`(ov.office_visit_id) as 'offenses',
        `fn_get_description_officevisit_remedial_actions`(ov.office_visit_id) as 'consequences'

	from
		office_visit ov
        join school_year sy on  sy.is_current = 1
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

drop view if exists vw_office_visits_by_homeroom;
drop view if exists vw_office_visits_by_offense_type;
drop view if exists vw_office_visits_by_teacher;
drop view if exists vw_office_visits_by_weekly_count;

create view vw_office_visits_by_homeroom
as 
(
    select
        sch.name as 'school_name',
        h.homeroom_name,
        g.grade_value as 'grade',
		count(ov.office_visit_id) as total_visits
		from office_visit ov
    inner join school_year sy on  sy.is_current = 1
    inner join student s on s.student_id = ov.student_id
    and s.school_year_id  = sy.school_year_id
	inner join homeroom h on h.homeroom_id = ov.homeroom_id
    inner join school sch on sch.school_id = h.school_id 
    inner join grade g on g.grade_id = s.grade_id 
    inner join content_course cc on cc.content_course_id = ov.content_course_id 
    left join contact  sentby on sentby.contact_id  = ov.sent_by_contact_id
    left join contact handledby on handledby.contact_id  = ov.handled_by_contact_id
    inner join contact updatedby on updatedby.contact_id  = ov.last_update_contact_id
    Group by g.grade_value,Sch.name, h.homeroom_name
    order by total_visits desc
);

create view vw_office_visits_by_teacher
as 
(
    select
        concat(sentby.first_name , ' ' , sentby.last_name) as 'sent_by_contact_name',
		count(ov.office_visit_id) as total_visits
		from office_visit ov
    inner join school_year sy on  sy.is_current = 1
    inner join student s on s.student_id = ov.student_id
    and s.school_year_id  = sy.school_year_id
	inner join homeroom h on h.homeroom_id = s.homeroom_id
    inner join school sch on sch.school_id = h.school_id 
    inner join grade g on g.grade_id = s.grade_id 
    inner join content_course cc on cc.content_course_id = ov.content_course_id 
    left join contact  sentby on sentby.contact_id  = ov.sent_by_contact_id
    left join contact handledby on handledby.contact_id  = ov.handled_by_contact_id
    inner join contact updatedby on updatedby.contact_id  = ov.last_update_contact_id
    Group  by sentby.last_name,sentby.first_name
    order by total_visits desc
);

create view vw_office_visits_by_offense_type
as 
(
 select
        
     	cc.name as 'offense_type',
        count(ov.office_visit_id) as total_visits
	   
		from office_visit ov
		inner join office_visit_offense_assn ovoa on ovoa.office_visit_id = ov.office_visit_id
	    inner join code_of_conduct_violation cc on  cc.code_of_conduct_violation_id = ovoa.code_of_conduct_violation_id
        inner join school_year sy on  sy.is_current = 1
        inner join student s on s.student_id = ov.student_id
		 and s.school_year_id  = sy.school_year_id
        
        Group  by cc.name
        order by total_visits desc
);

create view vw_office_visits_by_weekly_count
as 
(
  select
	str_to_date(concat(yearweek(office_visit_dt), ' monday'), '%X%V %W') as 'Monday',
    count(*) as total_visits
      
      from office_visit ov
       inner join school_year sy on  sy.is_current = 1
        inner join student s on s.student_id = ov.student_id
		and s.school_year_id  = sy.school_year_id
      group by yearweek(office_visit_dt)
);

/* Inserts*/


/* Begin Inserts */

-- Insert Statement for School Year
INSERT INTO samsjacksonville.school_year values (20152016, 1, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school_year values (20162017, 0, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school_year values (20172018, 0, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school_year values (20182019, 0, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school_year values (20192020, 0, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school_year values (20202021, 0, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school_year values (20212022, 0, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school_year values (20222023, 0, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school_year values (20232024, 0, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school_year values (20242025, 0, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school_year values (20252026, 0, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school_year values (20262027, 0, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school_year values (20272028, 0, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school_year values (20282029, 0, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school_year values (20292030, 0, -1, now(), -1, now(), 0);

ALTER TABLE samsjacksonville.school AUTO_INCREMENT = 0;
/* INSERT STATEMENT FOR SCHOOL */
INSERT INTO samsjacksonville.school values (-1, 'Unknown', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school values (1, 'KIPP:VOICE', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school values (2, 'KIPP:IMPACT', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school values (3, 'KIPP:KJE', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school values (4, 'Regional', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.school values (5, 'VOICE/KJE', -1, now(), -1, now(), 0);

ALTER TABLE samsjacksonville.contact AUTO_INCREMENT = 0;
/* INSERT STATEMENT FOR CONTACT */
INSERT INTO samsjacksonville.contact values (-1, 'Unknown', 'Unknown', '', '', '', '', -1, '', '', null, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.contact values (1, 'NeQuana', 'Alexander', 'Student Support Specialist', '', '322', '322', fn_getSchoolID('Impact'), 'nalexander@kippjax.org', '9043824952', 20152016, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.contact values (2, 'Erin', 'Almond', 'KTC-Alumni', '', '114', '114', fn_getSchoolID('Regional'), 'ealmond@kippjax.org', '9043821299', 20152016, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.contact values (3, 'Warren', 'Buck', 'School Leader', '', '411', '411', 2, 'wbuck@kippjax.org', '9047900868', 20152016, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.contact values (4, 'Lynneshia', 'Coffee', 'ASL', '', '117C', '?', fn_getSchoolID('VOICE/KJE'), 'lcoffee@kippjax.org', '9045358607', 20152016, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.contact values (5, 'Alyse', 'Barry', 'Kindergarten', 'UF', '132', '132', fn_getSchoolID('VOICE'), 'abarry@kippjax.org', '9043823054', 20152016, -1, now(), -1, now(), 0);

ALTER TABLE samsjacksonville.grade AUTO_INCREMENT = 0;
/* INSERT STATEMENT FOR GRADE */
INSERT INTO samsjacksonville.grade (grade_value, grade_text, create_contact_id, create_dt, last_update_contact_id, last_update_dt, is_deleted) 
	values ('NA','Not Applicable',-1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.grade (grade_value, grade_text, create_contact_id, create_dt, last_update_contact_id, last_update_dt, is_deleted) 
	values ('VPK',	'Pre-Kindergarten', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.grade (grade_value, grade_text, create_contact_id, create_dt, last_update_contact_id, last_update_dt, is_deleted) 
	values ('K','Kindergarten', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.grade (grade_value, grade_text, create_contact_id, create_dt, last_update_contact_id, last_update_dt, is_deleted) 
	values ('1','First', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.grade (grade_value, grade_text, create_contact_id, create_dt, last_update_contact_id, last_update_dt, is_deleted) 
	values ('2','Second', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.grade (grade_value, grade_text, create_contact_id, create_dt, last_update_contact_id, last_update_dt, is_deleted) 
	values ('3', 'Third',-1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.grade (grade_value, grade_text, create_contact_id, create_dt, last_update_contact_id, last_update_dt, is_deleted) 
	values ('4', 'Fourth', 	-1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.grade (grade_value, grade_text, create_contact_id, create_dt, last_update_contact_id, last_update_dt, is_deleted) 
	values ('5', 'Fifth', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.grade (grade_value, grade_text, create_contact_id, create_dt, last_update_contact_id, last_update_dt, is_deleted) 
	values ('6', 'Sixth', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.grade (grade_value, grade_text, create_contact_id, create_dt, last_update_contact_id, last_update_dt, is_deleted) 
	values ('7', 'Seventh', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.grade (grade_value, grade_text, create_contact_id, create_dt, last_update_contact_id, last_update_dt, is_deleted) 
	values ('8', 'Eighth', 	-1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.grade (grade_value, grade_text, create_contact_id, create_dt, last_update_contact_id, last_update_dt, is_deleted) 
	values ('9', 'Ninth', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.grade (grade_value, grade_text, create_contact_id, create_dt, last_update_contact_id, last_update_dt, is_deleted) 
	values ('10', 'Tenth', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.grade (grade_value, grade_text, create_contact_id, create_dt, last_update_contact_id, last_update_dt, is_deleted) 
	values ('11', 'Eleventh', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.grade (grade_value, grade_text, create_contact_id, create_dt, last_update_contact_id, last_update_dt, is_deleted) 
	values ('12', 'Twelfth', -1, now(), -1, now(), 0);

ALTER TABLE samsjacksonville.profile AUTO_INCREMENT = 0;
/* INSERT STATEMENT FOR PROFILE */
INSERT INTO samsjacksonville.profile values (1, 3, 'wbuck', 'password', 20152016, -1, now(), -1, now(), 0);


ALTER TABLE samsjacksonville.homeroom AUTO_INCREMENT = 0;
/* INSERT STATEMENT FOR HOMEROOM */
INSERT INTO samsjacksonville.homeroom values (-1, 'Other', '', -1, 20152016, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.homeroom values (1, 'Grambling State', '112', fn_getSchoolId('Voice'), 20152016, -1, now(), -1, now(), 0);
INSERT INTO  samsjacksonville.homeroom VALUES(2,'Berea','113',2,20152016,-1,now(),-1,now(),0);
INSERT INTO samsjacksonville.homeroom VALUES(3,'Wisconsin','113',3,20152016,-1,now(),-1,now(),0);
INSERT INTO samsjacksonville.homeroom VALUES(4,'Oberlin','111',1,20152016,-1,now(),-1,now(),0);


ALTER TABLE samsjacksonville.student AUTO_INCREMENT = 0;
/* INSERT STATEMENT FOR STUDENT */
INSERT INTO samsjacksonville.student values (1, '20009764', 'Darrell', 'Blackman', fn_getSchoolID('C-KIPP Jacksonville K-8 - 5581'), 20152016, -1, fn_getGradeID('KG'), 'M - Male', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.student values(2,'13272','N Isiah','Agyekum',1,20152016,1,4,'M-Male',1,DATE_SUB(NOW(), INTERVAL 7 DAY),1,DATE_SUB(NOW(), INTERVAL 7 DAY),0);
INSERT INTO samsjacksonville.student values(3,'1212311','Alexis','Allen',1,20152016,1,4,'M-Male',1,DATE_SUB(NOW(), INTERVAL 5 DAY),1,DATE_SUB(NOW(), INTERVAL 5 DAY),0);
INSERT INTO samsjacksonville.student values(4,'324567','Naiser','Bell',1,20152016,1,5,'M-Male',1,DATE_SUB(NOW(), INTERVAL 5 DAY),1,DATE_SUB(NOW(), INTERVAL 5 DAY),0);
INSERT INTO samsjacksonville.student values(5,'7685493-1','Tammy','Grimes',1,20152016,1,6,'F-Female',1,DATE_SUB(NOW(), INTERVAL 5 DAY),1,DATE_SUB(NOW(), INTERVAL 5 DAY),0);

ALTER TABLE samsjacksonville.content_course AUTO_INCREMENT = 0;
/* INSERT STATEMENT FOR CONTENT COURSE */
INSERT INTO samsjacksonville.content_course values (-1, 'Other', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.content_course values (1, 'Reading', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.content_course values (2, 'Writing', -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.content_course values (3, 'Geometry', -1, now(), -1, now(), 0);

ALTER TABLE samsjacksonville.code_of_conduct_violation AUTO_INCREMENT = 0;
/* INSERT STATEMENT FOR CODE OF CONDUCT VIOLATIONS */
INSERT INTO samsjacksonville.code_of_conduct_violation values (1, 'OTHR', 'NA', 'Other', -1, now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (2, '1.01', 'ZZZ','Disruption in Class',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (3, '1.02', 'ZZZ','Illegal Organization',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (4, '1.03', 'ZZZ','Disorder Outside of Class',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (5, '1.04', 'ZZZ','Tardiness',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (6, '1.05', 'ZZZ','USE of Abusive, Profane, or Obscene Language or Gestures towards another Student',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (7, '1.06', 'ZZZ','Nonconformity to the General Code of Appearance',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (8, '1.07', 'ZZZ','Inappropriate Public Display of Affection',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (9, '1.08', 'ZZZ','Unauthorized Absence from Class or School day activity but remaining on campus (Skipping)',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (10, '1.09', 'ZZZ','Unauthorized USE of Wireless Communication Devices or Cell Phone',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (11, '1.1', 'ZZZ','Failure to Follow Instructions on the School Bus',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (12, '2.01', 'ZZZ','Failure to Follow Directions Relating to Safety and Order in Class, School, or School-Sponsored Activities',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (13, '2.02', 'TBC','Use, Possession, Distribution, or Sale of Tobacco/Nicotine or Tobacco/Nicotine Products',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (14, '2.03', 'ZZZ','Distribution, Possession, Sale or Purchase of Drug/Facsimile Products',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (15, '2.04', 'ZZZ','Possession and/or USE of Matches or Lighters',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (16, '2.05', 'ZZZ','Intentional Threat of a School District Employee or Agent',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (17, '2.06', 'ZZZ','Intentional Threat of a Student',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (18, '2.07', 'PHA','Intentionally Striking another Student',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (19, '2.08', 'ZZZ','Dispute',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (20, '2.09', 'FIT','Fighting (Mutual combat, mutual altercation)',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (21, '2.1', 'FIT','Initiating a Fight',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (22, '2.11', 'FIT','Fighting or Striking a student on a School Bus',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (23, '2.12', 'ZZZ','Response to Physical Attack (ZZZ) Response to Physical Attack â€“',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (24, '2.13', 'ZZZ','USE of a Device to Record a Fight or School Board Employee',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (25, '2.14', 'ZZZ','Premeditated USE of a Device to Record a Fight â€“',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (26, '2.15', 'ZZZ','Vandalism-2.15',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (27, '2.16', 'ZZZ','Stealing or USE of Counterfeit Bill',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (28, '2.17', 'ZZZ','Possession of Stolen Property',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (29, '2.18', 'ZZZ','Teasing/Intimidation/Ridicule',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (30, '2.19', 'TRS','Trespassing-2.19',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (31, '2.2', 'ZZZ','Possession of Fireworks, Firecrackers, Smoke Bombs, or Flammable Materials',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (32, '2.21', 'ZZZ','Verbal Sexual Harassment ',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (33, '2.22', 'ZZZ','Directing Obscene, Profane, or Offensive Language or Gestures to a School District Employee or Agent',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (34, '2.23', 'ZZZ','Leaving School Grounds or the Site of Any School Activity without permission',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (35, '2.24', 'ZZZ','False Information',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (36, '2.25', 'ZZZ','Refusal to Attend or Participate in Other Previously Assigned Discipline',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (37, '2.26', 'ZZZ','Inappropriate USE of Instructional Technology or an Electronic Device',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (38, '2.27', 'ZZZ','Gambling',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (39, '2.28', 'ZZZ','Failure to Adhere to Safety Considerations on School Bus',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (40, '2.29', 'ZZZ','Cheating and/or Copying the Work of Others',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (41, '2.3', 'ZZZ','Extortion',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (42, '2.31', 'ZZZ','Unjustified Activation of Bus Emergency System while the bus is not moving',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (43, '2.32', 'ZZZ','Gang Activity or Expression',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (44, '3.01', 'ALC','Alcohol-3.01',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (45, '3.02', 'DRU','Drugs-3.02',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (46, '3.03', 'PHA','Striking a School Distric Employee or Agent',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (47, '3.04', 'ROB','Robbery (using force to take something from another)',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (48, '3.05', 'STL','Stealing/Larcency/Theft',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (49, '3.06', 'BRK','Burglary of School Structure',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (50, '3.07', 'ZZZ','Vandalism-3.07',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (51, '3.08', 'ZZZ','Possession of Prohibited Substance or Objects',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (52, '3.09', 'ZZZ','Lewd, Indecent, or Offensive Behavior',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (53, '3.1', 'SXH','Physical Sexual Harassment',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (54, '3.11', 'SXO','Sexual Offenses',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (55, '3.12', 'BAT','Striking of a Student, School District Employee or Agent Resulting in Bodily Harm',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (56, '3.13', 'DOC','Inciting or Participating in Major Student Disorder',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (57, '3.14', 'DOC','Unjustified Action of a Fire Alarm System',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (58, '3.15', 'DOC','Unjustified Activation of Bus Emergency Systems while the Bus is Moving',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (59, '3.16', 'ZZZ','Defamation of Character',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (60, '3.17', 'ZZZ','Stalking',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (61, '3.18', 'ZZZ','Unauthorized USE of Instructional Technology',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (62, '3.19', 'OMC','Major Dispute or Altercation',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (63, '3.2', 'TRE','Repeated Threats Upon a School District Employee, Student, or Agent',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (64, '3.21', 'BUL','Bullying/Cyberbullying',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (65, '3.22', 'SXA','Sexual Assault',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (66, '3.23', 'TRS','Trespassing-3.23',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (67, '3.24', 'ZZZ','Teen Dating Violence or Abuse',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (68, '3.25', 'HAR','Harassment',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (69, '3.27', 'OMC','Drug/Alcohol Paraphernalia',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (70, '4.01', 'ALC', 'Alcohol-4.01',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (71, '4.02', 'DRD','Drugs-4.02',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (72, '4.03', 'ARS','Arson',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (73, '4.04', 'ROB','Armed Robbery',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (74, '4.05', 'WPO','Possession of a Firearm',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (75, '4.06', 'WPO','USE of a Deadly Weapon',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (76, '4.07', 'WPO','USE of a Prohibited Object or Substance (See Code 3.08)',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (77, '4.08', 'DOC','Bomb Threats',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (78, '4.09', 'WPO','**Explosives',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (79, '4.1', 'SXB','Sexual Battery/Rape',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (80, '4.11', 'BAT','Aggravated Battery',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (81, '4.12', 'TRE','Aggravated Stalking',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (82, '4.13', 'OMC','Any Major Offense Which Is Reasonably Likely to CaUSE Great Bodily Harm or Serious Disruption of the Educational Process',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (83, '4.14', 'KID','Kidnapping/Abduction',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (84, '4.15', 'HOM','Homicide/Murder/Manslaughter',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (85, '4.16', 'VAN','Vandalism-4.16',-1,now(), -1, now(), 0, 20152016);

/* INSERT STATEMENTS FOR REMEDIAL ACTIONS */
-- Insert Statement for Remedial Action
ALTER TABLE samsjacksonville.remedial_action AUTO_INCREMENT = 0;
INSERT INTO samsjacksonville.remedial_action values (1, 'Other',20152016,-1,now(),-1,now(),0);
INSERT INTO samsjacksonville.remedial_action values (2, 'Office Visit',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (3, 'Office Visit w/ Parent',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (4, 'Work Detail',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (5, 'Teacher/Student/Administrator Conference',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (6, 'Detention',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (7, 'Parent/Teacher/Student Phone Conference and Planned Discussion',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (8, 'Parent/Teacher/Student/Administrator Conferenece and Behavior Contract',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (9, 'ISSP - Short Term',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (10, 'ISSP - Long Term',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (11, 'Behavior Plan',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (12, 'Warning',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (13, 'Contract',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (14, 'Referral - Intervention Team',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (15, 'Referral - Hearing Office',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (16, 'Referral - Expulsion Team',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (17, 'Confiscation',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (18, 'Suspension - Bus',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (19, 'Suspension - Extracurricular Actvities',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (20, 'Suspension - Computers/Technology',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (21, 'OSS - Short Term',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (22, 'OSS - Long Term',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (23, 'Mentor/Tutor Assigned',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (24, 'Lesson Related to the Offense',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (25, 'Arrested',20152016,-1,now(), -1, now(),0);


/*add soome office visits*/
ALTER TABLE samsjacksonville.office_visit AUTO_INCREMENT = 0;

INSERT INTO samsjacksonville.office_visit VALUES(1,20152016,1,1,2,5,DATE_SUB(NOW(), INTERVAL 15 DAY),DATE_SUB(NOW(), INTERVAL 15 DAY),1,0,'corrected behavior',1,DATE_SUB(NOW(), INTERVAL 15 DAY),0,2);
INSERT INTO samsjacksonville.office_visit_offense_assn VALUES(1,2);
INSERT INTO samsjacksonville.office_visit_remedial_action_assn VALUES(1,2);


INSERT INTO samsjacksonville.office_visit VALUES(2,20152016,1,2,2,5,DATE_SUB(NOW(), INTERVAL 12 DAY),DATE_SUB(NOW(), INTERVAL 12 DAY),1,0,'corrected behavior',1,DATE_SUB(NOW(), INTERVAL 12 DAY),0,2);
INSERT INTO samsjacksonville.office_visit_offense_assn VALUES(2,2);
INSERT INTO samsjacksonville.office_visit_remedial_action_assn VALUES(2,2);

INSERT INTO samsjacksonville.office_visit VALUES(3,20152016,2,1,1,2,DATE_SUB(NOW(), INTERVAL 11 DAY),DATE_SUB(NOW(), INTERVAL 11 DAY),1,0,'corrected behavior',1,DATE_SUB(NOW(), INTERVAL 11 DAY),0,3);
INSERT INTO samsjacksonville.office_visit_offense_assn VALUES(3,5);
INSERT INTO samsjacksonville.office_visit_remedial_action_assn VALUES(3,12);

INSERT INTO samsjacksonville.office_visit VALUES(4,20152016,3,1,1,3,DATE_SUB(NOW(), INTERVAL 1 DAY),DATE_SUB(NOW(), INTERVAL 1 DAY),1,0,'corrected behavior',1,DATE_SUB(NOW(), INTERVAL 1 DAY),0,1);
INSERT INTO samsjacksonville.office_visit_offense_assn VALUES(4,6);
INSERT INTO samsjacksonville.office_visit_remedial_action_assn VALUES(4,6);


INSERT INTO samsjacksonville.office_visit VALUES(5,20152016,4,1,1,5,DATE_SUB(NOW(), INTERVAL 2 DAY),DATE_SUB(NOW(), INTERVAL 2 DAY),1,0,'corrected behavior',1,DATE_SUB(NOW(), INTERVAL 2 DAY),0,4);
INSERT INTO samsjacksonville.office_visit_offense_assn VALUES(5,10);
INSERT INTO samsjacksonville.office_visit_remedial_action_assn VALUES(5,17);

INSERT INTO samsjacksonville.office_visit VALUES(6,20152016,4,2,2,4,DATE_SUB(NOW(), INTERVAL 2 DAY),DATE_SUB(NOW(), INTERVAL 2 DAY),2,0,'corrected behavior',2,DATE_SUB(NOW(), INTERVAL 2 DAY),0,4);
INSERT INTO samsjacksonville.office_visit_offense_assn VALUES(6,19);
INSERT INTO samsjacksonville.office_visit_remedial_action_assn VALUES(6,11);

/* Deliverable 6 SQL changes */

/*Added cell phone formatting so the UI will recognize and display cell phones 
uniformly regarless of the actual format of the cell phone in the database.*/

drop view samsjacksonville.vw_contact;
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
        case when length(
        concat("(",left(replace(replace(replace(replace(replace(c.cell_phone, '-', ''), '?', ''), '(', ''), ')', ''), ' ', ''), 3),") ",
			mid(replace(replace(replace(replace(replace(c.cell_phone, '-', ''), '?', ''), '(', ''), ')', ''), ' ', ''), 4, 3), "-",
            right(replace(replace(replace(replace(replace(c.cell_phone, '-', ''), '?', ''), '(', ''), ')', ''), ' ', ''), 4))) <> 14 then ''
            else 
            concat("(",left(replace(replace(replace(replace(replace(c.cell_phone, '-', ''), '?', ''), '(', ''), ')', ''), ' ', ''), 3),") ",
			mid(replace(replace(replace(replace(replace(c.cell_phone, '-', ''), '?', ''), '(', ''), ')', ''), ' ', ''), 4, 3), "-",
            right(replace(replace(replace(replace(replace(c.cell_phone, '-', ''), '?', ''), '(', ''), ')', ''), ' ', ''), 4))
            end
            as cell_phone,
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


/* Problem with the code of conduct view in that it was missing the duval_violation_code value.
Added the code into the view */

drop view samsjacksonville.vw_code_of_conduct_violation;
-- select 'creating view code of conduct violation' '';
create view samsjacksonville.vw_code_of_conduct_violation
as 
(
	select
		ccv.code_of_conduct_violation_id,
        ccv.duval_violation_code,
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

/* Homeroom was showing school_id but needed to show school_name.  Linked the homeroom view
to the school and added school_name as a viable field. */

drop view samsjacksonville.vw_homeroom;

-- select 'creating view homerooms' '';
create view samsjacksonville.vw_homeroom
as
(
	select
		h.homeroom_id,
		h.homeroom_name,
        h.room_number,
		h.school_id,
        sl.name as school_name,
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
	inner join samsjacksonville.school sl on
		sl.school_id = h.school_id
	where
		h.is_deleted = 0 and
        sy.is_deleted = 0 and
        c.is_deleted = 0 and
        u.is_deleted = 0
);

﻿-- Function to get contactID from profile
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



-- add user_name to student table
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

