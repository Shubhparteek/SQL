-- final project group2
DROP DATABASE IF EXISTS `online_shoestore_ordering_system`;
CREATE DATABASE `online_shoestore_ordering_system`;
USE `online_shoestore_ordering_system`;
DROP TABLE IF EXISTS `gender`;
CREATE TABLE `gender` (
    `gender_id` INT NOT NULL AUTO_INCREMENT,
    `gender_name` VARCHAR(1) NOT NULL,
    PRIMARY KEY (`gender_id`)
);
DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category` (
    `product_category_id` INT NOT NULL AUTO_INCREMENT,
    `product_category_name` VARCHAR(50) NOT NULL,
    `product_category_description` VARCHAR(200) NOT NULL,
    PRIMARY KEY (`product_category_id`)
);
DROP TABLE IF EXISTS `size_chart`;
CREATE TABLE `size_chart` (
    `size_id` INT NOT NULL AUTO_INCREMENT,
    `size_desc` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`size_id`)
);
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
    `product_id` INT NOT NULL AUTO_INCREMENT,
    `product_name` VARCHAR(50) NOT NULL,
    `gender_id` INT NOT NULL,
    `feature_detail` VARCHAR(500),
    `product_category_id` INT NOT NULL,
    `size_id` INT NOT NULL,
    `price` DECIMAL(10 , 2 ) NOT NULL,
    PRIMARY KEY (`product_id`),
    FOREIGN KEY (`gender_id`)
    REFERENCES `gender` (`gender_id`),
    FOREIGN KEY (`product_category_id`)
        REFERENCES `product_category` (`product_category_id`),
    FOREIGN KEY (`size_id`)
        REFERENCES `size_chart` (`size_id`)
);
DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
    `country_id` INT NOT NULL AUTO_INCREMENT,
    `country_name` VARCHAR(50),
    `fedral_tax` DECIMAL (3,2),
    PRIMARY KEY (`country_id`)
);
DROP TABLE IF EXISTS `province`;
CREATE TABLE `province` (
    `province_id` INT NOT NULL AUTO_INCREMENT,
    `province_name` VARCHAR(50),
     `province_tax` DECIMAL,
     `country_id` INT NOT NULL,
    PRIMARY KEY (`province_id`),
    FOREIGN KEY (`country_id`)
        REFERENCES `country` (`country_id`)
);
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
    `customer_id` INT NOT NULL AUTO_INCREMENT,
    `customer_name` VARCHAR(50) NOT NULL,
    `customer_address` VARCHAR(50) NOT NULL,
    `customer_province_id` INT NOT NULL,
    `customer_phone_number` VARCHAR(10),
    `customer_email` VARCHAR(100),
    PRIMARY KEY (`customer_id`),
    FOREIGN KEY (`customer_province_id`)
        REFERENCES `province` (`province_id`)
);
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
    `payment_id` INT NOT NULL AUTO_INCREMENT,
    `payment_method` VARCHAR(30) NOT NULL,
    PRIMARY KEY (`payment_id`)
);
DROP TABLE IF EXISTS `delivery_company`;
CREATE TABLE `delivery_company` (
    `company_id` INT NOT NULL AUTO_INCREMENT,
    `company_name` VARCHAR(20),
    `company_detail` VARCHAR(300),
    `company_address` VARCHAR(300),
    PRIMARY KEY (`company_id`)
);
DROP TABLE IF EXISTS `shipment`;
CREATE TABLE `shipment` (
    `shipment_id` INT NOT NULL AUTO_INCREMENT,
    `shipment_cost` DECIMAL(10 , 2 ),
    `shipment_start_date` DATE,
    `shipment_end_date` DATE,
    `delivery_company_id` INT NOT NULL,
    PRIMARY KEY (`shipment_id`),
    FOREIGN KEY (`delivery_company_id`)
        REFERENCES `delivery_company` (`company_id`)
);
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
    `order_detail_id` INT NOT NULL AUTO_INCREMENT,
    `product_id` INT NOT NULL,
    `product_quantity` INT NOT NULL,
    PRIMARY KEY (`order_detail_id`),
    FOREIGN KEY (`product_id`)
        REFERENCES `product` (`product_id`)
);
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
    `order_id` INT NOT NULL AUTO_INCREMENT,
    `payment_id` INT NOT NULL,
    `order_detail_id` INT NOT NULL,
    `order_date` DATE NOT NULL,
    `shipment_id` INT,
    `customer_id` INT NOT NULL,
    `process_start_date` DATE,
    PRIMARY KEY (`order_id`),
    FOREIGN KEY (`payment_id`)
        REFERENCES `payment` (`payment_id`),
    FOREIGN KEY (`order_detail_id`)
        REFERENCES `order_detail` (`order_detail_id`),
    FOREIGN KEY (`shipment_id`)
        REFERENCES `shipment` (`shipment_id`),
    FOREIGN KEY (`customer_id`)
        REFERENCES `customer` (`customer_id`)
);

