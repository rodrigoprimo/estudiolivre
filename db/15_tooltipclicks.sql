--
-- Table structure for table `tiki_tooltip_clicks`
--

DROP TABLE IF EXISTS `tiki_tooltip_clicks`;
CREATE TABLE `tiki_tooltip_clicks` (
  `user` varchar(40) NOT NULL default '',
  `tipName` varchar(40) NOT NULL default '',
  `clicks` int(4) NOT NULL default '0',
  PRIMARY KEY  (`user`,`tipName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

