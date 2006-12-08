--TEST--
PersistentObject simple 1 to many relation test
--SKIPIF--
<?php
include_once ('tiki-setup.php');

$tikilib->query('DROP TABLE IF EXISTS superc');
$tikilib->query('create table superc (id int(11) not null auto_increment, aString text, aInt int(5), primary key (id))');
$tikilib->query('DROP TABLE IF EXISTS child');
$tikilib->query('create table child (id int(11) not null auto_increment, supercId int(11) not null, someText text, primary key (id))');

?>
--FILE--
<?php

ini_set('display_errors', 'false');

include_once ('tiki-setup.php');
require_once ('lib/persistentObj/PersistentObject.php');

class SuperC extends PersistentObject {

    var $aString;
    var $aInt;
    var $hasMany = array('SuperC' => 'Child');
}

class Child extends PersistentObject {

    var $someText;
	var $supercId;
	var $belongsTo = array("SuperC");

}

$super = new SuperC(array('aString' => 'la', 'aInt' => 5));
$child = new Child(array('someText' => 'child string', 'supercId' => 1));
$child2 = new Child(array('someText' => 'child2 string', 'supercId' => 1));

$super = new SuperC(1);
foreach ($super->childs as $child) {
	printf("child $child->someText\n");
}

$child = $super->childs[0];
if (isset($child->superc)) {
	printf("should not print");
}

$child = new Child(1);
$super = $child->superc;
printf("super $super->aString $super->aInt\n");

$child1 = $child->superc->childs[0];
$child2 = $child->superc->childs[1];
printf("child $child1->someText\n");
printf("child $child2->someText\n");

?>
--EXPECT--child child string
child child string
child child2 string
super la 5
child child string
child child2 string