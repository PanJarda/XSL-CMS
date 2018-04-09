SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP DATABASE IF EXISTS `jennifer_doe`;
CREATE DATABASE `jennifer_doe` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `jennifer_doe`;

DROP TABLE IF EXISTS `academic_positions`;
CREATE TABLE `academic_positions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `start_year` year(4) NOT NULL,
  `end_year` year(4) DEFAULT NULL,
  `position_name` varchar(255) DEFAULT NULL,
  `university` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `academic_positions` (`id`, `start_year`, `end_year`, `position_name`, `university`, `department`) VALUES
(1, '2004', '2005', 'General Atlantic Professor', 'Stanford University',  'Graduate School of Business'),
(2, '2004', '2005', 'General Atlantic Professor', 'Stanford University',  'Graduate School of Business'),
(3, '2004', '2005', 'General Atlantic Professor', 'Stanford University',  'Graduate School of Business'),
(4, '2004', '2005', 'General Atlantic Professor', 'Stanford University',  'Graduate School of Business');