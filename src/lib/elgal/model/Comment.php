<?php
/*
 * Created on 11/12/2006
 *
 * by nano: Class that stores comments for publications and filereferences
 * 
 */

require_once "lib/persistentObj/PersistentObject.php";

class Comment extends PersistentObjetc {
	
	var $user;
	var $comment;
	var $date;
	
	var $belongsTo = array("Publication", "FileReference");
	var $publicationId;
	var $filereferenceId;
	
	function Comment($fields, $referenced = false) {
		parent::PersistentObject($fields, $referenced);
		if (!$this->date) {
			$this->update(array("date" => time()));
		}
	}
	
}

?>
