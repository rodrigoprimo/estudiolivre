<?php

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

class ElTagLib extends FreetagLib {

    function _parse_tag($tag_string) {
	if(get_magic_quotes_gpc()) {
	    $query = stripslashes(trim($tag_string));
	} else {
	    $query = trim($tag_string);
	}

	$words = preg_split('/\s*,\s*/', $query,-1,PREG_SPLIT_NO_EMPTY|PREG_SPLIT_DELIM_CAPTURE);
	$delim = 0;
	$newwords = array();
	foreach ($words as $key => $word) {
	    $newwords[] = preg_replace('/\s+/',' ',$word);
	}

	return $newwords;
    }

}

global $dbTiki;
$freetaglib = new FreetagLib($dbTiki);

?>