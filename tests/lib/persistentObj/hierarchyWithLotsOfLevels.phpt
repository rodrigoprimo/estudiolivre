--TEST--
PersistentObject hierarchy with lots of levels test
--SKIPIF--
<?php
include_once ('tiki-setup.php');

$tikilib->query('DROP TABLE IF EXISTS superc');
$tikilib->query('create table superc (id int(11) not null auto_increment, aString text, aInt int(5), primary key (id))');
$tikilib->query('DROP TABLE IF EXISTS child');
$tikilib->query('create table child (id int(11) not null, someText text, primary key (id))');
$tikilib->query('DROP TABLE IF EXISTS child2');
$tikilib->query('create table child2 (id int(11) not null, anotherInt int(5), primary key (id))');
$tikilib->query('DROP TABLE IF EXISTS child3');
$tikilib->query('create table child3 (id int(11) not null, bo int(5), primary key (id))');

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

class Child2 extends Child {

    var $anotherInt;

    function Child2($fields) {
		parent::construct($fields);
    }

  
}

class Child3 extends Child2 {

    var $bo;

    function Child2($fields) {
		parent::construct($fields);
    }

  
}

//testando insert
$child = new Child(array('aString' => 'super string', 'aInt' => 12, 'someText' => 'child string'));
$child2 = new Child2(array('aString' => 'another super string', 'aInt' => 69, 'someText' => 'child2 string', 'anotherInt' => 54));
$child3 = new Child3(array('aString' => 'anoperstri', 'aInt' => 9, 'someText' => 'child3', 'anotherInt' => 4, 'bo' => 3));

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

$result = $tikilib->query('select * from child3');
while ($row = $result->fetchRow()) {
	printf("child3 " . $row['id'] . " " . $row['bo'] . "\n");
}

$child3->update(array('anotherInt' => 666)); 

$result = $tikilib->query('select * from child2');
while ($row = $result->fetchRow()) {
	printf("child2 " . $row['id'] . " " . $row['anotherInt'] . "\n");
}

$child3->delete();

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

$result = $tikilib->query('select * from child3');
while ($row = $result->fetchRow()) {
	printf("child3 " . $row['id'] . " " . $row['bo'] . "\n");
}

?>
--EXPECT--
superc 1 super string 12
superc 2 another super string 69
superc 3 anoperstri 9
child 1 child string
child 2 child2 string
child 3 child3
child2 2 54
child2 3 4
child3 3 3
child2 2 54
child2 3 666
superc 1 super string 12
superc 2 another super string 69
child 1 child string
child 2 child2 string
child2 2 54