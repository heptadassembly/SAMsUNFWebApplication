use samsjacksonville;
drop procedure import_student;
DELIMITER $$
CREATE PROCEDURE `import_student`()
BEGIN
	declare _count int;
    declare _studentid varchar(40);
    declare _schoolyear int;
    declare _gradeid int;
    declare _studentExistsCheck int;
    
    set _studentExistsCheck = 0;
    
    set _count = (select count(*) from etl.student);

    set _schoolyear = (select school_year_id from samsjacksonville.vw_school_year limit 1);
    
	select _count, _studentid, _schoolyear;
    
    select 'Begin Student Import Loop' as '';
    
    while _count > 0 do
    
    /*Get the first student information and attempt to load into the system.*/
	set _studentid = (select studentId from etl.student where studentid not in (select student_id_nk from samsjacksonville.student) limit 1);
    
    /*check if student already exists in the system*/
	select 'Student ID = ' + _studentid;
    
    select _studentExistsCheck = count(*) from samsjacksonville.student where student_id_nk = _studentid;

	/*
    IF n > m THEN SET s = '>';
    ELSEIF n = m THEN SET s = '=';
    ELSE SET s = '<';
    END IF;
    */
    
    IF _studentExistsCheck > 0 THEN select 'Error';
    else
		insert into
			samsjacksonville.student (student_id_nk, first_name, last_name, school_id, school_year_id, 
			homeroom_id, grade_id, gender, create_contact_id, create_dt, last_update_contact_id, last_update_dt,
			is_deleted)
		select 
			_studentid, s.first, s.last, samsjacksonville.fn_getSchoolID(s.school), 
			_schoolyear, -1, samsjacksonville.fn_getGradeID(s.grade),  s.gender, -1, now(), -1, now(), 0
		from 
			etl.student s
		where 
			s.studentid = _studentid;
	END IF;
    set _count = _count - 1;
        
	end while;	
    
    truncate table etl.student;
    
END$$
DELIMITER ;
