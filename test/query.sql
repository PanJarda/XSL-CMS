
      DROP DATABASE IF EXISTS `jennifer_doe`;
    
    CREATE DATABASE `jennifer_doe`;
    USE `jennifer_doe`;
    
      DROP TABLE IF EXISTS `lang`;
    
    CREATE TABLE `lang` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
    `name`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
      DROP TABLE IF EXISTS `education`;
    
    CREATE TABLE `education` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
    `headline`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `langId`
    
      int(10) unsigned
    
      NOT NULL
    
    ,
    
    FOREIGN KEY (`langId`)
    REFERENCES `lang`(`id`)
    
      ON DELETE cascade
    ,
  
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
      DROP TABLE IF EXISTS `ahoj`;
    
    CREATE TABLE `ahoj` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
    `ahoj`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `langId`
    
      int(10) unsigned
    
      NOT NULL
    
    ,
    
    FOREIGN KEY (`langId`)
    REFERENCES `lang`(`id`)
    
      ON DELETE cascade
    ,
  
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
      DROP TABLE IF EXISTS `category`;
    
    CREATE TABLE `category` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
    `name`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
      DROP TABLE IF EXISTS `academic_position`;
    
    CREATE TABLE `academic_position` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
    `start_year`
    year
      NOT NULL
    
    ,
    
    `end_year`
    year
      NOT NULL
    
    ,
    
    `position_name`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `university`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `department`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `langId`
    
      int(10) unsigned
    
      NOT NULL
    
    ,
    
    FOREIGN KEY (`langId`)
    REFERENCES `lang`(`id`)
    
      ON DELETE cascade
    ,
  
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
      DROP TABLE IF EXISTS `product`;
    
    CREATE TABLE `product` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
    `type`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `name`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `desc`
    text
      NOT NULL
    
    ,
    
    `price`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `category`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `specs`
    text
      NOT NULL
    
    ,
    
    `categoryId`
    
      int(10) unsigned
    
      NOT NULL
    
    ,
    
    FOREIGN KEY (`categoryId`)
    REFERENCES `category`(`id`)
    
      ON DELETE cascade
    ,
  
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
      DROP TABLE IF EXISTS `customer`;
    
    CREATE TABLE `customer` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
    `name`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `address`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
      DROP TABLE IF EXISTS `invoice`;
    
    CREATE TABLE `invoice` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
    `customerId`
    
      int(10) unsigned
    
      NOT NULL
    
    ,
    
    FOREIGN KEY (`customerId`)
    REFERENCES `customer`(`id`)
    
    ,
  
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
    CREATE table invoice_x_product (
      invoice int(10) unsigned NOT NULL,
      product int(10) unsigned NOT NULL,
      FOREIGN KEY (`invoice`)
      REFERENCES `invoice`(`id`),
      FOREIGN KEY (`product`)
      REFERENCES `product`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  