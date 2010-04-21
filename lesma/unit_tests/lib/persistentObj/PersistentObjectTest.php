<?php
// Call PersistentObjectTest::main() if this source file is executed directly.
if (!defined("PHPUnit2_MAIN_METHOD")) {
    define("PHPUnit2_MAIN_METHOD", "PersistentObjectTest::main");
}

include_once "setup/tests-setup.php";

require_once "PHPUnit2/Framework/TestCase.php";
require_once "PHPUnit2/Framework/TestSuite.php";
require_once "PHPUnit2/Framework/IncompleteTestError.php";

require_once "lib/persistentObj/PersistentObject.php";
require_once "lib/field/Field.php";
require_once "lib/field/StringField.php";

function prepareDatabase() {
	global $tikilib;

	clearDatabase();

	$tikilib->query('create table _searchindex (id int(11) not null auto_increment, idObj int(11) not null, type varchar(255) not null, word varchar(255) not null, weight int(11) not null, primary key (id))');
	$tikilib->query('CREATE TABLE `_updatehistory` (`id` int(11) NOT NULL auto_increment, `objType` char(255) NOT NULL, `objId` varchar(100) NOT NULL, `tstamp` int(11) NOT NULL, `version` int(11) NOT NULL, `responsibleType` char(255) NOT NULL, `responsibleId` int(11) NOT NULL, `title` char(255) NOT NULL, `changes` longblob, PRIMARY KEY  (`id`), KEY `objType` (`objType`,`objId`), KEY `version` (`version`), KEY `responsibleType` (`responsibleType`,`responsibleId`))');
	$tikilib->query('create table superc (id int(11) not null auto_increment, aString text, bString varchar(255), aInt int(5), primary key (id))');
	$tikilib->query('create table child (id int(11) not null, someText text, primary key (id))');
	$tikilib->query('create table child2 (id int(11) not null, anotherInt int(5), someOtherInt int(5), primary key (id))');
	$tikilib->query('create table someobject (id int(11) primary key auto_increment, name char(255) not null)');
}

function clearDatabase() {
	global $tikilib;
	$tikilib->query('DROP TABLE IF EXISTS _searchindex');
	$tikilib->query('DROP TABLE IF EXISTS _updatehistory');
	$tikilib->query('DROP TABLE IF EXISTS superc');
	$tikilib->query('DROP TABLE IF EXISTS child');
	$tikilib->query('DROP TABLE IF EXISTS child2');
	$tikilib->query('DROP TABLE IF EXISTS someobject');
}

class SuperC extends PersistentObject {
	var $aString;
	var $aInt;
	var $bString;
	function setup() {
		$this->bString = new StringField("bString", "bString", array('weight' => 5));
		parent::setup();
	}
}

class Child extends SuperC {
	var $someText;
}

class Child2 extends SuperC {
	var $anotherInt;
	var $someOtherInt;
	function checkField_someOtherInt($i) {
            if ($i != 66) trigger_error("Field someOtherInt should always be 66", E_USER_ERROR);
        }
}

class SomeObject extends PersistentObject {
    var $name;
    
    function setup() {
	$this->name = new StringField('name', 'Name', array('versionable' => true));
    }
}

// Tests for PersistentObject
class PersistentObjectTest extends PHPUnit2_Framework_TestCase {

    public static function main() {
        require_once "PHPUnit2/TextUI/TestRunner.php";

        $suite  = new PHPUnit2_Framework_TestSuite("PersistentObjectTest");
        $result = PHPUnit2_TextUI_TestRunner::run($suite);
    }

    protected function setUp() {
        prepareDatabase();
	
	$this->child = new Child(array('aString' => 'super string', 'bString' => 'super stringfield super', 'aInt' => 12, 'someText' => 'child string'));

	$this->object = new SomeObject(array('name' => 'First Version'));
    }

    protected function tearDown() {
        $this->child = NULL;
	clearDatabase();
    }

    public function testSetup() {
        $this->assertEquals("super stringfield super", $this->child->fields["bString"]->getValue());
    }

    public function testInsert_ShouldCreateObject() {
        $child2 = new Child2(array('aString' => 'another super string', 'aInt' => 69, 'anotherInt' => 54));
	$child3 = new Child(array('aString' => 'lonely', 'aInt' => 0));
	$child5 = new Child(array('someText' => 'ohmygod'));

	// assertEquals (in PHPUnit)  cant compare int with int, only floats. 
        $this->assertEquals((float)2, (float)$child2->id);
        $this->assertEquals("another super string", $child2->aString);
        $this->assertEquals((float)69, (float)$child2->aInt);
	$this->assertEquals(54, $child2->anotherInt);

        $this->assertEquals((float)3, (float)$child3->id);
        $this->assertEquals("lonely", $child3->aString);
        $this->assertEquals((float)0, (float)$child3->aInt);
	$this->assertEquals((string)"", (string)$child3->someText);

        $this->assertEquals((float)4, (float)$child5->id);
        $this->assertEquals("", (string)$child5->aString);
        $this->assertEquals((float)0, (float)$child5->aInt);
	$this->assertEquals("ohmygod", $child5->someText);
    }

