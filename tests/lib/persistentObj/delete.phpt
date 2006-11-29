--TEST--
PersistentObject delete test
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

    function Child($fields) {
		parent::construct($fields);
    }

  
}

class Child2 extends SuperC {

    var $anotherInt;

    function Child2($fields) {
		parent::construct($fields);
    }

  
}

$child = new Child(array('aString' => 'super string', 'aInt' => 12, 'someText' => 'child string'));
$child2 = new Child2(array('aString' => 'another super string', 'aInt' => 69, 'anotherInt' => 54));

$child->delete();

$result = $tikilib->query('select * from superc');
while ($row = $result->fetchRow()) {
	printf("superc " . $row['id'] . " " . $row['aString'] . " " . $row['aInt'] . "\n");
}
$result = $tikilib->query('select * from child');
while ($row = $result->fetchRow()) {
	printf("child " . $row['id'] . " " . $row['someText'] . "\n");
}
$result = $tikilib->query('select * from child2');
while ($row = $result->fetchRow()) {
	printf("child2 " . $row['id'] . " " . $row['anotherInt'] . "\n");
}


?>
--EXPECT--
superc 2 another super string 69
child2 2 54