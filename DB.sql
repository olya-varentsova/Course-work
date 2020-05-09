-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.25


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema clinic
--

CREATE DATABASE IF NOT EXISTS clinic;
USE clinic;

--
-- Temporary table structure for view `doctors`
--
DROP TABLE IF EXISTS `doctors`;
DROP VIEW IF EXISTS `doctors`;
CREATE TABLE `doctors` (
  `Name` varchar(45),
  `pacients` bigint(21)
);

--
-- Temporary table structure for view `doctorss`
--
DROP TABLE IF EXISTS `doctorss`;
DROP VIEW IF EXISTS `doctorss`;
CREATE TABLE `doctorss` (
  `Name` varchar(45),
  `pacients` bigint(21)
);

--
-- Definition of table `cabinet`
--

DROP TABLE IF EXISTS `cabinet`;
CREATE TABLE `cabinet` (
  `id_C` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Number` int(10) unsigned NOT NULL,
  `Type` varchar(20) NOT NULL,
  `Square` int(10) unsigned NOT NULL,
  `id_Departmentt` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_C`),
  KEY `FK_Cabinet_1` (`id_Departmentt`),
  CONSTRAINT `FK_Cabinet_1` FOREIGN KEY (`id_Departmentt`) REFERENCES `department` (`id_Dep`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cabinet`
--

/*!40000 ALTER TABLE `cabinet` DISABLE KEYS */;
INSERT INTO `cabinet` (`id_C`,`Number`,`Type`,`Square`,`id_Departmentt`) VALUES 
 (2,1,'Procedur',20,1),
 (3,2,'Advisory',17,1),
 (4,1,'Procedur',18,2),
 (5,2,'Advisory',19,2),
 (6,1,'Procedur',20,3),
 (7,2,'Advisory',19,3),
 (8,1,'Procedur',17,4),
 (9,2,'Advisory',19,4),
 (10,1,'Procedur',18,5),
 (11,2,'Advisory',20,5),
 (12,1,'Procedur',21,6),
 (13,2,'Advisory',17,6),
 (14,1,'Procedur',20,7),
 (15,2,'Advisory',19,7);
/*!40000 ALTER TABLE `cabinet` ENABLE KEYS */;


--
-- Definition of table `department`
--

DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id_Dep` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name_D` varchar(30) NOT NULL,
  `Floor` int(10) unsigned NOT NULL,
  `Last_name_of_manager` varchar(25) NOT NULL,
  PRIMARY KEY (`id_Dep`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `department`
--

/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` (`id_Dep`,`Name_D`,`Floor`,`Last_name_of_manager`) VALUES 
 (1,'Surgery',1,'Magamadov'),
 (2,'Pediatry',5,'Popov'),
 (3,'Gastroentrology',4,'Kuzin'),
 (4,'Ginecology',6,'Sovkov'),
 (5,'Ultrasound diagnostics',3,'Reutov'),
 (6,'Nevrology',2,'Ykov'),
 (7,'Terapy',3,'Kokuhin');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;


--
-- Definition of table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
CREATE TABLE `doctor` (
  `id_Doc` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Passport_data` varchar(10) NOT NULL,
  `Specialization` varchar(20) NOT NULL,
  `Address` varchar(30) NOT NULL,
  `Year_of_birthday` varchar(4) NOT NULL,
  `Date_of_start_work` date NOT NULL,
  `Date_of_finish_work` date DEFAULT NULL,
  `id_Department` int(10) unsigned NOT NULL,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_Doc`),
  KEY `FK_Doctor_1` (`id_Department`),
  CONSTRAINT `FK_Doctor_1` FOREIGN KEY (`id_Department`) REFERENCES `department` (`id_Dep`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `doctor`
--

/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` (`id_Doc`,`Passport_data`,`Specialization`,`Address`,`Year_of_birthday`,`Date_of_start_work`,`Date_of_finish_work`,`id_Department`,`Name`) VALUES 
 (1,'2214523211',' Surger','Moscow, Horosheva 12, 34','1969','1989-02-02','0000-00-00',1,'Zuev'),
 (2,'2214562233','Surger','Moscow, Irodova 45, 76','1960','1989-09-09','2017-08-20',1,'Rotar'),
 (3,'2213121789','Pideatr','Moscow, Ogurcova 21, 75','1970','1988-09-12',NULL,2,'Bolion'),
 (5,'2215661234','Ginekolog','Moscow, Erohina 32, 24','1962','1988-02-11',NULL,4,'Babushkin'),
 (6,'2213676699','Ultra diagnosis','Moscow, Tereshkova 43, 8','1950','1980-11-11',NULL,5,'Poilo'),
 (7,'2214565544','Nevrologic','Moscow, Ilinkov 65, 156','1980','1999-09-01',NULL,6,'Quc'),
 (8,'2214567766','Gastroenterolog','Moscow, Osinin 17, 9','1980','2002-06-12',NULL,3,'Ivanov');
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;


--
-- Definition of table `patient`
--

DROP TABLE IF EXISTS `patient`;
CREATE TABLE `patient` (
  `id_P` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Passport_data_P` varchar(10) NOT NULL,
  `Address_P` varchar(35) NOT NULL,
  `Birthday` date NOT NULL,
  `Date_of_created` date NOT NULL,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_P`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patient`
--

/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` (`id_P`,`Passport_data_P`,`Address_P`,`Birthday`,`Date_of_created`,`Name`) VALUES 
 (1,'2233456544','Moscow, Simasheva 23, 6','2009-05-20','2007-08-20','Bobulib'),
 (2,'2344678788','Moscow, Hohlovskay 7, 98','2020-07-20','2002-04-20','Korovin'),
 (3,'2214676766','Moscow, Plorodova 8, 87','0000-00-00','2009-08-20','Reutov'),
 (4,'2214565677','Moscow, Poretova 9, 77','0000-00-00','2012-11-20','Scotov'),
 (5,'2213565454','Moscow, Yasnay 7, 92','2012-11-20','2007-07-20','Zhuzha'),
 (6,'2213454533','Moscow,Kukolnay 93, 8','2023-09-20','2021-08-20','Morozov'),
 (7,'2213787877','Moscow, Vavilova 334, 9','0000-00-00','2011-12-20','Gorbutuy'),
 (8,'2213333444','Moscow, Abramceva 88, 77','0000-00-00','2009-08-20','Samoilov'),
 (9,'2213221985','Moscow, Pokoeva 54, 12','0000-00-00','0000-00-00','Polezhaev'),
 (10,'2214545198','Moscow, Yaroslavnay 34, 56','0000-00-00','2010-03-20','Iryad'),
 (11,'2214121576','Penza, Ramenskay 22, 101','2017-03-20','2012-12-20','Korolev'),
 (12,'2213099982','Moscow, Smolenskay 56, 11','2000-01-08','2018-09-12','');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;


--
-- Definition of table `report`
--

DROP TABLE IF EXISTS `report`;
CREATE TABLE `report` (
  `id_R` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Department` int(11) NOT NULL,
  `Doctors` int(11) NOT NULL,
  `Count_of_patients` int(11) DEFAULT NULL,
  `Day` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_R`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `report`
--

/*!40000 ALTER TABLE `report` DISABLE KEYS */;
/*!40000 ALTER TABLE `report` ENABLE KEYS */;


--
-- Definition of table `timetable`
--

DROP TABLE IF EXISTS `timetable`;
CREATE TABLE `timetable` (
  `id_T` int(10) unsigned NOT NULL DEFAULT '0',
  `Cabinet_number` int(10) unsigned DEFAULT NULL,
  `Date_of_visit` date DEFAULT NULL,
  `Tunout_mark` tinyint(1) DEFAULT NULL,
  `id_Patient` int(10) unsigned DEFAULT NULL,
  `id_Cabinet` int(10) unsigned DEFAULT NULL,
  `id_Doctor` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_T`),
  KEY `FK_Timetable_2` (`id_Cabinet`),
  KEY `FK_Timetable_3` (`id_Doctor`),
  KEY `FK_Timetable_1` (`id_Patient`) USING BTREE,
  CONSTRAINT `FK_Timetable_1` FOREIGN KEY (`id_Patient`) REFERENCES `patient` (`id_P`),
  CONSTRAINT `FK_Timetable_2` FOREIGN KEY (`id_Cabinet`) REFERENCES `cabinet` (`id_C`),
  CONSTRAINT `FK_Timetable_3` FOREIGN KEY (`id_Doctor`) REFERENCES `doctor` (`id_Doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `timetable`
--

/*!40000 ALTER TABLE `timetable` DISABLE KEYS */;
INSERT INTO `timetable` (`id_T`,`Cabinet_number`,`Date_of_visit`,`Tunout_mark`,`id_Patient`,`id_Cabinet`,`id_Doctor`) VALUES 
 (0,1,'2001-03-11',1,4,5,2),
 (1,1,'2001-09-08',1,2,2,2),
 (2,2,'2001-09-04',0,6,7,6),
 (3,1,'2001-09-04',1,5,5,6),
 (4,2,'2001-08-09',1,4,6,2),
 (5,1,'2001-07-03',0,2,2,3),
 (7,2,'2001-03-14',1,5,5,2);
/*!40000 ALTER TABLE `timetable` ENABLE KEYS */;


--
-- Definition of trigger `t_visited`
--

DROP TRIGGER /*!50030 IF EXISTS */ `t_visited`;

DELIMITER $$

CREATE DEFINER = `root`@`localhost` TRIGGER `t_visited` AFTER INSERT ON `timetable` FOR EACH ROW BEGIN

        INSERT INTO VISIT
        values (NULL, NULL, NULL, NULL, new.id_Patient,new.id_T);

END $$

DELIMITER ;

--
-- Definition of table `visit`
--

DROP TABLE IF EXISTS `visit`;
CREATE TABLE `visit` (
  `id_V` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Complaints` varchar(45) DEFAULT NULL,
  `Diagnosis` varchar(20) DEFAULT NULL,
  `Medication` varchar(45) DEFAULT NULL,
  `id_Patientt` int(10) unsigned DEFAULT NULL,
  `id_Timetablee` int(10) unsigned DEFAULT NULL,
  `Doctor_name` varchar(45) NOT NULL,
  `Date_vis` date NOT NULL,
  PRIMARY KEY (`id_V`),
  KEY `FK_Visit_1` (`id_Patientt`),
  KEY `FK_Visit_2` (`id_Timetablee`),
  CONSTRAINT `FK_Visit_1` FOREIGN KEY (`id_Patientt`) REFERENCES `patient` (`id_P`),
  CONSTRAINT `FK_Visit_2` FOREIGN KEY (`id_Timetablee`) REFERENCES `timetable` (`id_T`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `visit`
--

/*!40000 ALTER TABLE `visit` DISABLE KEYS */;
INSERT INTO `visit` (`id_V`,`Complaints`,`Diagnosis`,`Medication`,`id_Patientt`,`id_Timetablee`,`Doctor_name`,`Date_vis`) VALUES 
 (1,NULL,NULL,NULL,2,1,'Rotar','2001-09-08'),
 (2,NULL,NULL,NULL,5,3,'Rotar','2001-09-04'),
 (3,NULL,'ORVI',NULL,4,4,'Rotar','2001-09-08'),
 (4,NULL,NULL,NULL,2,5,'Bolion','2001-07-03'),
 (5,NULL,NULL,NULL,6,2,'Polio','2001-09-04'),
 (6,NULL,NULL,NULL,4,0,'Rotar','2001-03-11'),
 (7,NULL,NULL,NULL,5,7,'Rotar','2001-03-04'),
 (8,NULL,NULL,NULL,5,4,'Rotar','2001-03-14');
/*!40000 ALTER TABLE `visit` ENABLE KEYS */;


--
-- Definition of procedure `dubl`
--

DROP PROCEDURE IF EXISTS `dubl`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `dubl`(N integer)
BEGIN
SELECT
  department.Name_D,
  doctor.Specialization,
  doctor.Name,
  COUNT(timetable.id_Patient),
  MONTH(timetable.Date_of_visit) AS `month`
FROM department
INNER JOIN DOCTOR ON doctor.id_Department = department.id_Dep
INNER JOIN timetable ON timetable.id_Doctor = doctor.id_Doc
WHERE YEAR(timetable.Date_of_visit) = N AND timetable.Tunout_mark = 1
GROUP BY `month`, department.Name_D, doctor.id_Doc
ORDER BY `month`, department.Name_D, doctor.Specialization;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `New_record`
--

DROP PROCEDURE IF EXISTS `New_record`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `New_record`(Date_V DATE)
BEGIN
  declare id_P, id_V integer;
  declare done integer default 0;
  declare rec cursor for select timetable.id_Patient, timetable.id_T from timetable where timetable.Date_of_visit=Date_V;
  declare continue handler for Not found set done = 1;
    open rec;
      repeat
         fetch rec into id_P, id_V;
            if (done = 0) then
              insert into visit values(NULL, NULL, NULL, NULL, id_P, id_V, NULL, Date_V);
           end if;
         until done=1 end repeat;
      close rec;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `proc`
--

DROP PROCEDURE IF EXISTS `proc`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc`(O_year integer, O_month integer)
BEGIN
  declare done integer default 0;
declare Department INTEGER;
declare Doctor INTEGER;
declare Count_patients INTEGER;
declare Number_of_day INTEGER;
declare rep cursor for SELECT
  department.id_Dep,
  doctor.id_Doc,
  COUNT(timetable.id_Patient),
  DAY(timetable.Date_of_visit) AS `day`
FROM department
INNER JOIN DOCTOR ON doctor.id_Department = department.id_Dep
INNER JOIN timetable ON timetable.id_Doctor = doctor.id_Doc
WHERE YEAR(timetable.Date_of_visit) = O_year AND MONTH(timetable.Date_of_visit) = O_month AND timetable.Tunout_mark = 1
GROUP BY `day`, department.id_Dep, doctor.id_Doc
ORDER BY `day`, department.id_Dep;
declare CONTINUE HANDLER FOR SQLSTATE "02000" SET done = 1;
OPEN rep;
DELETE FROM report;
        REPEAT
                FETCH rep INTO Department, Doctor, Count_patients, Number_of_day;
                IF (done = 0) THEN
                        BEGIN
                                INSERT INTO  report VALUES (NULL, Department, Doctor,Count_patients,Number_of_day);
                        END;
                END IF;
        UNTIL done = 1  END REPEAT;
CLOSE rep;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `Update`
--

DROP PROCEDURE IF EXISTS `Update`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Update`(O_year integer)
BEGIN
declare done integer default 0;
declare Department VARCHAR(30);
declare Specialization VARCHAR(20);
declare Name VARCHAR(20);
declare Count_patients INTEGER;
declare Number_of_month INTEGER;
declare rep cursor for SELECT
  department.Name_D,
  doctor.Specialization,
  doctor.Name,
  COUNT(timetable.id_Patient),
  MONTH(timetable.Date_of_visit) AS `month`
FROM department
INNER JOIN DOCTOR ON doctor.id_Department = department.id_Dep
INNER JOIN timetable ON timetable.id_Doctor = doctor.id_Doc
WHERE YEAR(timetable.Date_of_visit) = O_year AND timetable.Tunout_mark = 1
GROUP BY `month`, department.Name_D, doctor.id_Doc
ORDER BY `month`, department.Name_D, doctor.Specialization;
declare CONTINUE HANDLER FOR SQLSTATE "02000" SET done = 1;
DELETE FROM report;
OPEN rep;
FETCH rep INTO Department, Specialization, Name, Count_patients, Number_of_month;

WHILE done = 0
DO
  INSERT INTO report VALUES (NULL, Department, Specialization, Name,Count_patients,Number_of_month);
  FETCH rep INTO Department, Specialization, Name, Count_patients, Number_of_month;
END WHILE;
CLOSE rep;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `Update_report`
--

DROP PROCEDURE IF EXISTS `Update_report`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_report`(O_year integer, O_month integer)
BEGIN
declare done integer default 0;
declare Department INTEGER;
declare Doctor INTEGER;
declare Count_patients INTEGER;
declare Number_of_day INTEGER;
declare rep cursor for SELECT
  department.id_Dep,
  doctor.id_Doc,
  COUNT(timetable.id_Patient),
  DAY(timetable.Date_of_visit) AS `day`
FROM department
INNER JOIN DOCTOR ON doctor.id_Department = department.id_Dep
INNER JOIN timetable ON timetable.id_Doctor = doctor.id_Doc
WHERE YEAR(timetable.Date_of_visit) = O_year AND MONTH(timetable.Date_of_visit) = O_month AND timetable.Tunout_mark = 1
GROUP BY `day`, department.id_Dep, doctor.id_Doc
ORDER BY `day`, department.id_Dep;
declare CONTINUE HANDLER FOR SQLSTATE "02000" SET done = 1;
DELETE FROM report;
OPEN rep;
        REPEAT
                FETCH rep INTO Department, Doctor, Count_patients, Number_of_day;
                IF (done = 0) THEN
                        BEGIN
                                INSERT INTO  report VALUES (NULL, Department, Doctor,Count_patients,Number_of_day);
                        END;
                END IF;
        UNTIL done = 1  END REPEAT;
CLOSE rep;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of view `doctors`
--

DROP TABLE IF EXISTS `doctors`;
DROP VIEW IF EXISTS `doctors`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `doctors` AS select `doctor`.`Name` AS `Name`,count(0) AS `pacients` from (`timetable` join `doctor` on((`timetable`.`id_Doctor` = `doctor`.`id_Doc`))) where ((`timetable`.`Tunout_mark` = 1) and (year(`timetable`.`Date_of_visit`) = 2013)) group by `timetable`.`id_Doctor`;

--
-- Definition of view `doctorss`
--

DROP TABLE IF EXISTS `doctorss`;
DROP VIEW IF EXISTS `doctorss`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `doctorss` AS select `doctor`.`Name` AS `Name`,count(0) AS `pacients` from (`timetable` join `doctor` on((`timetable`.`id_Doctor` = `doctor`.`id_Doc`))) where ((`timetable`.`Tunout_mark` = 1) and (year(`timetable`.`Date_of_visit`) = 2017)) group by `timetable`.`id_Doctor`;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
