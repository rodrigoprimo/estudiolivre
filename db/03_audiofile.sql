--
-- Table structure for table `audiofile`
--

DROP TABLE IF EXISTS `audiofile`;
CREATE TABLE `audiofile` (
  `id` int(11) NOT NULL,
  `duration` int(11) NOT NULL,
  `bpm` int(11) NOT NULL,
  `sampleRate` int(11) NOT NULL,
  `bitRate` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `duration` (`duration`),
  KEY `bpm` (`bpm`),
  KEY `sampleRate` (`sampleRate`),
  KEY `bitRate` (`bitRate`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
