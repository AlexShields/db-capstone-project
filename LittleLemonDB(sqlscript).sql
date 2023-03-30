-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemon
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `LittleLemon` ;

-- -----------------------------------------------------
-- Schema LittleLemon
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemon` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemon` ;

-- -----------------------------------------------------
-- Table `LittleLemon`.`Customer details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`Customer details` ;

CREATE TABLE IF NOT EXISTS `LittleLemon`.`Customer details` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `CustomerName` VARCHAR(45) NULL,
  `PhoneNumber` VARCHAR(45) NULL,
  `EmailAddress` VARCHAR(200) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon`.`MenuItems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`MenuItems` ;

CREATE TABLE IF NOT EXISTS `LittleLemon`.`MenuItems` (
  `MenuItemsID` INT NOT NULL,
  `CourseName` VARCHAR(45) NULL,
  `StarterName` VARCHAR(45) NULL,
  `DesertName` VARCHAR(45) NULL,
  PRIMARY KEY (`MenuItemsID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`Menu` ;

CREATE TABLE IF NOT EXISTS `LittleLemon`.`Menu` (
  `MenuID` INT NOT NULL,
  `MenuName` VARCHAR(45) NULL,
  `Cuisine` VARCHAR(45) NULL,
  `MenuItemsID` INT NOT NULL,
  PRIMARY KEY (`MenuID`),
  CONSTRAINT `fk_Menu_MenuItems1`
    FOREIGN KEY (`MenuItemsID`)
    REFERENCES `LittleLemon`.`MenuItems` (`MenuItemsID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Menu_MenuItems1_idx` ON `LittleLemon`.`Menu` (`MenuItemsID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `LittleLemon`.`OrderStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`OrderStatus` ;

CREATE TABLE IF NOT EXISTS `LittleLemon`.`OrderStatus` (
  `OrderStatusID` INT NOT NULL AUTO_INCREMENT,
  `ShipStatus` VARCHAR(45) NULL,
  `ShipDate` DATE NULL,
  `Delivery Date` VARCHAR(45) NULL,
  `ShippingCost` DECIMAL NULL,
  PRIMARY KEY (`OrderStatusID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`Orders` ;

CREATE TABLE IF NOT EXISTS `LittleLemon`.`Orders` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `OrderDate` DATE NULL,
  `TotalCost` VARCHAR(45) NULL,
  `CustomerID` INT NOT NULL,
  `MenuID` INT NOT NULL,
  `OrderStatusID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  CONSTRAINT `fk_Orders_Customer details1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemon`.`Customer details` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Menu1`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemon`.`Menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_OrderStatus1`
    FOREIGN KEY (`OrderStatusID`)
    REFERENCES `LittleLemon`.`OrderStatus` (`OrderStatusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Orders_Customer details1_idx` ON `LittleLemon`.`Orders` (`CustomerID` ASC) VISIBLE;

CREATE INDEX `fk_Orders_Menu1_idx` ON `LittleLemon`.`Orders` (`MenuID` ASC) VISIBLE;

CREATE INDEX `fk_Orders_OrderStatus1_idx` ON `LittleLemon`.`Orders` (`OrderStatusID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `LittleLemon`.`Staff infromation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`Staff infromation` ;

CREATE TABLE IF NOT EXISTS `LittleLemon`.`Staff infromation` (
  `StaffID` INT NOT NULL,
  `Role` VARCHAR(45) NULL,
  `Salary` DECIMAL NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon`.`Bookings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`Bookings` ;

CREATE TABLE IF NOT EXISTS `LittleLemon`.`Bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `DateTime` DATE NULL,
  `TableNumber` INT NULL,
  `CustomerID` INT NOT NULL,
  `StaffID` INT NOT NULL,
  `Shipping Address` VARCHAR(200) NULL,
  PRIMARY KEY (`BookingID`),
  CONSTRAINT `fk_Bookings_Customer details1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemon`.`Customer details` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bookings_Staff infromation1`
    FOREIGN KEY (`StaffID`)
    REFERENCES `LittleLemon`.`Staff infromation` (`StaffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `BookingID_UNIQUE` ON `LittleLemon`.`Bookings` (`BookingID` ASC) VISIBLE;

CREATE INDEX `fk_Bookings_Customer details1_idx` ON `LittleLemon`.`Bookings` (`CustomerID` ASC) VISIBLE;

CREATE INDEX `fk_Bookings_Staff infromation1_idx` ON `LittleLemon`.`Bookings` (`StaffID` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
