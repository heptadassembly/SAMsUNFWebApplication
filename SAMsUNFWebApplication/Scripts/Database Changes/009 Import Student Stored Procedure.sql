drop procedure if exists `samsjacksonville`.`import_student`;

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
