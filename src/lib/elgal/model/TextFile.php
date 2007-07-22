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
	var $type = "Texto";

	function extractFileInfo() {
		return;
	}
	
	function autoInfos() {
		return array();
	}
	
	function generateThumb() {
		return;
	}
	
	// class method
	function validateExtension($filename) {
		$extensions = array('pdf','txt','tex','rtf','dvi','odt','ps','kwd','abi','sxw');
		if (!preg_match('/\.([^.]{3,4}$)/', $filename, $m)) {
	    	return tra("Erro: extensão de arquivo inválida.");
	  	}
	  	if (!in_array(strtolower($m[1]), $extensions)) {
	    	return tra("Erro: extensão $m[1] não suportada para video.");
	    }
	}
	
}

?>
