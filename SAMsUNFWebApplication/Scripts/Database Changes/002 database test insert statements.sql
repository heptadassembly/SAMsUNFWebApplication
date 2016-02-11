
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
INSERT INTO samsjacksonville.contact values (6, 'Bad', 'Contact', 'PreSkool', 'UF', '132', '132', fn_getSchoolID('ABCD'), 'abarry@kippjax.org', '9043823054', 20152016, -1, now(), -1, now(), 0);

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
INSERT INTO samsjacksonville.homeroom values (-1, '', '', -1, 20152016, -1, now(), -1, now(), 0);
INSERT INTO samsjacksonville.homeroom values (1, 'Grambling State', '112', fn_getSchoolId('Voice'), 20152016, -1, now(), -1, now(), 0);

ALTER TABLE samsjacksonville.student AUTO_INCREMENT = 0;
/* INSERT STATEMENT FOR STUDENT */
INSERT INTO samsjacksonville.student values (1, '20009764', 'Darrell', 'Blackman', fn_getSchoolID('C-KIPP Jacksonville K-8 - 5581'), 20152016, -1, fn_getGradeID('KG'), 'M - Male', -1, now(), -1, now(), 0);

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
INSERT INTO samsjacksonville.code_of_conduct_violation values (26, '2.15', 'ZZZ','Vandalism',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (27, '2.16', 'ZZZ','Stealing or USE of Counterfeit Bill',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (28, '2.17', 'ZZZ','Possession of Stolen Property',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (29, '2.18', 'ZZZ','Teasing/Intimidation/Ridicule',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (30, '2.19', 'TRS','Trespassing',-1,now(), -1, now(), 0, 20152016);
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
INSERT INTO samsjacksonville.code_of_conduct_violation values (44, '3.01', 'ALC','Alcohol',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (45, '3.02', 'DRU','Drugs',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (46, '3.03', 'PHA','Striking a School Distric Employee or Agent',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (47, '3.04', 'ROB','Robbery (using force to take something from another)',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (48, '3.05', 'STL','Stealing/Larcency/Theft',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (49, '3.06', 'BRK','Burglary of School Structure',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (50, '3.07', 'ZZZ','Vandalism',-1,now(), -1, now(), 0, 20152016);
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
INSERT INTO samsjacksonville.code_of_conduct_violation values (66, '3.23', 'TRS','Trespassing',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (67, '3.24', 'ZZZ','Teen Dating Violence or Abuse',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (68, '3.25', 'HAR','Harassment',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (69, '3.27', 'OMC','Drug/Alcohol Paraphernalia',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (70, '4.01', 'ALC','Alcohol',-1,now(), -1, now(), 0, 20152016);
INSERT INTO samsjacksonville.code_of_conduct_violation values (71, '4.02', 'DRD','Drugs',-1,now(), -1, now(), 0, 20152016);
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
INSERT INTO samsjacksonville.code_of_conduct_violation values (85, '4.16', 'VAN','Vandalism',-1,now(), -1, now(), 0, 20152016);

/* INSERT STATEMENTS FOR REMEDIAL ACTIONS */
-- Insert Statement for Remedial Action
ALTER TABLE samsjacksonville.remedial_action AUTO_INCREMENT = 0;
INSERT INTO samsjacksonville.remedial_action values (-1, 'Other',20152016,-1,now(),-1,now(),0);
INSERT INTO samsjacksonville.remedial_action values (1, 'Office Visit',20152016,-1,now(), -1, now(),0);
INSERT INTO samsjacksonville.remedial_action values (2, 'Detention',20152016,-1,now(), -1, now(),0);
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

/* insert data for office visits */
ALTER TABLE samsjacksonville.office_visit AUTO_INCREMENT = 0;
--------------------------------------------
INSERT INTO samsjacksonville.office_visit
(
	school_year_id,
    student_id,
    total_visits,
    homeroom_id,
    content_course_id,
    sent_by_contact_id,
    office_visit_dt,
    arrival_dt,
    handled_by_contact_id,
    nap,
    comments,
    last_update_contact_id,
    last_update_dt
)
VALUES (20152016,1,samsjacksonville.fn_getTotalVisits(1),1,1,4,now(),now(),3,1,'Testing insert',4,now());

INSERT INTO samsjacksonville.office_visit_remedial_action_assn VALUES(1,2);
INSERT INTO samsjacksonville.office_visit_offense_assn VALUES(1,3);
INSERT INTO samsjacksonville.office_visit
(
	school_year_id,
    student_id,
    total_visits,
    homeroom_id,
    content_course_id,
    sent_by_contact_id,
    office_visit_dt,
    last_update_contact_id,
    last_update_dt
)
VALUES (20152016,1,samsjacksonville.fn_getTotalVisits(1),1,1,4,now(),4,now());


--------------------------------------------

select * from samsjacksonville.office_visit;
select * from samsjacksonville.vw_office_visit;

