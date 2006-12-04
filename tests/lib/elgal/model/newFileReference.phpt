--TEST--
FileReference new test
--SKIPIF--
<?php
include_once ('tiki-setup.php');

$tikilib->query('DROP TABLE IF EXISTS filereference');
$tikilib->query('create table filereference (id int(11) not null auto_increment, publicationId int(11) not null, fileName varchar(255) not null, mimeType varchar(255) not null, size int(11) not null, downloads int(11) not null default 0, streams int(11) not null default 0, primary key (id, publicationId))');

?>
--FILE--
<?php

ini_set('display_errors', 'false');

include_once ('tiki-setup.php');
require_once ('lib/elgal/model/FileReference.php');

$_FILES = array();
$_FILES['my_file'] = array();
$_FILES['my_file']['type'] = 'text/plain';
$_FILES['my_file']['size'] = 5;
$_FILES['my_file']['name'] = 'file.txt';
$_FILES['my_file']['tmp_name'] = '/tmp/file.txt';
$_FILES['my_file']['publicationId'] = 1;

$myFile = new FileReference($_FILES['my_file']);

// should not print anything, since we do not have a valid file upload
printf("file $myFile->id $myFile->publicationId $myFile->mimeType $myFile->size $myFile->fileName\n");
if (file_exists('repo/1-file.txt')) {
	printf("file exists");
}
printf($myFile->parseFileName() . "\n");
printf($myFile->parseDownloadName() . "\n");
if (file_exists('/tmp/file.txt')) {
	printf("oops file exists");
}

?>
--EXPECT--
