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
	var $baseDir = 'repo/';
	
	/************************************************************/
	/* this is configuration for the relations with publication */
	var $belongsTo = array("Publication");
	
	function subclasses() {
		return array("AudioFile", "VideoFile", "ImageFile", "TextFile");
	}
	/************************************************************/
	
	function FileReference($fileRef, $referenced = false) {
		
		global $user;
		
		if (is_int($fileRef)) {
			return parent::PersistentObject($fileRef, $referenced);
		}
		$fields = array('mimeType' => $fileRef['type'],
						'size' => $fileRef['size'],
						'publicationId' => $fileRef['publicationId']);
		parent::PersistentObject($fields, $referenced);
		$fileName = $this->id . '-' . $fileRef['name'];
		$this->update(array('fileName' => $fileName));
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
		unlink($this->baseDir . $this->fileName);
	}
	
	function parseFileName() {
		preg_match("/\d+-(.+)\..+$/", $this->fileName, $match);
  		return $match[1];
	}
	
	function parseDownloadName() {
		preg_match("/\d+-(.+)$/", $this->fileName, $match);
		return $match[1];
	}
	
	function extractFileInfo() {
		trigger_error("Subclass should have implemented", E_USER_ERROR);
	}
	
	function generateThumb() {
		trigger_error("Subclass should have implemented", E_USER_ERROR);
	}
	
	// this is a static method that must be implemented by subclasses
	function validateExtension($filename) {
		trigger_error("Subclass should have implemented", E_USER_ERROR);
	}
	
	function checkNumericField($value, $msg) {
		if (!preg_match('/^\d*$/', $value)) {
  			return $msg;
		}
	}
	
}

?>
