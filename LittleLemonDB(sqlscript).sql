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
-- Table `LittleLemon`.`CustomerDetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`CustomerDetails` ;

CREATE TABLE IF NOT EXISTS `LittleLemon`.`CustomerDetails` (
  `CustomerID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `CustomerName` VARCHAR(45) NULL,
  `PhoneNumber` VARCHAR(45) NULL,
  `EmailAddress` VARCHAR(200) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


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
  `Cost` VARCHAR(45) NULL,
  PRIMARY KEY (`MenuID`),
  CONSTRAINT `fk_Menu_MenuItems1`
    FOREIGN KEY (`MenuItemsID`)
    REFERENCES `LittleLemon`.`MenuItems` (`MenuItemsID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Menu_MenuItems1_idx` ON `LittleLemon`.`Menu` (`MenuItemsID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `LittleLemon`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`Orders` ;

CREATE TABLE IF NOT EXISTS `LittleLemon`.`Orders` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `OrderDate` DATE NULL,
  `TotalCost` DECIMAL NULL,
  `CustomerID` INT UNSIGNED NOT NULL,
  `OrderStatusID` INT NOT NULL,
  `Quantity` INT NULL,
  `MenuID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  CONSTRAINT `fk_Orders_CustomerDetails1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemon`.`CustomerDetails` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_OrderStatus1`
    FOREIGN KEY (`OrderStatusID`)
    REFERENCES `LittleLemon`.`OrderStatus` (`OrderStatusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Menu1`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemon`.`Menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Orders_CustomerDetails1_idx` ON `LittleLemon`.`Orders` (`CustomerID` ASC) VISIBLE;

CREATE INDEX `fk_Orders_OrderStatus1_idx` ON `LittleLemon`.`Orders` (`OrderStatusID` ASC) VISIBLE;

CREATE INDEX `fk_Orders_Menu1_idx` ON `LittleLemon`.`Orders` (`MenuID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `LittleLemon`.`StaffInfromation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`StaffInfromation` ;

CREATE TABLE IF NOT EXISTS `LittleLemon`.`StaffInfromation` (
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
  `Shipping Address` VARCHAR(200) NULL,
  `StaffID` INT NOT NULL,
  `CustomerDetails_CustomerID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`BookingID`),
  CONSTRAINT `fk_Bookings_StaffInfromation1`
    FOREIGN KEY (`StaffID`)
    REFERENCES `LittleLemon`.`StaffInfromation` (`StaffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bookings_CustomerDetails1`
    FOREIGN KEY (`CustomerDetails_CustomerID`)
    REFERENCES `LittleLemon`.`CustomerDetails` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `BookingID_UNIQUE` ON `LittleLemon`.`Bookings` (`BookingID` ASC) VISIBLE;

CREATE INDEX `fk_Bookings_StaffInfromation1_idx` ON `LittleLemon`.`Bookings` (`StaffID` ASC) VISIBLE;

CREATE INDEX `fk_Bookings_CustomerDetails1_idx` ON `LittleLemon`.`Bookings` (`CustomerDetails_CustomerID` ASC) VISIBLE;

USE `LittleLemon` ;

-- -----------------------------------------------------
-- Placeholder table for view `LittleLemon`.`OrdersView`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon`.`OrdersView` (`OrderID` INT, `Quantity` INT, `TotalCost` INT);

-- -----------------------------------------------------
-- Placeholder table for view `LittleLemon`.`BigSpender`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon`.`BigSpender` (`CustomerID` INT, `CustomerName` INT, `OrderID` INT, `TotalCost` INT, `MenuName` INT, `CourseName` INT, `StarterName` INT);

-- -----------------------------------------------------
-- Placeholder table for view `LittleLemon`.`ThreeOrMore`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon`.`ThreeOrMore` (`MenuName` INT);

-- -----------------------------------------------------
-- procedure GetMaxQuantity
-- -----------------------------------------------------

USE `LittleLemon`;
DROP procedure IF EXISTS `LittleLemon`.`GetMaxQuantity`;

DELIMITER $$
USE `LittleLemon`$$
CREATE PROCEDURE `GetMaxQuantity` ()
BEGIN
SELECT MAX(Quantity) as MaxQuantity FROM Orders;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetOrderDetail
-- -----------------------------------------------------

USE `LittleLemon`;
DROP procedure IF EXISTS `LittleLemon`.`GetOrderDetail`;

DELIMITER $$
USE `LittleLemon`$$
CREATE PROCEDURE `GetOrderDetail` (IN InCustomerID INT) 
BEGIN
  PREPARE stmt FROM 'SELECT OrderID, Quantity, OrderCost FROM Orders WHERE CustomerID = ?';
  SET @customer_id = InCustomerID;
  EXECUTE stmt USING @customer_id;
  DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CancelOrder
-- -----------------------------------------------------

USE `LittleLemon`;
DROP procedure IF EXISTS `LittleLemon`.`CancelOrder`;

DELIMITER $$
USE `LittleLemon`$$
CREATE PROCEDURE CancelOrder(IN InOrderID INT)
BEGIN
  DELETE FROM Orders WHERE OrderID = InOrderID;
  SELECT CONCAT('Order ', InOrderID, ' has been cancelled.') AS confirmation;
END;$$

DELIMITER ;

-- -----------------------------------------------------
-- View `LittleLemon`.`OrdersView`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`OrdersView`;
DROP VIEW IF EXISTS `LittleLemon`.`OrdersView` ;
USE `LittleLemon`;
CREATE  OR REPLACE VIEW OrdersView AS
SELECT o.OrderID, o.Quantity, o.TotalCost
FROM Orders o
GROUP BY OrderID;

-- -----------------------------------------------------
-- View `LittleLemon`.`BigSpender`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`BigSpender`;
DROP VIEW IF EXISTS `LittleLemon`.`BigSpender` ;
USE `LittleLemon`;
Create  OR REPLACE VIEW BigSpender AS 
SELECT CustomerDetails.CustomerID, CustomerDetails.CustomerName, Orders.OrderID, Orders.TotalCost, Menu.MenuName, MenuItems.CourseName, MenuItems.StarterName
FROM CustomerDetails
JOIN Orders ON CustomerDetails.CustomerID= Orders.CustomerID
JOIN Menu ON Orders.MenuID = Menu.MenuID
JOIN MenuItems ON Menu.MenuItemsID = MenuItems.MenuItemsID
WHERE Orders.TotalCost > 150
ORDER BY Orders.TotalCost ASC;

-- -----------------------------------------------------
-- View `LittleLemon`.`ThreeOrMore`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemon`.`ThreeOrMore`;
DROP VIEW IF EXISTS `LittleLemon`.`ThreeOrMore` ;
USE `LittleLemon`;
CREATE  OR REPLACE VIEW `ThreeOrMore` AS
SELECT MenuName FROM Menu
WHERE MenuID IN
	(SELECT DISTINCT MenuID From Orders WHERE Quantity >2);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
