<?php
// Call FieldTest::main() if this source file is executed directly.
if (!defined("PHPUnit2_MAIN_METHOD")) {
    define("PHPUnit2_MAIN_METHOD", "FieldTest::main");
}

include_once ('setup/tests-setup.php');

require_once "PHPUnit2/Framework/TestCase.php";
require_once "PHPUnit2/Framework/TestSuite.php";

require_once "lib/field/Field.php";

// Test class for Field.
class FieldTest extends PHPUnit2_Framework_TestCase {
    public static function main() {
        require_once "PHPUnit2/TextUI/TestRunner.php";

        $suite  = new PHPUnit2_Framework_TestSuite("FieldTest");
        $result = PHPUnit2_TextUI_TestRunner::run($suite);
    }

    // this method is called before *every* test (methods that starts with tests*)
    protected function setUp() {
        $this->field = new Field('field', 'TestField', array('weight' => 5));
	$this->field->setValue("This test checks if the Field class is ok");
    }

    // this method is called after *every* test (methods that starts with test*)
    protected function tearDown() {
        $this->field = NULL;
    }

    public function testSetValue() {
        $this->field->setValue('test');
	$this->assertEquals('test', $this->field->value);
    }

    public function testGetTitle() {
        $this->assertEquals('TestField', $this->field->getTitle());
    }

    public function testIsSuggestedFilter() {
        $this->assertFalse($this->field->isSuggestedFilter());
    }

    public function testIsSuggestedFilterTrue() {
        $field = new Field('field', 'TestField', array('suggestedFilter' => true));
        $this->assertTrue($field->isSuggestedFilter());
    }

    public function testGetWords() {
        $words = $this->field->getWords();
	$this->assertEquals(array("This", "test", "checks", "if", "the", "Field", "class", "is", "ok"), $words);
    }

}

// Call FieldTest::main() if this source file is executed directly.
if (PHPUnit2_MAIN_METHOD == "FieldTest::main") {
    FieldTest::main();
}
?>
