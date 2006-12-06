--
-- Table structure for table `videofile`
--

DROP TABLE IF EXISTS `videofile`;
CREATE TABLE `videofile` (
  `id` int(11) NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `dpi` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
