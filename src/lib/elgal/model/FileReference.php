<?php
/*
 * Created on 01/12/2006
 *
 * by: nano
 * 
 * this class stores information for a file in the disk
 * 
 */

require_once "lib/persistentObj/PersistentObject.php";

class FileReference extends PersistentObject {
	
	var $publicationId;
	var $fileName;
	var $thumbnail;
	var $mimeType;
	var $size;
	var $downloads;
	var $streams;
	var $baseDir = "repo/";
	
	/************************************************************/
	/* this is configuration for the relations with publication */
	var $belongsTo = array("Publication");
	var $actualClass = true;
	/************************************************************/
	
	function FileReference($fileRef, $referenced = false) {
		
		global $user;
		
		if (is_int($fileRef)) {
			parent::PersistentObject($fileRef, $referenced);
			$this->baseDir .= "$this->publicationId/";
			return $this;
		}
		$fields = array('mimeType' => $fileRef['type'],
						'size' => $fileRef['size'],
						'publicationId' => $fileRef['publicationId']);
		parent::PersistentObject($fields, $referenced);
		$fileName = $fileRef['name'];
		$this->update(array('fileName' => $fileName));
		
		$this->baseDir .= "$this->publicationId/";
		if (!file_exists($this->baseDir)) mkdir($this->baseDir, 0755);
		
		$path = $this->baseDir . $fileName;
		if (!move_uploaded_file($fileRef['tmp_name'], $path)) {
			// should never happen, unless the file directory (baseDir) doesn't exist
			$this->delete();
			trigger_error("Impossible to move file to $path.", E_USER_ERROR);
		}
		$this->extractFileInfo();
		$this->generateThumb();

 	}
	
	function hitDownload() {
		return $this->update(array('downloads' => $this->downloads+1));
	}
	
	function hitStream() {
		return $this->update(array('streams' => $this->streams+1));
	}
	
	function delete() {
		parent::delete();
		unlink($this->fullPath());
		if ($this->thumbnail)
			unlink($this->baseDir . $this->thumbnail);
	}
	
	function parseFileName() {
		preg_match("/(.+)\..+$/", $this->fileName, $match);
  		return $match[1];
	}
	
	function fullPath() {
		return $this->baseDir . $this->fileName;
	}
	
	function extractFileInfo() {
		trigger_error("Subclass should have implemented", E_USER_ERROR);
	}
	
	function autoInfos() {
		trigger_error("Subclass should have implemented", E_USER_ERROR);
	}
	
	function generateThumb() {
		trigger_error("Subclass should have implemented", E_USER_ERROR);
	}
	
	// this is a static method that must be implemented by subclasses
	// use this one only to check for forbidden extensions
	function validateExtension($filename) {
		$extensions = array('php','htm', 'wmv','wma','doc','xls','ppt');
		if (!preg_match('/\.([^.]{3,4}$)/', $filename, $m)) {
	    	return tra("Erro: extensão de arquivo não suportada pelo acervo.");
	  	}
		foreach ($extensions as $ext) {
		  	if(preg_match('/' . $ext . '/', strtolower($m[1]))) {
		    	return tra("Erro: extensão $m[1] não suportada pelo acervo.");
		    }
		}
	}
	
	function checkNumericField($value, $msg) {
		if (!preg_match('/^\d*$/', $value)) {
  			return $msg;
		}
	}
	
}

?>
