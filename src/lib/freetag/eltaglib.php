<?php

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

class ElTagLib extends FreetagLib {

    var $_normalized_valid_chars = 'a-zA-Z0-9çáéíóúÇÁÉÍÓÚâêôÂÊÔãõÃÕ ';

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
		$word = preg_replace('/\s+/',' ',$word);
		$word = preg_replace('/^\s|\s$/','',$word);
	    $newwords[] = $word;
	}

	return $newwords;
    }

	function get_distinct_tag_suggestion($exclude = '', $offset = 0, $maxRecords = -1) {
	
		$query = "select distinct(t.tagId), t.tag from `tiki_freetags` t, `tiki_freetagged_objects` o, `tiki_objects` tko where t.`tagId`=o.`tagId` and o.`objectId`=tko.`objectId` order by hits";
		$result = $this->query($query, array(), $maxRecords, $offset);
	
		$tags = array();
		$index = array();
		while ($row = $result->fetchRow()) {
		    $tag = $row['tag'];
		    if (!isset($index[$tag]) && !preg_match("/$tag/",$exclude)) {
				$tags[] = $tag;
				$index[$tag] = 1;
		    }
		}
	
		return $tags;
	}
	
	function count_distinct_tags($user = '') {
	    
		$bindvals = array();
	
		if (isset($user) && (!empty($user))) {
		    $mid = "AND `user` = ?"; 
		    $bindvals[] = $user;
		} else {
		    $mid = "";
		}
		    
		$query = "select count(distinct(t.`tagId`)) from `tiki_freetags` t, `tiki_freetagged_objects` o where o.`tagId` = t.`tagId`	$mid";
	
		return $this->getOne($query, $bindvals);

    }
    
    //TODO: move to objectlib
    function delete_object($type, $itemId) {
    	$objId = $this->getOne("select `objectId` from `tiki_objects` where `type`=? and `itemId`=?", array($type, $itemId));
    	if (!$objId) {
    		return false;
    	}
    	
    	$bindvals = array($objId);
    	$this->query("delete from `tiki_objects` where `objectId`=?", $bindvals);
    	$this->query("delete from `tiki_categorized_objects` where `catObjectId`=?", $bindvals);
    	$this->query("delete from `tiki_category_objects` where `catObjectId`=?", $bindvals);
    	$this->query("delete from `tiki_freetagged_objects` where `objectId`=?", $bindvals);
    	
    	return true;
    
    }

}

global $dbTiki;
$freetaglib = new FreetagLib($dbTiki);

?>
