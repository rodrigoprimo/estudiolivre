--TEST--
PersistentObject insert test
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
$child3 = new Child(array('aString' => 'lonely', 'aInt' => 0));
$child5 = new Child(array('someText' => 'ohmygod'));

printf("child $child->id $child->aString $child->aInt $child->someText\n");
printf("child2 $child2->id $child2->aString $child2->aInt $child2->anotherInt\n");
printf("child3 $child3->id $child3->aString $child3->aInt $child3->someText\n");
printf("child5 $child5->id $child5->aString $child5->aInt $child5->someText\n");

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

//isso aqui da erro, precisa morrer 
$child4 = new Child2(array());

printf("isso nao pode imprimir por causa do erro acima\n");

?>
--EXPECT--
child 1 super string 12 child string
child2 2 another super string 69 54
child3 3 lonely 0 
child5 4   ohmygod
superc 1 super string 12
superc 2 another super string 69
superc 3 lonely 0
superc 4  
child 1 child string
child 3 
child 4 ohmygod
child2 2 54