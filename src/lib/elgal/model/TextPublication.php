<?php
/*
 * Created on 04/12/2006
 *
 * by: nano
 * 
 * specific publication of the type text
 * this does not mean that it only has text files
 * but that in essence it's an text manifestation
 * 
 */

require_once "Publication.php";

class TextPublication extends Publication {
	
	var $type = "Texto";
	var $typeOfText;
	var $language;
	var $pages;
	
}

?>
