<?php
/*
 * Created on 05/12/2006
 *
 * by: nano
 * 
 * subclass of FileReference, must implement the superclass methods
 * has specific video properties
 * 
 */

require_once "FileReference.php";

class VideoFile extends FileReference {
	
	var $duration;
	var $width;
	var $height;
	var $hasAudio;
	var $hasColor;
	var $type = "Video";

	function extractFileInfo() {
		if (!class_exists('ffmpeg_movie')) {
			return;
		}
		$movie = new ffmpeg_movie($this->baseDir . $this->fileName, 0);
		if (!is_object($movie)) {
			return;
		}
		  
		$result = array();
		$result['width'] = (int)$movie->getFrameWidth();
		$result['height'] = (int)$movie->getFrameHeight();
		$result['duration'] = (int)$movie->getDuration();
		$result['hasAudio'] = (int)$movie->hasAudio();
		
		return $this->update($result);
	}
	
	function autoInfos() {
		$result = array();
		$result['width'] = $this->width;
		$result['height'] = $this->height;
		$result['duration'] = $this->duration;
		$result['hasAudio'] = $this->hasAudio;
		return $result;
	}
	
	function generateThumb() {
		
		global $tikilib;
		
		if (!class_exists('ffmpeg_movie')) {
			return;
		}
		$movie = new ffmpeg_movie($this->baseDir . $this->fileName, 0);
		if (!is_object($movie)) {
			return;
		}
		
		$width = $movie->getFrameWidth();
		$height = $movie->getFrameHeight();
		$frameTotal = $movie->getFrameCount();
		
		$thumbSide = $tikilib->get_preference('el_thumb_side', 100);
		$thumbVideoSize = $tikilib->get_preference('el_thumb_video_size', 10);
		
		$rate = (int)($frameTotal/$thumbVideoSize);
		$percent = ($width>$height) ? $thumbSide/$width : $thumbSide/$height;
		$width = (int)($percent*$width);
		$height = (int)($percent*$height);
		if($width%2 != 0) $width++;
		if($height%2 != 0) $height++;
		
		$thumbName = 'thumb_' . $this->fileName;
		$thumbName = preg_replace('/\.(.+?)$/', 'gif', $thumbName);
		$gif = new ffmpeg_animated_gif($this->baseDir . $thumbName, $width, $height, 1, 0);
		
		for ($i=1; $i <= $frameTotal; $i+=$rate) {
			$gif->addFrame($movie->getFrame($i));
		}
		
		return $this->update(array('thumbnail' => $thumbName));
		
	}
	
	// class method
	function validateExtension($filename) {
		$extensions = array('mpg','mpeg','avi','ogg','theora','mp4','yuv','mp2','mkv','mxf','mov','swf','flv','3gp','3gpp');
		if (!preg_match('/\.([^.]{3,4}$)/', $filename, $m)) {
	    	return 1;
	  	}
	  	if (!in_array(strtolower($m[1]), $extensions)) {
	    	return 1;
	    }
	}
	
	function checkField_duration($value) {
		return $this->checkNumericField($value, tra('Duração deve ser um número'));
	}
	function checkField_width($value) {
		return $this->checkNumericField($value, tra('Largura deve ser um número'));
	}
	function checkField_height($value) {
		return $this->checkNumericField($value, tra('Altura deve ser um número'));
	}
	
}

?>
