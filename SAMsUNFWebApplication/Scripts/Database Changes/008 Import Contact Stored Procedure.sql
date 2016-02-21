drop procedure if exists `samsjacksonville`.`import_contact`;

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
    truncate table etl.contact;
    
END$$
DELIMITER ;
