--
-- Table structure for table `publication`
--

DROP TABLE IF EXISTS `publication`;
CREATE TABLE `publication` (
  `id` int(11) NOT NULL auto_increment,
  `licenseId` int(11) NOT NULL,
  `collectionId` int(11) NOT NULL,
  `user` varchar(40) NOT NULL,
  `publishDate` int(11) NOT NULL,
  `author` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` TEXT NOT NULL,
  `thumbnail` varchar(255) NOT NULL,
  `copyrightOwner` varchar(255) NOT NULL,
  `producer` varchar(255) NOT NULL,
  `contact` varchar(255) NOT NULL,
  `site` varchar(255) NOT NULL,
  `rating` tinyint(4) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `licenseId` (`licenseId`),
  KEY `collectionId` (`collectionId`),
  KEY `user` (`user`),
  KEY `publishDate` (`publishDate`),
  KEY `author` (`author`),
  KEY `title` (`title`),
  FULLTEXT KEY `description` (`description`),
  KEY `thumbnail` (`thumbnail`),
  KEY `copyrightOwner` (`copyrightOwner`),
  KEY `producer` (`producer`),
  KEY `contact` (`contact`),
  KEY `site` (`site`),
  KEY `rating` (`rating`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
