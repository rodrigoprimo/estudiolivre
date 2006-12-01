<?php
/*
 * Created on 01/12/2006
 *
 * by: nano
 * 
 * this class stores information for a file in the disk
 * 
 */

require_once "lib/pesistentObj/PersistentObject.php";

class FileReference extends PersistentObject {
	
	var $fileName;
	var $mimeType;
	var $size;
	var $downloads;
	var $streams;
	var $baseDir = 'repo/';
	
	function FileReference($file) {
		
		global $user;
		
		if (is_int($file)) {
			return parent::PersistentObject($file);
		}
		$fields = array('mimeType' => $file['type'],
						'size' => $file['size']);
		parent::PersistentObject($fields);
		$fileName = $this->id . '-' . $file['name'];
		$this->update(array('fileName' => $fileName));
		$path = $this->baseDir .$fileName;
		if (!move_uploaded_file($file['tmp_name'], $path)) {
			// should never happen, unless the file directory (baseDir) doesn't exist
			$this->delete();
			trigger_error("Impossible to move file to $path.", E_USER_ERROR);
		}

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
	
}

?>
