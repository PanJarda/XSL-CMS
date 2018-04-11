INSERT INTO `lang` (`id`, `name`) VALUES
(1, 'cs'),
(2, 'en');


INSERT INTO `academic_position` (`id`, `start_year`, `end_year`, `position_name`, `university`, `department`, `langId`) VALUES
(1, '2004', '2005', 'General Atlantic Professor', 'Stanford University',  'Graduate School of Business', 1),
(2, '2004', '2005', 'General Atlantic Professor', 'Stanford University',  'Graduate School of Business', 1),
(3, '2004', '2005', 'General Atlantic Professor', 'Stanford University',  'Graduate School of Business', 1),
(4, '2004', '2005', 'General Atlantic Professor', 'Stanford University',  'Graduate School of Business', 1);

INSERT INTO `customer` (`name`, `address`)
VALUES ('Jarda', 'sdfsfasfs');

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'counterfeit');

INSERT INTO `product` (`type`, `name`, `desc`, `price`, `category`, `specs`, `categoryId`)
VALUES ('fsf', 'faf', 'fsfas', '', '', '', '1');