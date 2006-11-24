-- MySQL dump 10.9
--
-- Host: localhost    Database: estudiolivre
-- ------------------------------------------------------
-- Server version	4.1.12-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES latin1 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `el_tipos_arquivo`
--

DROP TABLE IF EXISTS `el_tipos_arquivo`;
CREATE TABLE `el_tipos_arquivo` (
  `tipoId` int(11) NOT NULL auto_increment,
  `nome` varchar(64) default NULL,
  `descricao` text,
  PRIMARY KEY  (`tipoId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `el_tipos_arquivo`
--


/*!40000 ALTER TABLE `el_tipos_arquivo` DISABLE KEYS */;
LOCK TABLES `el_tipos_arquivo` WRITE;
INSERT INTO `el_tipos_arquivo` VALUES (1,'Video',NULL),(2,'Audio',NULL),(3,'Imagem',NULL),(4,'Texto',NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `el_tipos_arquivo` ENABLE KEYS */;

--
-- Table structure for table `el_licenca`
--

DROP TABLE IF EXISTS `el_licenca`;
CREATE TABLE `el_licenca` (
  `licencaId` int(11) NOT NULL auto_increment,
  `tipo` varchar(64) NOT NULL default '',
  `subTipo` varchar(96) default NULL,
  `descricao` text,
  `linkImagem` varchar(150) default NULL,
  `linkHumanReadable` varchar(150) default NULL,
  PRIMARY KEY  (`licencaId`),
  KEY `tipo` (`tipo`),
  KEY `subTipo` (`subTipo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `el_licenca`
--


/*!40000 ALTER TABLE `el_licenca` DISABLE KEYS */;
LOCK TABLES `el_licenca` WRITE;
INSERT INTO `el_licenca` VALUES (1,'Sampling','Sampling','','iLicSampling.png','http://creativecommons.org/licenses/sampling/1.0/br/'),(2,'Sampling','Sampling Plus','Você pode samplear, mesclar ou transformar a obra para fins comerciais e não-comerciais. É permitido executar, exibir e distribuir cópias desta obra para fins não-comerciais.','iLicSamplingPlus.png','http://creativecommons.org/licenses/sampling+/1.0/br/'),(3,'Sampling','Sampling Plus Non-Comercial','Você pode samplear, mesclar, transformar, executar, exibir e distribuir cópias desta obra para fins não-comerciais.','iLicSamplingPlusNc.png','http://creativecommons.org/licenses/nc-sampling+/1.0/br/'),(4,'Atribution','Atribution','Você pode copiar, distribuir, exibir e executar, alterar, transformar ou utilizar esta obra para criar outra obra com base nesta, para fins comerciais e não-comerciais.','iLicBy.png','http://creativecommons.org/licenses/by/2.5/br/'),(5,'Atribution','Atribution Non-Comercial','Você pode copiar, distribuir, exibir e executar, alterar, transformar ou utilizar esta obra para criar outra obra com base nesta, para fins não-comerciais.','iLicByNc.png','http://creativecommons.org/licenses/by-nc/2.5/br/'),(6,'Atribution','Atribution Non-Comercial No Derivatives','Você pode copiar, distribuir, exibir e executar esta obra para fins não-comerciais, mas não pode alterá-la, transformá-la ou utilizá-la para criar outra obra com base nesta.','iLicByNcNd.png','http://creativecommons.org/licenses/by-nc-nd/2.5/br/'),(7,'Atribution','Atribution Non-Comercial Share-Alike','Você pode copiar, distribuir, exibir e executar, alterar, transformar ou utilizar esta obra para criar outra obra com base nesta, para fins não-comerciais, mas deverá publicá-la pela mesma licença.','iLicByNcSa.png','http://creativecommons.org/licenses/by-nc-sa/2.5/br/'),(8,'Atribution','Atribution No Derivatives','Você pode copiar, distribuir, exibir e executar esta obra para fins comerciais e não-comerciais, mas não pode alterá-la, transformá-la ou utilizá-la para criar outra obra com base nesta.','iLicByNd.png','http://creativecommons.org/licenses/by-nd/2.5/br/'),(9,'Atribution','Atribution Share-Alike','Você pode copiar, distribuir, exibir e executar, alterar, transformar ou utilizar esta obra para criar outra obra com base nesta, para fins comerciais e não-comerciais, mas deverá publicá-la pela mesma licença.','iLicBySa.png','http://creativecommons.org/licenses/by-sa/2.5/br/');
UNLOCK TABLES;
/*!40000 ALTER TABLE `el_licenca` ENABLE KEYS */;

--
-- Table structure for table `el_arquivo`
--

DROP TABLE IF EXISTS `el_arquivo`;
CREATE TABLE `el_arquivo` (
  `arquivoId` int(11) NOT NULL auto_increment,
  `idFisico` varchar(150) default NULL,
  `tipo` varchar(10) NOT NULL default '',
  `user` varchar(40) NOT NULL default '',
  `licencaId` int(11) NOT NULL default '0',
  `publicado` tinyint(1) NOT NULL default '0',
  `data_publicacao` int(11) NOT NULL default '0',
  `titulo` varchar(255) NOT NULL default '',
  `autor` varchar(32) NOT NULL default '',
  `donoCopyright` varchar(32) NOT NULL default '',
  `arquivo` varchar(150) NOT NULL default '',
  `formato` varchar(32) NOT NULL default '',
  `tamanho` int(40) default NULL,
  `descricao` text,
  `produtora` varchar(100) default NULL,
  `contato` varchar(100) default NULL,
  `iSampled` varchar(255) default NULL,
  `sampledMe` varchar(255) default NULL,
  `siteRelacionado` varchar(255) default NULL,
  `rating` tinyint(4) NOT NULL default '0',
  `hits` int(11) NOT NULL default '0',
  `streamHits` int(11) NOT NULL default '0',
  `thumbnail` varchar(255) NOT NULL default '',
  `editCache` blob NOT NULL,
  PRIMARY KEY  (`arquivoId`),
  KEY `idFisico` (`idFisico`),
  KEY `tipo` (`tipo`),
  KEY `user` (`user`),
  KEY `licencaId` (`licencaId`),
  KEY `publicado` (`publicado`),
  KEY `data_publicacao` (`data_publicacao`),
  KEY `titulo` (`titulo`),
  KEY `autor` (`autor`),
  KEY `donoCopyright` (`donoCopyright`),
  KEY `arquivo` (`arquivo`),
  KEY `formato` (`formato`),
  KEY `tamanho` (`tamanho`),
  KEY `produtora` (`produtora`),
  KEY `contato` (`contato`),
  KEY `iSampled` (`iSampled`),
  KEY `sampledMe` (`sampledMe`),
  KEY `siteRelacionado` (`siteRelacionado`),
  KEY `rating` (`rating`),
  FULLTEXT KEY `descricao` (`descricao`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `el_arquivo_audio`
--

DROP TABLE IF EXISTS `el_arquivo_audio`;
CREATE TABLE `el_arquivo_audio` (
  `arquivoId` int(11) NOT NULL default '0',
  `duracao` int(11) NOT NULL default '0',
  `tipoDoAudio` varchar(8) NOT NULL default '',
  `bpm` int(11) NOT NULL default '0',
  `sampleRate` int(11) NOT NULL default '0',
  `bitRate` int(11) NOT NULL default '0',
  `genero` varchar(50) default NULL,
  `letra` text,
  `fichaTecnica` text,
  `album` varchar(64) default NULL,
  PRIMARY KEY  (`arquivoId`),
  KEY `duracao` (`duracao`),
  KEY `tipoDoAudio` (`tipoDoAudio`),
  KEY `bpm` (`bpm`),
  KEY `sampleRate` (`sampleRate`),
  KEY `bitRate` (`bitRate`),
  KEY `genero` (`genero`),
  FULLTEXT KEY `letra` (`letra`),
  FULLTEXT KEY `fichaTecnica` (`fichaTecnica`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `el_arquivo_video`
--

DROP TABLE IF EXISTS `el_arquivo_video`;
CREATE TABLE `el_arquivo_video` (
  `arquivoId` int(11) NOT NULL default '0',
  `duracao` int(11) NOT NULL default '0',
  `tamanhoImagemX` int(11) NOT NULL default '0',
  `tamanhoImagemY` int(11) NOT NULL default '0',
  `temAudio` tinyint(1) NOT NULL default '1',
  `temCor` tinyint(1) NOT NULL default '1',
  `idioma` varchar(20) default NULL,
  `legendas` tinyint(1) NOT NULL default '0',
  `idiomaLegenda` varchar(20) default NULL,
  `fichaTecnica` text,
  PRIMARY KEY  (`arquivoId`),
  KEY `duracao` (`duracao`),
  KEY `tamanhoImagemX` (`tamanhoImagemX`),
  KEY `tamanhoImagemY` (`tamanhoImagemY`),
  KEY `temAudio` (`temAudio`),
  KEY `temCor` (`temCor`),
  KEY `idioma` (`idioma`),
  KEY `legendas` (`legendas`),
  KEY `idiomaLegenda` (`idiomaLegenda`),
  FULLTEXT KEY `fichaTecnica` (`fichaTecnica`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `el_arquivo_imagem`
--

DROP TABLE IF EXISTS `el_arquivo_imagem`;
CREATE TABLE `el_arquivo_imagem` (
  `arquivoId` int(11) NOT NULL default '0',
  `tamanhoImagemX` int(11) NOT NULL default '0',
  `tamanhoImagemY` int(11) NOT NULL default '0',
  `dpi` int(11) NOT NULL default '0',
  PRIMARY KEY  (`arquivoId`),
  KEY `tamanhoImagemX` (`tamanhoImagemX`),
  KEY `tamanhoImagemY` (`tamanhoImagemY`),
  KEY `dpi` (`dpi`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `el_arquivo_rating`
--

DROP TABLE IF EXISTS `el_arquivo_rating`;
CREATE TABLE `el_arquivo_rating` (
  `arquivoId` int(11) NOT NULL default '0',
  `user` char(40) NOT NULL default '',
  `rating` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`arquivoId`,`user`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `el_ice`
--

DROP TABLE IF EXISTS `el_ice`;
CREATE TABLE `el_ice` (
  `user` varchar(40) NOT NULL default '',
  `mountPoint` varchar(150) NOT NULL default '',
  `password` varchar(150) NOT NULL default '',
  PRIMARY KEY  (`mountPoint`),
  KEY `user` (`user`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

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

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

