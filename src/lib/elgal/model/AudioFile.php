<?php
/*
 * Created on 05/12/2006
 *
 * by: nano
 * 
 * subclass of FileReference, must implement the superclass methods
 * has specific audio properties
 * 
 */

require_once "FileReference.php";

class AudioFile extends FileReference {
	
	var $duration;
	var $bpm;
	var $sampleRate;
	var $bitRate;

	function extractFileInfo() {
		if (!class_exists('ffmpeg_movie')) {
			return;
		}

		$audio = new ffmpeg_movie($this->baseDir . $this->fileName, 0);
		if (!is_object($audio)) {
			return;
		}
		  
		$result = array();
		$result['duration'] = (int)$audio->getDuration();
		$result['bitRate'] = (int)$audio->getBitRate();
		
		return $this->update($result);
	}
	
	function generateThumb() {
		return true;
	}
	
	// class method
	function validateExtension($filename) {
		$extensions = array('mp3','ogg','wav','aiff','avi','flac','mp2','mid','mxf');
		if (!preg_match('/\.([^.]{3,4}$)/', $filename, $m)) {
	    	trigger_error(tra("Erro: extensão de arquivo inválida."), E_USER_ERROR);
	  	}
	  	if (!in_array(strtolower($m[1]), $extensions)) {
	    	trigger_error(tra("Erro: extensão $m[1] não suportada para audio."), E_USER_ERROR);
	    }
	}
	
	function checkField_duration($value) {
		return $this->checkNumericField($value, tra('Duração deve ser um número'));
	}
	function checkField_bpm($value) {
		return $this->checkNumericField($value, tra('BPM deve ser um número'));
	}
	function checkField_sampleRate($value) {
		return $this->checkNumericField($value, tra('"Sample rate" deve ser um número'));
	}
	function checkField_bitRate($value) {
		return $this->checkNumericField($value, tra('"Bit rate" deve ser um número'));
	}
	
}

?>