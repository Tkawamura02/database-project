-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`managerPhone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`managerPhone` (
  `mgPhone` VARCHAR(10) NOT NULL,
  `manager_managerID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`mgPhone`, `manager_managerID`),
  INDEX `fk_managerPhone_manager1_idx` (`manager_managerID` ASC) VISIBLE,
  CONSTRAINT `fk_managerPhone_manager1`
    FOREIGN KEY (`manager_managerID`)
    REFERENCES `mydb`.`manager` (`managerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`manager` (
  `managerID` VARCHAR(10) NOT NULL,
  `mgFirst` VARCHAR(45) NOT NULL,
  `mgLast` VARCHAR(45) NOT NULL,
  `salary` VARCHAR(45) NOT NULL,
  `bonus` VARCHAR(45) NOT NULL,
  `mgDOB` VARCHAR(45) NOT NULL,
  `mgPhone` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`managerID`),
  INDEX `fk_manager_managerPhone1_idx` (`mgPhone` ASC) VISIBLE,
  CONSTRAINT `fk_manager_managerPhone1`
    FOREIGN KEY (`mgPhone`)
    REFERENCES `mydb`.`managerPhone` (`mgPhone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`manage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`manage` (
  `manage_managerID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`manage_managerID`),
  INDEX `fk_hotel_has_manager_manager2_idx` (`manage_managerID` ASC) VISIBLE,
  CONSTRAINT `fk_hotel_has_manager_manager2`
    FOREIGN KEY (`manage_managerID`)
    REFERENCES `mydb`.`manager` (`managerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`hotel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`hotel` (
  `htID` VARCHAR(10) NOT NULL,
  `numberOfRooms` VARCHAR(45) NOT NULL,
  `htAddress` VARCHAR(300) NOT NULL,
  `manage_managerID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`htID`, `manage_managerID`),
  INDEX `fk_hotel_manage1_idx` (`manage_managerID` ASC) VISIBLE,
  CONSTRAINT `fk_hotel_manage1`
    FOREIGN KEY (`manage_managerID`)
    REFERENCES `mydb`.`manage` (`manage_managerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`locatedIn`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`locatedIn` (
  `locatedIn_htID` VARCHAR(10) NOT NULL,
  `manage_managerID` VARCHAR(10) NOT NULL,
  INDEX `fk_hotel_has_suite_hotel1_idx` (`locatedIn_htID` ASC, `manage_managerID` ASC) VISIBLE,
  PRIMARY KEY (`locatedIn_htID`, `manage_managerID`),
  CONSTRAINT `fk_hotel_has_suite_hotel1`
    FOREIGN KEY (`locatedIn_htID` , `manage_managerID`)
    REFERENCES `mydb`.`hotel` (`htID` , `manage_managerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`suite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`suite` (
  `sutNumber` VARCHAR(4) NOT NULL,
  `htID` VARCHAR(10) NOT NULL,
  `sutNoOfBeds` VARCHAR(45) NOT NULL,
  `manage_managerID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`sutNumber`, `htID`, `manage_managerID`),
  INDEX `fk_suite_locatedIn1_idx` (`manage_managerID` ASC) VISIBLE,
  CONSTRAINT `fk_suite_locatedIn1`
    FOREIGN KEY (`manage_managerID`)
    REFERENCES `mydb`.`locatedIn` (`manage_managerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`staff` (
  `stfID` VARCHAR(10) NOT NULL,
  `stfFirst` VARCHAR(45) NOT NULL,
  `stfLast` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`stfID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`refers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`refers` (
  `refers_hcID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`refers_hcID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`booking` (
  `htID` VARCHAR(10) NULL,
  `sutNumber` VARCHAR(4) NOT NULL,
  `bkCheckInDate` VARCHAR(45) NOT NULL,
  `bkCheckOutDate` VARCHAR(45) NOT NULL,
  `manage_managerID` VARCHAR(10) NULL,
  PRIMARY KEY (`htID`, `sutNumber`, `manage_managerID`),
  INDEX `fk_suite_has_hotelClient_suite1_idx` (`htID` ASC, `manage_managerID` ASC) VISIBLE,
  CONSTRAINT `fk_suite_has_hotelClient_suite1`
    FOREIGN KEY (`manage_managerID`)
    REFERENCES `mydb`.`suite` (`manage_managerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`hotelClient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`hotelClient` (
  `hcID` VARCHAR(45) NOT NULL,
  `hcFirst` VARCHAR(45) NOT NULL,
  `hcLast` VARCHAR(45) NOT NULL,
  `hcAddress` VARCHAR(300) NOT NULL,
  `sutNumber` VARCHAR(4) NOT NULL,
  `locatedIn_htID` VARCHAR(10) NOT NULL,
  `manage_managerID` VARCHAR(10) NOT NULL,
  `refers_hcID` VARCHAR(10) NOT NULL,
  `refers_refers_hcID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`hcID`, `locatedIn_htID`, `manage_managerID`, `refers_hcID`, `refers_refers_hcID`),
  INDEX `fk_booking_has_hotelClient_booking1_idx` (`sutNumber` ASC, `locatedIn_htID` ASC, `manage_managerID` ASC) INVISIBLE,
  INDEX `fk_hotelClient_refers1_idx` (`refers_hcID` ASC) VISIBLE,
  INDEX `fk_hotelClient_refers2_idx` (`refers_refers_hcID` ASC) VISIBLE,
  INDEX `fk_booking_has_hotelClient_booking 2_idx` (`sutNumber` ASC) INVISIBLE,
  CONSTRAINT `fk_booking_has_hotelClient_booking1`
    FOREIGN KEY (`locatedIn_htID` , `manage_managerID`)
    REFERENCES `mydb`.`booking` (`htID` , `manage_managerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hotelClient_refers1`
    FOREIGN KEY (`refers_hcID`)
    REFERENCES `mydb`.`refers` (`refers_hcID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hotelClient_refers2`
    FOREIGN KEY (`refers_refers_hcID`)
    REFERENCES `mydb`.`refers` (`refers_hcID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_booking_has_hotelClient_booking 2`
    FOREIGN KEY (`sutNumber`)
    REFERENCES `mydb`.`booking` (`sutNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cleans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cleans` (
  `cleans_stfID` VARCHAR(10) NOT NULL,
  `cleans_sutNumber` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`cleans_stfID`, `cleans_sutNumber`),
  INDEX `fk_suite_has_staff_staff1_idx` (`cleans_stfID` ASC) VISIBLE,
  INDEX `fk_suite_has_staff_suite1_idx` (`cleans_sutNumber` ASC) VISIBLE,
  CONSTRAINT `fk_suite_has_staff_suite1`
    FOREIGN KEY (`cleans_sutNumber`)
    REFERENCES `mydb`.`suite` (`sutNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_suite_has_staff_staff1`
    FOREIGN KEY (`cleans_stfID`)
    REFERENCES `mydb`.`staff` (`stfID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`residesIn`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`residesIn` (
  `residesIn_htID` VARCHAR(10) NOT NULL,
  `residesIn_managerID` VARCHAR(10) NULL,
  PRIMARY KEY (`residesIn_htID`, `residesIn_managerID`),
  INDEX `fk_hotel_has_manager_manager1_idx` (`residesIn_managerID` ASC) VISIBLE,
  INDEX `fk_hotel_has_manager_hotel1_idx` (`residesIn_htID` ASC) VISIBLE,
  CONSTRAINT `fk_hotel_has_manager_hotel1`
    FOREIGN KEY (`residesIn_htID`)
    REFERENCES `mydb`.`hotel` (`htID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hotel_has_manager1`
    FOREIGN KEY (`residesIn_managerID`)
    REFERENCES `mydb`.`manager` (`managerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
