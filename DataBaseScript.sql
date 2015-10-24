/* Run this first if you are creatigna database the first time.

CREATE DATABASE `samsjacksonville`;

**Run this to user to databse app uses

GRANT USAGE ON samsjacksonville.* TO 'KIPPDemo'@'localhost'IDENTIFIED BY 'KIPPDemo';
GRANT select,execute,insert,update,delete ON samsjacksonville.* TO 'KIPPDemo'@'localhost'IDENTIFIED BY'KIPPDemo';

*/


/* Students */
DROP TABLE IF EXISTS student;

CREATE TABLE `student` (
  `StudentID` nchar(12) NOT NULL,
  `FirstName` varchar(45) NOT NULL,
  `MiddleName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) NOT NULL,
  PRIMARY KEY (`StudentID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

ALTER TABLE student AUTO_INCREMENT = 0;


INSERT INTO `samsjacksonville`.`student`(`StudentID`,`FirstName`,`MiddleName`,`LastName`)VALUES('12345','JackieStudent',	'J',	'Jack');
INSERT INTO `samsjacksonville`.`student`(`StudentID`,`FirstName`,`MiddleName`,`LastName`)VALUES('9023456','TommyStudent',	'T',	'Tom');
INSERT INTO `samsjacksonville`.`student`(`StudentID`,`FirstName`,`MiddleName`,`LastName`)VALUES('8080822','MikeyStudent',	'M',	'Mike');
INSERT INTO `samsjacksonville`.`student`(`StudentID`,`FirstName`,`MiddleName`,`LastName`)VALUES('1090911','BillyStudent',	'B'	,'Bill');
INSERT INTO `samsjacksonville`.`student`(`StudentID`,`FirstName`,`MiddleName`,`LastName`)VALUES('8090961','NickyStudent',	'N',	'Nick');
INSERT INTO `samsjacksonville`.`student`(`StudentID`,`FirstName`,`MiddleName`,`LastName`)VALUES('7070722','NickieStudent',	'N',	'Nick');
INSERT INTO `samsjacksonville`.`student`(`StudentID`,`FirstName`,`MiddleName`,`LastName`)VALUES('522','FrankieStudent',	'F',	'Frank');

/*Profiles*/
DROP TABLE IF EXISTS profile;

CREATE TABLE `profile` (
  `ProfileId` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(45) NOT NULL,
  `MiddleName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) NOT NULL,
  `UserID` char(9) NOT NULL,
  `Password` char(9) NOT NULL,
  PRIMARY KEY (`ProfileId`,`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

ALTER TABLE profile AUTO_INCREMENT = 0;

INSERT INTO `samsjacksonville`.`profile`(`FirstName`,`MiddleName`,`LastName`,`Password`,`UserID`)VALUES('TIM','E','Harrison','Tim','Timmy');
INSERT INTO `samsjacksonville`.`profile`(`FirstName`,`MiddleName`,`LastName`,`Password`,`UserID`)VALUES( 'Karthikeyan','','Umapathy','Karthick','Karthick');

DROP TABLE IF EXISTS teacher;


CREATE TABLE `teacher` (
  `TeacherID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(45) NOT NULL,
  `MiddleName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) NOT NULL,
  PRIMARY KEY (`TeacherID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO `samsjacksonville`.`teacher`(`FirstName`,`MiddleName`,`LastName`)VALUES('JackieTeacher',	'J',	'Jack');
INSERT INTO `samsjacksonville`.`teacher`(`FirstName`,`MiddleName`,`LastName`)VALUES('TommyTeacher',	'T',	'Tom');
INSERT INTO `samsjacksonville`.`teacher`(`FirstName`,`MiddleName`,`LastName`)VALUES('MikeyTeacher',	'M',	'Mike');
INSERT INTO `samsjacksonville`.`teacher`(`FirstName`,`MiddleName`,`LastName`)VALUES('BillyTeacher',	'B'	,'Bill');
INSERT INTO `samsjacksonville`.`teacher`(`FirstName`,`MiddleName`,`LastName`)VALUES('NickyTeacher',	'N',	'Nick');
INSERT INTO `samsjacksonville`.`teacher`(`FirstName`,`MiddleName`,`LastName`)VALUES('NickieTeacher',	'N',	'Nick');
INSERT INTO `samsjacksonville`.`teacher`(`FirstName`,`MiddleName`,`LastName`)VALUES('FrankieTeacher',	'F',	'Frank');
