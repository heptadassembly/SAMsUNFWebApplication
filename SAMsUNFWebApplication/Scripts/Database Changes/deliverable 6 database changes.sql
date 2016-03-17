/* Deliverable 6 SQL changes */

/*Added cell phone formatting so the UI will recognize and display cell phones 
uniformly regarless of the actual format of the cell phone in the database.*/

drop view samsjacksonville.vw_contact
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

drop view samsjacksonville.vw_code_of_conduct_violation
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