--
-- Table structure for table `textfile`
--

DROP TABLE IF EXISTS `textfile`;
CREATE TABLE `textfile` (
  `id` int(11) NOT NULL,
  `encoding` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `encoding` (`encoding`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
