
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
  
      DROP TABLE IF EXISTS `permission`;
    
    CREATE TABLE `permission` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
    `name`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `description`
    text
      NOT NULL
    
    ,
    
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
      DROP TABLE IF EXISTS `role`;
    
    CREATE TABLE `role` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
    `name`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
      DROP TABLE IF EXISTS `group`;
    
    CREATE TABLE `group` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
    `name`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
      DROP TABLE IF EXISTS `user`;
    
    CREATE TABLE `user` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
    `first_name`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `last_name`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `nick`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `email`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `password`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
      DROP TABLE IF EXISTS `product_category`;
    
    CREATE TABLE `product_category` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
    `name`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `lang_id` int(10) unsigned NOT NULL,
    FOREIGN KEY (`lang_id`)
    REFERENCES `lang`(`id`)
    
    ,
  
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
      DROP TABLE IF EXISTS `product_attribute_value`;
    
    CREATE TABLE `product_attribute_value` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
    `name`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
      DROP TABLE IF EXISTS `product_attribute_type`;
    
    CREATE TABLE `product_attribute_type` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
    `name`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `lang_id` int(10) unsigned NOT NULL,
    FOREIGN KEY (`lang_id`)
    REFERENCES `lang`(`id`)
    
    ,
  
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
      DROP TABLE IF EXISTS `product_attribute`;
    
    CREATE TABLE `product_attribute` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
    `name`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `product_attribute_type_id` int(10) unsigned NOT NULL,
    FOREIGN KEY (`product_attribute_type_id`)
    REFERENCES `product_attribute_type`(`id`)
    
    ,
  
    `lang_id` int(10) unsigned NOT NULL,
    FOREIGN KEY (`lang_id`)
    REFERENCES `lang`(`id`)
    
    ,
  
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
      DROP TABLE IF EXISTS `product`;
    
    CREATE TABLE `product` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
      DROP TABLE IF EXISTS `chart`;
    
    CREATE TABLE `chart` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
    `product_id` int(10) unsigned NOT NULL,
    FOREIGN KEY (`product_id`)
    REFERENCES `product`(`id`)
    
    ,
  
    `product_attribute_id` int(10) unsigned NOT NULL,
    FOREIGN KEY (`product_attribute_id`)
    REFERENCES `product_attribute`(`id`)
    
    ,
  
    `product_attribute_value_id` int(10) unsigned NOT NULL,
    FOREIGN KEY (`product_attribute_value_id`)
    REFERENCES `product_attribute_value`(`id`)
    
    ,
  
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
      DROP TABLE IF EXISTS `invoice`;
    
    CREATE TABLE `invoice` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      
    `shipping_details`
    
      VARCHAR(255)
    
      NOT NULL
    
    ,
    
    `chart_id` int(10) unsigned NOT NULL,
    FOREIGN KEY (`chart_id`)
    REFERENCES `chart`(`id`)
    
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
    
    `user_id` int(10) unsigned NOT NULL,
    FOREIGN KEY (`user_id`)
    REFERENCES `user`(`id`)
    
    ,
  
    `chart_id` int(10) unsigned NOT NULL,
    FOREIGN KEY (`chart_id`)
    REFERENCES `chart`(`id`)
    
    ,
  
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
    CREATE table role_x_permission (
      `role_id` int(10) unsigned NOT NULL,
      `permission_id` int(10) unsigned NOT NULL,
      FOREIGN KEY (`role_id`)
      REFERENCES `role`(`id`),
      FOREIGN KEY (`permission_id`)
      REFERENCES `permission`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
    CREATE table group_x_role (
      `group_id` int(10) unsigned NOT NULL,
      `role_id` int(10) unsigned NOT NULL,
      FOREIGN KEY (`group_id`)
      REFERENCES `group`(`id`),
      FOREIGN KEY (`role_id`)
      REFERENCES `role`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
    CREATE table user_x_group (
      `user_id` int(10) unsigned NOT NULL,
      `group_id` int(10) unsigned NOT NULL,
      FOREIGN KEY (`user_id`)
      REFERENCES `user`(`id`),
      FOREIGN KEY (`group_id`)
      REFERENCES `group`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
    CREATE table product_attribute_value_x_lang (
      `product_attribute_value_id` int(10) unsigned NOT NULL,
      `lang_id` int(10) unsigned NOT NULL,
      FOREIGN KEY (`product_attribute_value_id`)
      REFERENCES `product_attribute_value`(`id`),
      FOREIGN KEY (`lang_id`)
      REFERENCES `lang`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
    CREATE table product_attribute_x_product_attribute_value (
      `product_attribute_id` int(10) unsigned NOT NULL,
      `product_attribute_value_id` int(10) unsigned NOT NULL,
      FOREIGN KEY (`product_attribute_id`)
      REFERENCES `product_attribute`(`id`),
      FOREIGN KEY (`product_attribute_value_id`)
      REFERENCES `product_attribute_value`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
    CREATE table product_x_product_category (
      `product_id` int(10) unsigned NOT NULL,
      `product_category_id` int(10) unsigned NOT NULL,
      FOREIGN KEY (`product_id`)
      REFERENCES `product`(`id`),
      FOREIGN KEY (`product_category_id`)
      REFERENCES `product_category`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
    CREATE table product_x_product_attribute (
      `product_id` int(10) unsigned NOT NULL,
      `product_attribute_id` int(10) unsigned NOT NULL,
      FOREIGN KEY (`product_id`)
      REFERENCES `product`(`id`),
      FOREIGN KEY (`product_attribute_id`)
      REFERENCES `product_attribute`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
    CREATE table customer_x_invoice (
      `customer_id` int(10) unsigned NOT NULL,
      `invoice_id` int(10) unsigned NOT NULL,
      FOREIGN KEY (`customer_id`)
      REFERENCES `customer`(`id`),
      FOREIGN KEY (`invoice_id`)
      REFERENCES `invoice`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  