    public function testInsert_ShouldInsertToDatabase() {
        $child2 = new Child2(array('aString' => 'another super string', 'aInt' => 69, 'anotherInt' => 54));
	$child3 = new Child(array('aString' => 'lonely', 'aInt' => 0));
	$child5 = new Child(array('someText' => 'ohmygod'));

	global $tikilib;

	$result = $tikilib->query('select * from superc'); 
	$row = $result->fetchRow();
	$this->assertEquals((float)1, (float)$row['id']);
	$this->assertEquals("super string", $row['aString']);
	$this->assertEquals((float)12, (float)$row['aInt']);
	 
	$result = $tikilib->query('select * from child'); 
	$row = $result->fetchRow();
	$this->assertEquals((float)1, (float)$row['id']);
	$this->assertEquals("child string", $row['someText']);
	
	$result = $tikilib->query('select * from child2'); 
	$row = $result->fetchRow();
	$this->assertEquals((float)2, (float)$row['id']);
	$this->assertEquals((float)54, (float)$row['anotherInt']);
       	
    }

    public function testInsert_ShouldIndexObject() {
        global $tikilib;
	$result = $tikilib->query("select * from _searchindex where idObj = '?' and word = 'super'", array($this->child->id));
	$row = $result->fetchRow();
	$this->assertEquals('Child', $row['type']);
	$this->assertEquals((float)10, (float)$row['weight']);
    }
    
    public function testUpdate_ShouldUpdateObjectData() {
        $this->child->update(array('aString' => 'super updated', 'bString' => 'super stringfield updated', 'someText' => 'child updated'));
        $this->assertEquals((float)1, (float)$this->child->id);
        $this->assertEquals("super updated", $this->child->aString);
        $this->assertEquals("super stringfield updated", $this->child->bString->getValue());
	$this->assertEquals("child updated", $this->child->someText);
    }

    public function testUpdate_ShouldUpdateDataBase() { 
        global $tikilib;
        $this->child->update(array('aString' => 'super updated', 'aInt' => 41));
	$result = $tikilib->query('select * from superc where id = 1');
	$row = $result->fetchRow();

	$this->assertEquals((float)1, (float)$row['id']);
        $this->assertEquals("super updated", $row['aString']);
	$this->assertEquals((float)41, (float)$row['aInt']);
    }

    public function testUpdate_Rollback() {
	global $tikilib;

	$firstVersion = $this->object->getVersion();
	$firstName = $this->object->name->getValue();

	$this->object->update(array('name' => 'Second version'), $this->child);

	$secondVersion = $this->object->getVersion();
	
	$this->assertTrue($firstVersion < $secondVersion, "Object version didn't evolve");

	$this->object->rollback($firstVersion, $this->child);

	$this->assertTrue($secondVersion < $this->object->getVersion(), "Object version didn't evolve after rollback");
	$this->assertEquals($firstName, $this->object->name->getValue(), "Rollback didn't restore original name");
    }

    public function testUpdate_ShouldUpdateIndex() {
        global $tikilib;
        $this->child->update(array('bString' => 'super updated', 'aInt' => 41));
	$result = $tikilib->query("select * from _searchindex where idObj = '?' and word = 'super'", array($this->child->id));
	$row = $result->fetchRow();
	$this->assertEquals('Child', $row['type']);
	$this->assertEquals((float)5, (float)$row['weight']);
    }


/* TODO: Finish this test
    public function testCheckField_ShouldRaiseException() { 
	try {
            $child2 = new Child2(array('aString' => 'another super string', 'aInt' => 69, 'anotherInt' => 54, 'someOtherInt', 65));
	} catch (Exception $e) {
            return;
	}
        $this->fail('An Exception was expected.');	
    }
 */

    public function testDelete_ShouldRaiseException() {
        $id = $this->child->id;
        $this->child->delete();
        try {
	    $this->child = new Child($id);
	} catch (Exception $expected) {
            return;
        }
        $this->fail('An Exception was expected.');	
    }

    public function testDelete_ShouldDeleteIndex() {
        global $tikilib;
        $this->child->delete();
	$result = $tikilib->query("select * from _searchindex where idObj = '?'", array($this->child->id));
	if (($row = $result->fetchrow())) {
		$this->assertFail("The index was not deleted");
	}
    }

    public function testSelect() {
        $child2 = new Child(1);
        $this->assertEquals((float)1, (float)$child2->id);
        $this->assertEquals("super string", $child2->aString);
        $this->assertEquals((float)12, (float)$child2->aInt);
        $this->assertEquals("child string", $child2->someText);
    }

    
}

// Call PersistentObjectTest::main() if this source file is executed directly.
if (PHPUnit2_MAIN_METHOD == "PersistentObjectTest::main") {
    PersistentObjectTest::main();
}
?>
