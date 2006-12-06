<?php
/*
 * Created on 05/12/2006
 *
 * by: nano
 * 
 * subclass of FileReference, must implement the superclass methods
 * has specific text properties
 * 
 */

require_once "FileReference.php";

class TextFile extends FileReference {
	
	var $encoding;

	function extractFileInfo() {
		return;
	}
	
	function generateThumb() {
		return;
	}
	
	// class method
	function validateExtension($filename) {
		return;
	}
	
}

?>
