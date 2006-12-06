--
-- Table structure for table `audiopublication`
--

DROP TABLE IF EXISTS `audiopublication`;
CREATE TABLE `audiopublication` (
  `id` int(11) NOT NULL,
  `typeOfAudio` varchar(255),
  `genre` varchar(255),
  `lyrics` text,
  `details` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
