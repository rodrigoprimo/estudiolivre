--TEST--
PersistentObject select test
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

$child2 = new Child(1);

printf("child $child2->id $child2->aString $child2->aInt $child2->someText\n");

$child3 = new Child2(1);

//acima deve dar erro e nao imprimir isso aqui
printf("child2 $child3->id $child3->aString $child3->aInt $child3->anotherInt\n");

?>
--EXPECT--
child 1 super string 12 child string   