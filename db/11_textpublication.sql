--
-- Table structure for table `imagepublication`
--

DROP TABLE IF EXISTS `imagepublication`;
CREATE TABLE `imagepublication` (
  `id` int(11) NOT NULL,
  `typeOfText` varchar(255),
  `language` varchar(255),
  `pages` int(11),
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
