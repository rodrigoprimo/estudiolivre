--TEST--
PersistentObject updateWithCheck test
--SKIPIF--
<?php
include_once ('tiki-setup.php');

$tikilib->query('DROP TABLE IF EXISTS superc');
$tikilib->query('create table superc (id int(11) not null auto_increment, aString text, aInt int(5), primary key (id))');
$tikilib->query('DROP TABLE IF EXISTS child');
$tikilib->query('create table child (id int(11) not null, someText text, primary key (id))');

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

	function checkField_someText($text) {
		if ($text != 'lala') trigger_error("Campo someText deve ser = 'lala'!!!!", E_USER_ERROR);
	}
  
}

$child = new Child(array('aString' => 'super string', 'aInt' => 12, 'someText' => 'lala'));

printf("antes do update, deve imprimir\n");

$child2 = new Child(array('aString' => 'super string', 'aInt' => 12, 'someText' => 'abs'));

printf("não deve imprimir por causa do erro acima!\n");

$child->update(array('someText' => 'child updated'));

printf("não deve imprimir por causa dos erros acima!\n");

?>
--EXPECT--
antes do update, deve imprimir