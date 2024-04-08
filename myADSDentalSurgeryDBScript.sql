USE ads_db;

DROP TABLE IF EXISTS `ads_db`.`OfficeManager` ;
CREATE TABLE IF NOT EXISTS `ads_db`.`OfficeManager` (
  `idOfficeManager` INT NOT NULL UNIQUE auto_increment,
  `firstName` VARCHAR(50),
  `lastName` VARCHAR(50),
  PRIMARY KEY (`idOfficeManager`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `ads_db`.`Address` ;
CREATE TABLE IF NOT EXISTS `ads_db`.`Address` (
  `idAddress` INT UNIQUE NOT NULL auto_increment,
  `street` VARCHAR(50),
  `state` VARCHAR(50),
  `city` VARCHAR(50),
  `zip` VARCHAR(50),
  `apt` VARCHAR(50),
  PRIMARY KEY (`idAddress`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `ads_db`.`Patient` ;
CREATE TABLE IF NOT EXISTS `ads_db`.`Patient` (
  `idPatient` INT UNIQUE NOT NULL auto_increment,
  `firstName` VARCHAR(50),
  `lastName` VARCHAR(50),
  `phone` BIGINT,
  `email` VARCHAR(255),
  `dateOfBirth` DATE,
  `mailingAddress` INT,
  PRIMARY KEY (`idPatient`),
  CONSTRAINT `fk_Patient_Address` FOREIGN KEY (`mailingAddress`) REFERENCES `ads_db`.`Address` (`idAddress`))
ENGINE = InnoDB;


DROP TABLE IF EXISTS `ads_db`.`Dentist` ;
CREATE TABLE IF NOT EXISTS `ads_db`.`Dentist` (
  `idDentist` INT UNIQUE NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(50),
  `lastName` VARCHAR(50),
  `phone` bigint,
  `email` VARCHAR(255),
  `speciality` VARCHAR(255),
  PRIMARY KEY (`idDentist`))
ENGINE = InnoDB;


DROP TABLE IF EXISTS `ads_db`.`Roles` ;
CREATE TABLE IF NOT EXISTS `ads_db`.`Roles` (
  `idRoles` INT NOT NULL AUTO_INCREMENT UNIQUE,
  `startDate` DATETIME,
  `endDate` DATETIME,
  `idOfficeManagerFK` INT,
  `idPatientFK` INT,
  `idDentistFK` INT,
  PRIMARY KEY (`idRoles`),
  CONSTRAINT `fk_Role_OfficeManager` FOREIGN KEY (`idOfficeManagerFK`) REFERENCES `ads_db`.`OfficeManager` (`idOfficeManager`),
  CONSTRAINT `fk_Role_Patient` FOREIGN KEY (`idPatientFK`) REFERENCES `ads_db`.`Patient` (`idPatient`),
  CONSTRAINT `fk_Role_Dentist` FOREIGN KEY (`idDentistFK`) REFERENCES `ads_db`.`Dentist` (`idDentist`))
ENGINE = InnoDB;


DROP TABLE IF EXISTS `ads_db`.`User` ;
CREATE TABLE IF NOT EXISTS `ads_db`.`User` (
  `idUser` INT UNIQUE NOT NULL auto_increment,
  `username` VARCHAR(50),
  `password` VARCHAR(50),
  `idRolesFK` INT NULL,
  PRIMARY KEY (`idUser`),
  CONSTRAINT `fk_User_Roles` FOREIGN KEY (`idRolesFK`) REFERENCES `ads_db`.`Roles` (`idRoles`))
ENGINE = InnoDB;


DROP TABLE IF EXISTS `ads_db`.`Surgery` ;
CREATE TABLE IF NOT EXISTS `ads_db`.`Surgery` (
  `idSurgery` INT NOT NULL UNIQUE AUTO_INCREMENT,
  `name` VARCHAR(50),
  `phone` BIGINT,
  `locationAdress` INT NULL,
  PRIMARY KEY (`idSurgery`),
  CONSTRAINT `fk_Surgery_Address` FOREIGN KEY (`locationAdress`) REFERENCES `ads_db`.`Address` (`idAddress`))
ENGINE = InnoDB;


DROP TABLE IF EXISTS `ads_db`.`Appointment` ;
CREATE TABLE IF NOT EXISTS `ads_db`.`Appointment` (
  `idAppointment` INT UNIQUE NOT NULL AUTO_INCREMENT,
  `scheduleTime` DATETIME,
  `location` INT NULL,
  `idUserFK` INT NULL,
  PRIMARY KEY (`idAppointment`),
  CONSTRAINT `fk_Appointment_Surgery` FOREIGN KEY (`location`) REFERENCES `ads_db`.`Surgery` (`idSurgery`),
  CONSTRAINT `fk_Appointment_User` FOREIGN KEY (`idUserFK`) REFERENCES `ads_db`.`User` (`idUser`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


USE ads_db;

INSERT INTO `Address` (`street`, `state`, `city`, `zip`, `apt`) VALUES 
('123 Main St', 'CA', 'Los Angeles', '90001', 'Apt#E4'),
('456 Elm St', 'NY', 'New York', '11342', NULL),
('6098 N Main St', 'MI', 'Detroit', '20937', 'Apt#1F'),
('1000 N 4th St', 'IA', 'Fairfiled', '55526', 'Apt#588');

INSERT INTO `OfficeManager` (`firstName`, `lastName`) VALUES 
('Jack', 'Alibou'),
('Emily', 'Johnson'),
('Feder', 'Lemi'),
('Michael', 'Smith');

INSERT INTO `Patient` (`firstName`, `lastName`, `phone`, `email`, `dateOfBirth`, `mailingAddress`) VALUES 
('Alice', 'Williams', 1234567890, 'alice.williams@gmail.com', '2010-05-15', 1),
('John', 'Tuy', 1234567890, 'john.tuy@gmail.com', '1996-12-19', 1),
('Kenedy', 'Ciang', 1234567890, 'kenedy.ciang@gmail.com', '2005-09-25', 2),
('Jack', 'David', 1234567890, 'jack.david@gmail.com', '2015-03-12', 4),
('Bob', 'Johnson', 9876543210, 'bob.johnson@yahoo.com', '1985-10-20', 3);

INSERT INTO `Dentist` (`firstName`, `lastName`, `phone`, `email`, `speciality`) VALUES 
('Dr. David', 'Anderson', 5551234567, 'dr.david@email.com', 'Orthodontics'),
('Dr. Ciang', 'David', 5673434590, 'dr.ciang@email.com', 'Orthodontics'),
('Dr. Sarah', 'Clark', 5559876543, 'dr.sarah@email.com', 'Endodontics');

INSERT INTO `Roles` (`startDate`, `endDate`, `idOfficeManagerFK`, `idPatientFK`, `idDentistFK`) VALUES 
('2024-01-01', '2024-12-31', 1, null, null),
('2024-01-01', '2024-12-31', null, null, 1),
('2024-01-01', '2024-12-31', null, 1, null);

DELETE FROM appointment A WHERE A.idAppointment = 2;
DELETE FROM USER WHERE idUser = 2;
DELETE FROM USER WHERE idUser = 3;
INSERT INTO `User` (`username`, `password`, `idRolesFK`) VALUES 
('jack_alibou', 'adminpass', 1),
('emily_johnson', 'managerpass', 1),
('alice_williams', 'A@W3456', 3),
('john_tuy', '123#456', 3),
('kenedyciang', '123#456', 3),
('jack_david', 'Jd#123', 3),
('dr.david', 'David#123', 2),
('dr.ciang', 'Ciang#123', 2),
('dr.sarah', 'Sarah#123', 2);


INSERT INTO `Surgery` (`name`, `phone`, `locationAdress`) VALUES 
('Downtown Dental Clinic', 5551112222, 1),
('Uptown Dental Clinic', 5761512233, 1),
('Home Dental Clinic', 5762914547, 3),
('Central Dental Care', 5553334444, 2);

INSERT INTO `Appointment` (`scheduleTime`, `idUserFK`, `location`) VALUES 
('2024-04-10 10:00:00', 8, 1),
('2024-04-10 10:00:00', 9, 3),
('2024-04-10 10:00:00', 8, 1),
('2024-04-12 14:30:00', 10, 2),
('2024-04-12 14:30:00', 8, 2),
('2024-04-12 14:30:00', 9, 4);



-- Display the list of ALL Dentists registered in the system, sorted in ascending order of their lastNames:
SELECT * FROM Dentist ORDER BY lastName ASC;


-- Display the list of ALL Appointments for a given Dentist by their dentist_Id number. Include in the result, the Patient information:
SELECT A.*, P.idPatient AS PatientID, P.firstName AS PatientFirstName, P.lastName AS PatientLastName
FROM Appointment A 
JOIN User U ON A.idUserFK = U.idUser 
JOIN Roles R ON R.idRoles = U.idRolesFK 
JOIN Patient P ON R.idPatientFK = P.idPatient
JOIN Dentist D ON D.idDentist = R.idDentistFK 
WHERE R.idDentistFK = 2;


-- Display the list of ALL Appointments that have been scheduled at a Surgery Location:
SELECT A.*, S.name AS Surgery_Name
FROM Appointment A JOIN Surgery S ON A.location = S.idSurgery;


-- Display the list of the Appointments booked for a given Patient on a given Date:
SELECT A.*, P.firstName AS Patient_FirstName, P.lastName AS Patient_LastName
FROM Appointment A JOIN User U ON A.idUserFK = U.idUser
JOIN Roles R ON U.idRolesFK = R.idRoles
JOIN Patient P ON R.idPatientFK = P.idPatient
WHERE P.idPatient = 1 AND DATE(A.scheduleTime) = '2024-01-01 00:00:00';