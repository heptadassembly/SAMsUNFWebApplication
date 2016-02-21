drop view if exists samsjacksonville.vw_contact;

CREATE 
VIEW `samsjacksonville`.`vw_contact` AS
    (SELECT 
        `c`.`contact_id` AS `contact_id`,
        `c`.`first_name` AS `first_name`,
        `c`.`last_name` AS `last_name`,
        `c`.`position` AS `position`,
        `c`.`classroom` AS `classroom`,
        `c`.`room_number` AS `room_number`,
        `c`.`room_extension` AS `room_extension`,
        `c`.`school_id` AS `school_id`,
        `s`.`name` AS `school_name`,
        `c`.`email_address` AS `email_address`,
        `c`.`cell_phone` AS `cell_phone`,
        `c`.`school_year_id` AS `school_year_id`,
        `c`.`create_contact_id` AS `create_contact_id`,
        CONCAT(`cc`.`first_name`, ' ', `cc`.`last_name`) AS `create_contact_name`,
        `c`.`create_dt` AS `create_dt`,
        `c`.`last_update_contact_id` AS `last_update_contact_id`,
        CONCAT(`uc`.`first_name`, ' ', `uc`.`last_name`) AS `last_update_contact_name`,
        `c`.`last_update_dt` AS `last_update_dt`
    FROM
        ((((`samsjacksonville`.`contact` `c`
        JOIN `samsjacksonville`.`school_year` `sy` ON (((`sy`.`school_year_id` = `c`.`school_year_id`)
            AND (`sy`.`is_current` = 1))))
        JOIN `samsjacksonville`.`contact` `cc` ON ((`cc`.`contact_id` = `c`.`create_contact_id`)))
        JOIN `samsjacksonville`.`contact` `uc` ON ((`uc`.`contact_id` = `c`.`last_update_contact_id`)))
        JOIN `samsjacksonville`.`school` `s` ON ((`s`.`school_id` = `c`.`school_id`)))
    WHERE
        ((`c`.`is_deleted` = 0)
            AND (`cc`.`is_deleted` = 0)
            AND (`uc`.`is_deleted` = 0)
            AND (`sy`.`is_deleted` = 0)
            AND (`s`.`is_deleted` = 0)));
