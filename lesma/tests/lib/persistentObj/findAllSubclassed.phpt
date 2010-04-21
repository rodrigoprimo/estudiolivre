--TEST--
PersistentObjectController findAll instanciating subclasses test
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
require_once ('lib/persistentObj/PersistentObjectController.php');

class SuperC extends PersistentObject {

    var $aString;
    var $aInt;
    
    function subclasses() {
    	return array("Child", "Child2");
    }
}

class Child extends SuperC {

    var $someText;

}

class Child2 extends SuperC {

    var $anotherInt;

}

$child = new Child(array('aString' => 'super string', 'aInt' => 12, 'someText' => 'child string'));
$child2 = new Child2(array('aString' => 'another super string', 'aInt' => 69, 'anotherInt' => 54));
$child3 = new Child(array('aString' => 'lonely', 'aInt' => 0));
$child5 = new Child(array('someText' => 'ohmygod'));

$sc = new PersistentObjectController('SuperC');


$childs = $sc->findAll();

foreach ($childs as $children) {
	printf("child $children->id $children->aString $children->aInt\n");
}
$child = $childs[0];
printf("child $child->someText\n");
$child = $childs[1];
printf("child2 $child->anotherInt\n");

?>
--EXPECT--
child 1 super string 12
child 2 another super string 69
child 3 lonely 0
child 4  
child child string
child2 54