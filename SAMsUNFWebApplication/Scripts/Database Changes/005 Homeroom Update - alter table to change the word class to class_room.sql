use samsjacksonville;

alter table samsjacksonville.homeroom
change `class` `class_room` varchar(50);

drop view if exists samsjacksonville.vw_homeroom;

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
		h.is_deleted,
        h.class_room as 'homeroom_name'
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