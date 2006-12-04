--TEST--
FileReference updates and delete test
--SKIPIF--
<?php
include_once ('tiki-setup.php');

$tikilib->query('DROP TABLE IF EXISTS filereference');
$tikilib->query('create table filereference (id int(11) not null auto_increment, publicationId int(11) not null, fileName varchar(255) not null, mimeType varchar(255) not null, size int(11) not null, downloads int(11) not null default 0, streams int(11) not null default 0, primary key (id, publicationId))');
$tikilib->query("insert into filereference (publicationId, fileName, mimeType, size) values(1, '1-file.txt', 'text/plain', 5)");

system("echo 'asdf' > repo/1-file.txt");

?>
--FILE--
<?php

ini_set('display_errors', 'false');

include_once ('tiki-setup.php');
require_once ('lib/elgal/model/FileReference.php');

$myFile = new FileReference(1);

printf("file $myFile->id $myFile->publicationId $myFile->mimeType $myFile->size $myFile->fileName\n");
if (file_exists('repo/1-file.txt')) {
	printf("file exists\n");
}
printf($myFile->parseFileName() . "\n");
printf($myFile->parseDownloadName() . "\n");

$myFile->hitDownload();
printf("$myFile->downloads\n");
printf($myFile->getOne("select downloads from filereference where id = 1") . "\n");
$myFile->hitStream();
printf("$myFile->streams\n");
printf($myFile->getOne("select streams from filereference where id = 1") . "\n");

$myFile->delete();
printf($myFile->getOne("select * from filereference where id = 1"));
if (file_exists('repo/1-file.txt')) {
	printf("oops file exists\n");
}

?>
--EXPECT--
file 1 1 text/plain 5 1-file.txt
file exists
file
file.txt
1
1
1
1