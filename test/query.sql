1
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
    
      VARCHAR(255)
    
      NOT NULL
    
      int(10) unsigned
    
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
    
      VARCHAR(255)
    
      NOT NULL
    
      int(10) unsigned
    
    ,
    
    FOREIGN KEY (`langId`)
    REFERENCES `lang`(`id`)
    
      ON DELETE cascade
    ,
  
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  