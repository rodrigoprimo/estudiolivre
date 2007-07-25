<?php
/*
 * Created on 05/12/2006
 *
 * by: nano
 * 
 * subclass of FileReference, must implement the superclass methods
 * has specific zip properties and methods like unpack
 * 
 */

require_once "FileReference.php";

class ZipFile extends FileReference {
	
	var $commandLine;
	var $type = "Zip";

	function ZipFile($fileRef, $referenced = false) {
				
		if (is_int($fileRef)) {
			return parent::FileReference($fileRef, $referenced);
		}
		
		parent::FileReference($fileRef, $referenced);
				
		preg_match('/\.([^.]{2,4}$)/', $fileRef['name'], $m);
		$ext = strtolower($m[1]);
		if ($ext == "zip")
			$commandLine = "unzip ";
		elseif ($ext == "rar")
			$commandLine = "unrar-free ";
		elseif ($ext == "tar")
			$commandLine = "tar vxf ";
		elseif ($ext == "tgz")
			$commandLine = "tar vxzf ";
		elseif ($ext == "tbz2")
			$commandLine = "tar vxjf ";
		elseif ($ext == "gz") {
			if (preg_match('\.tar\.gz$', $fileRef['name']))
				$commandLine = "tar vxzf ";
			else
				$commandLine = "gunzip ";
		}
		elseif ($ext == "bz2") {
			if (preg_match('\.tar\.bz2$', $fileRef['name']))
				$commandLine = "tar vxjf ";
			else
				$commandLine = "bunzip2 ";
		}
		$this->update(array("commandLine" => $commandLine));
		return $this;
		
	}

	function expand() {
		$pwd = getcwd();
		chdir($this->baseDir);
		exec(escapeshellcmd($this->commandLine . $this->fileName), $out, $ret_error);
		//print_r($out); exit;
		chdir($pwd);
		if (!$ret_error) {
			foreach ($out as $key => $fileName) {
				if (is_file($this->baseDir . $fileName)) {
					if (function_exists('mime_content_type')) $type = mime_content_type($fileName);
					else $type = '';
					$fields = array('type' => $type,
									'size' => filesize($this->fullPath()),
									'publicationId' => $this->publicationId,
									'name' => $fileName,
									'tmp_name' => $fileName);
					$fileClass = FileReference::getSubClass($fileName);
					require_once($fileClass . ".php");
					$file = new $fileClass($fields);
				} else {
					unset($out[$key]);
				}
			}
		}
		$this->publication->update(array('allFile' => $this->fullPath()));
		$this->delete(false);
		return $out;
	}

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
		$extensions = array('zip','gz','bz2','tgz','tar','tbz2','rar');
		if (!preg_match('/\.([^.]{2,4}$)/', $filename, $m)) {
	    	return 1;
	  	}
	  	if (!in_array(strtolower($m[1]), $extensions)) {
	    	return 1;
	    }
	}
	
}

?>
