<?php
/*
 * Created on 04/12/2006
 *
 * by: nano
 * 
 * abstract superclass for the publications in the gallery
 * implements the intersection of methods and properties of
 * the publications in estudiolivre
 * 
 */

require_once "lib/persistentObj/PersistentObject.php";

class Publication extends PersistentObject {
	
	var $user;
	var $publishDate;
	var $author;
	var $title;
	var $description;
	var $thumbnail;
	var $copyrightOwner;
	var $producer;
	var $contact;
	var $site;
	var $rating;

	/************************************************************/
	/* this is configuration for the relations with publication */
	var $belongsTo = array("License", "Collection");
	var $licenseId;
	var $collectionId;
	var $hasMany = array("Publication" => "FileReference", "Publication" => "Vote", "Publication" => "Comment");
	
	function subclasses() {
		return array("AudioPublication", "VideoPublication", "ImagePublication", "TextPublication");
	}
	/************************************************************/

	function checkRequiredField($value, $msg) {
		if (preg_match('/^\s*$/',$value)) {
			trigger_error($msg, E_USER_ERROR);
		}
	}

	function checkField_title($value) {
		return $this->checkRequiredField($value, tra('O título é obrigatório'));
	}
	function checkField_author($value) {
		return $this->checkRequiredField($value, tra('O autor é obrigatório'));
	}
	function checkField_description($value) {
		return $this->checkRequiredField($value, tra('A descrição é obrigatória'));
	}
	
	function checkPublish() {
		$this->checkField_author($this->author);
		$this->checkField_title($this->author);
		$this->checkField_description($this->author);
		if (!is_array($this->filereferences)) {
			trigger_error(tra('Você não terminou de enviar o arquivo'), E_USER_ERROR);
		}
		return true;
	}
	
	function publish() {
		return $this->update(array('publishDate' => time()));
	}
	
}

?>
