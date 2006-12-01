--TEST--
PersistentObject update test
--SKIPIF--
<?php
include_once ('tiki-setup.php');

$tikilib->query('DROP TABLE IF EXISTS superc');
$tikilib->query('create table superc (id int(11) not null auto_increment, aString text, aInt int(5), primary key (id))');
$tikilib->query('DROP TABLE IF EXISTS child');
$tikilib->query('create table child (id int(11) not null, someText text, primary key (id))');
$tikilib->query('DROP TABLE IF EXISTS child2');
$tikilib->query('create table child2 (id int(11) not null, anotherInt int(5), primary key (id))');

?>
--FILE--
<?php

ini_set('display_errors', 'false');

include_once ('tiki-setup.php');
require_once ('lib/persistentObj/PersistentObject.php');

class SuperC extends PersistentObject {

    var $aString;
    var $aInt;
    
}

class Child extends SuperC {

    var $someText;

}

class Child2 extends SuperC {

    var $anotherInt;

}

$child = new Child(array('aString' => 'super string', 'aInt' => 12, 'someText' => 'child string'));

//update nos dois

$child->update(array('aString' => 'super updated', 'someText' => 'child updated'));

printf("child $child->id $child->aString $child->aInt $child->someText\n");

$result = $tikilib->query('select * from superc');
while ($row = $result->fetchRow()) {
	printf("superc " . $row['id'] . " " . $row['aString'] . " " . $row['aInt'] . "\n");
}
$result = $tikilib->query('select * from child');
while ($row = $result->fetchRow()) {
	printf("child " . $row['id'] . " " . $row['someText'] . "\n");
}

//update soh na super

$child->update(array('aInt' => 21));

printf("child $child->id $child->aString $child->aInt $child->someText\n");

$result = $tikilib->query('select * from superc');
while ($row = $result->fetchRow()) {
	printf("superc " . $row['id'] . " " . $row['aString'] . " " . $row['aInt'] . "\n");
}
$result = $tikilib->query('select * from child');
while ($row = $result->fetchRow()) {
	printf("child " . $row['id'] . " " . $row['someText'] . "\n");
}

//update soh na child

$child->update(array('someText' => 'oh yeah'));

printf("child $child->id $child->aString $child->aInt $child->someText\n");

$result = $tikilib->query('select * from superc');
while ($row = $result->fetchRow()) {
	printf("superc " . $row['id'] . " " . $row['aString'] . " " . $row['aInt'] . "\n");
}
$result = $tikilib->query('select * from child');
while ($row = $result->fetchRow()) {
	printf("child " . $row['id'] . " " . $row['someText'] . "\n");
}

?>
--EXPECT--
child 1 super updated 12 child updated
superc 1 super updated 12
child 1 child updated
child 1 super updated 21 child updated
superc 1 super updated 21
child 1 child updated
child 1 super updated 21 oh yeah
superc 1 super updated 21
child 1 oh yeah