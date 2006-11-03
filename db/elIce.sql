CREATE TABLE `el_ice` (
	`user` varchar(40) NOT NULL, key(user),
	`mountPoint` varchar(150) NOT NULL,
	`password` varchar(150) NOT NULL,
	PRIMARY KEY  (`mountPoint`)) ENGINE=MyISAM;
