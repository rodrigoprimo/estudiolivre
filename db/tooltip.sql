CREATE TABLE `tiki_tooltip_clicks` (
	`user`	varchar(40) NOT NULL,
	`tipName` varchar(40) NOT NULL,
	`clicks` int(4) NOT NULL DEFAULT 0,
	PRIMARY KEY (`user`, `tipName`)
);
