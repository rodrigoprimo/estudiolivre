CREATE TABLE `tiki_freetags` (
  `tagId` int(10) unsigned NOT NULL auto_increment,
  `tag` varchar(30) NOT NULL default '',
  `raw_tag` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`tagId`)
) TYPE=MyISAM;

#2005-12-06 lfagundes

ALTER TABLE `tiki_categorized_objects` rename to `tiki_objects`;
ALTER TABLE `tiki_objects` CHANGE `catObjectId` `objectId` int(12) not null auto_increment;
ALTER TABLE `tiki_objects` CHANGE `objId` `itemId` varchar(255);

CREATE TABLE `tiki_freetagged_objects` (
  `tagId` int(12) NOT NULL auto_increment,
  `objectId` int(11) NOT NULL default 0,
  `user` varchar(40) NOT NULL default '',
  `created` int(14) NOT NULL default '0',
  PRIMARY KEY  (`tagId`,`user`,`objectId`),
  KEY (`tagId`),
  KEY (`user`),
  KEY (`objectId`)
) TYPE=MyISAM;

#2005-12-07 lfagundes

CREATE TABLE `tiki_categorized_objects` (
  `catObjectId` int(11) NOT NULL default '0',
  PRIMARY KEY  (`catObjectId`)
) TYPE=MyISAM ;

#2005-12-09 lfagundes

INSERT INTO `tiki_categorized_objects` SELECT `objectId` FROM `tiki_objects`;

# nao da pra ligar pelo admin
insert into `tiki_preferences` values ('feature_freetags','y');
insert into `tiki_preferences` values ('feature_morcego','y');

INSERT INTO users_permissions (permName, permDesc, level, type) VALUES ('tiki_p_view_freetags', 'Can browse freetags', 'basic', 'freetags');
INSERT INTO users_permissions (permName, permDesc, level, type) VALUES ('tiki_p_freetags_tag', 'Can tag objects', 'registered', 'freetags');
INSERT INTO tiki_menu_options (menuId,type,name,url,position,section,perm,groupname) VALUES (42,'o','Freetags','tiki-browse_freetags.php',27,'feature_freetags','tiki_p_view_freetags','');
