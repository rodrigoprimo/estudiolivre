ALTER TABLE `tiki_users` CHANGE `user` `user` VARCHAR( 40 ) NOT NULL DEFAULT '' ;
ALTER TABLE users_groups DROP groupHomeLocalized;

# missing field in primary key:
ALTER TABLE `users_objectpermissions` DROP PRIMARY KEY , ADD PRIMARY KEY ( `objectId` , `objectType` , `groupName` ( 30 ), `permName` ) ;

# 2005-05-03 - amette - correct perm for submitting link - WYSIWYCA
UPDATE tiki_menu_options SET perm="tiki_p_submit_link" WHERE url="tiki-directory_add_site.php";

# 2006-04-13 fixing Typo - amette
UPDATE `users_permissions` SET `permDesc`='Can create user bookmarks' WHERE `permName`='tiki_p_create_bookmarks';

# 2006-04-26 security issue, split template edit perm into edit and view perms
INSERT INTO users_permissions (permName, permDesc, level, type) VALUES ('tiki_p_view_templates', 'Can view site templates', 'admin', 'tiki');

# fixed reserved word use in mysql
ALTER TABLE `tiki_articles` change `reads` `nbreads` int(14) default NULL ;
ALTER TABLE `tiki_submissions` change `reads` `nbreads` int(14) default NULL ;
ALTER TABLE `tiki_articles` DROP INDEX `reads`, ADD INDEX `nbreads` ( `nbreads` ) ;
ALTER TABLE `tiki_submissions` DROP INDEX `reads`, ADD INDEX `nbreads` ( `nbreads` ) ;

# 2006-05-26 new preference eq 'y' to keep the default - sampaioprimo
INSERT IGNORE INTO tiki_preferences(name,value) VALUES ('feature_cms_print','y');

# 2006-07-05 new preferences eq 'y' to keep the default - toggg
INSERT IGNORE INTO tiki_preferences(name,value) VALUES ('feature_trackbackpings','y');
INSERT IGNORE INTO tiki_preferences(name,value) VALUES ('feature_blogposts_pings','y');

# 2006-07-31 slideshow default enabled - toggg
INSERT IGNORE INTO tiki_preferences(name,value) VALUES ('feature_gal_slideshow','y');

#2006-08-14 sylvieg
ALTER TABLE tiki_tracker_item_fields ADD FULLTEXT ft (value);

#2006-09-03 ohertel - missing on 1.8+update vs 1.9 diff
INSERT INTO tiki_modules VALUES ('quick_edit','l',2,NULL,NULL,0,NULL,NULL,'a:1:{i:0;s:10:\"Registered\";}');
INSERT IGNORE INTO tiki_preferences(name,value) VALUES ('feature_help','n');
INSERT IGNORE INTO tiki_preferences(name,value) VALUES ('feature_multilingual','n');
INSERT IGNORE INTO tiki_preferences(name,value) VALUES ('feature_wiki_export','n');
ALTER TABLE `tiki_quizzes` DROP PRIMARY KEY , ADD PRIMARY KEY ( `quizId` , `nVersion` );
ALTER TABLE `tiki_trackers` ADD showAttachments char(1) default NULL AFTER useAttachments;

# 2006-10-21 mose/cfreeze - changed pear auth params to be more generic
update tiki_preferences set name='auth_pear_host' where name='auth_ldap_host';
update tiki_preferences set name='auth_pear_port' where name='auth_ldap_port';

