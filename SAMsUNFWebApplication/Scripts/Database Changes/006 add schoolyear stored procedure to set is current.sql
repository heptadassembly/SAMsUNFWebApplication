drop procedure if exists update_school_year;

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