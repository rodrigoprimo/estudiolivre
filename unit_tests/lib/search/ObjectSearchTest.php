<?php
// Call ObjectSearchTest::main() if this source file is executed directly.
if (!defined("PHPUnit2_MAIN_METHOD")) {
    define("PHPUnit2_MAIN_METHOD", "ObjectSearchTest::main");
}

include_once "setup/tests-setup.php";

require_once "PHPUnit2/Framework/TestCase.php";
require_once "PHPUnit2/Framework/TestSuite.php";
require_once "PHPUnit2/Framework/IncompleteTestError.php";

require_once "lib/search/ObjectSearch.php";
require_once "lib/persistentObj/PersistentObject.php";
require_once "lib/field/Field.php";
require_once "lib/field/StringField.php";

function prepareDatabase() {
	global $tikilib;
	$tikilib->query('DROP TABLE IF EXISTS _searchindex');
	$tikilib->query('create table _searchindex (id int(11) not null auto_increment, idObj int(11) not null, type varchar(255) not null, word varchar(255) not null, weight int(11) not null, primary key (id))');
	$tikilib->query('DROP TABLE IF EXISTS superc');
	$tikilib->query('create table superc (id int(11) not null auto_increment, aString varchar(255), bString varchar(255), primary key (id))');
	$tikilib->query('DROP TABLE IF EXISTS child');
	$tikilib->query('create table child (id int(11) not null, someText varchar(255), primary key (id))');
}

function clearDatabase() {
	global $tikilib;
	$tikilib->query('DROP TABLE IF EXISTS _searchindex');
	$tikilib->query('DROP TABLE IF EXISTS superc');
	$tikilib->query('DROP TABLE IF EXISTS child');
}

class SuperC extends PersistentObject {
	var $aString;
	var $bString;
	function setup() {
		$this->aString = new StringField("aString", "Title aString", array('weight' => 10));
		$this->bString = new StringField("bString", "bString", array('weight' => 5));
		parent::setup();
	}
}

class Child extends SuperC {
	var $someText;	
	function setup() {
		$this->someText = new StringField("someText", "someTitle", array('weight' => 2));
		parent::setup();
	}

}

// Tests for ObjectSearch
class ObjectSearchTest extends PHPUnit2_Framework_TestCase {
    public static function main() {
        require_once "PHPUnit2/TextUI/TestRunner.php";

        $suite  = new PHPUnit2_Framework_TestSuite("ObjectSearchTest");
        $result = PHPUnit2_TextUI_TestRunner::run($suite);
    }

    protected function setUp() {
        prepareDatabase();
    	$this->child = new Child(array('aString' => 'string super string', 'bString' => 'super stringfield super', 'someText' => 'child string super'));
        $this->search = new ObjectSearch();
    }

    protected function tearDown() {
	    $this->child = NULL;
	    clearDatabase();
    }

    public function testFindObjects_ShouldReturnObjects() {
	    $objs = $this->search->findObjects("super");
	    $this->assertEquals((float)$this->child->id, (float)$objs[0]->id);
    }

    public function testFindObjects_ShouldReturnOrderedObjects() {
	    $child2 = new Child(array('aString' => 'super string super', 'bString' => 'super string super', 'someText' => 'child string super'));
	    $objs = $this->search->findObjects("super");
	    try {
		    $this->assertEquals((float)$this->child->id, (float)$objs[0]->id);
		    $this->assertEquals((float)$child2->id, (float)$objs[1]->id);
	    } catch (Exception $e) {
		    return;
	    }
	    $this->fail("findObjs must return an ordered array of objects");
    }

    public function testFindObjects_TwoWordsShouldReturnOrderedObjectsBySumOfWeight() {
	    $child2 = new Child(array('aString' => 'super string super', 'bString' => 'super string super', 'someText' => 'child string super'));
	    $objs = $this->search->findObjects("super string");
	    $this->assertEquals((float)$child2->id, (float)$objs[0]->id);
	    $this->assertEquals((float)$this->child->id, (float)$objs[1]->id);
    }

    public function testFindWords_ShouldReturnArrayOfMatchedWords() {
	    $child2 = new Child(array('aString' => 'super string super', 'bString' => 'super string super', 'someText' => 'child string super'));
	    $words = $this->search->findWords("sup");
	    $this->assertEquals("super", $words[0]);
    }


}

// Call ObjectSearchTest::main() if this source file is executed directly.
if (PHPUnit2_MAIN_METHOD == "ObjectSearchTest::main") {
    ObjectSearchTest::main();
}
?>
