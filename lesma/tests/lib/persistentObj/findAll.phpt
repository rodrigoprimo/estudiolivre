--TEST--
PersistentObjectController findAll test
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

$cc = new PersistentObjectController('Child');
$cc2 = new PersistentObjectController('Child2');

$childs = $cc->findAll();
$child2s = $cc2->findAll();

foreach ($childs as $children) {
	printf("child $children->id $children->aString $children->aInt $children->someText\n");
}
foreach ($child2s as $children2)
printf("child2 $children2->id $children2->aString $children2->aInt $children2->anotherInt\n");

?>
--EXPECT--
child 1 super string 12 child string
child 3 lonely 0 
child 4   ohmygod
child2 2 another super string 69 54