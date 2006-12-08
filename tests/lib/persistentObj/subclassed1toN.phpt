--TEST--
PersistentObject 1 to many subclassed relation test
--SKIPIF--
<?php
include_once ('tiki-setup.php');

$tikilib->query('DROP TABLE IF EXISTS superc');
$tikilib->query('create table superc (id int(11) not null auto_increment, ownerId int(11) not null, aString text, aInt int(5), primary key (id))');
$tikilib->query('DROP TABLE IF EXISTS child');
$tikilib->query('create table child (id int(11) not null, someText text, primary key (id))');
$tikilib->query('DROP TABLE IF EXISTS child2');
$tikilib->query('create table child2 (id int(11) not null, anotherInt int(5), primary key (id))');
$tikilib->query('DROP TABLE IF EXISTS owner');
$tikilib->query('create table owner (id int(11) not null auto_increment, owner varchar(10), primary key (id))');

?>
--FILE--
<?php

ini_set('display_errors', 'false');

include_once ('tiki-setup.php');
require_once ('lib/persistentObj/PersistentObject.php');

class SuperC extends PersistentObject {

	var $ownerId;
    var $aString;
    var $aInt;
    var $belongsTo = array("Owner");
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

class Owner extends PersistentObject {
	
	var $owner;
	var $hasMany = array("Owner" => "SuperC");
	
}

$owner = new Owner(array('owner' => 'a'));
$child = new Child(array('aString' => 'super string', 'ownerId' => 1, 'aInt' => 12, 'someText' => 'child string'));
$child2 = new Child2(array('aString' => 'another super string', 'ownerId' => 1, 'aInt' => 69, 'anotherInt' => 54));

$owner = new Owner(1);
foreach ($owner->supercs as $superc) {
	printf("superc $superc->table\n");
}
$child = $owner->supercs[0];
$child2 = $owner->supercs[1];

printf("child $child->someText\n");
printf("child2 $child2->anotherInt\n");

?>
--EXPECT--
superc child
superc child2
child child string
child2 54