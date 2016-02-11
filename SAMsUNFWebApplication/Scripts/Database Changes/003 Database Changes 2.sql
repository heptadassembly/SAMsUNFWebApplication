use samsjacksonville;

drop table if exists samsjacksonville.gender;

create table gender(gender varchar(20));

insert into gender values ('Unknown');
insert into gender values ('M - Male');
insert into gender values ('F - Female');

drop function if exists samsjacksonville.fn_getSchoolYear;
delimiter $$
create function `fn_getSchoolYear` (param INT) RETURNS int(11)
	DETERMINISTIC
begin
	declare schoolYearID int;
    set schoolYearID = (select school_year_id from vw_school_year limit 1);
    return (ifnull(schoolYearID, -1));
end$$
delimiter;

