<?php

global $user;

$ajaxlib->setPermission('get_more_tags', $user);
$ajaxlib->register(XAJAX_FUNCTION, 'get_more_tags');
function get_more_tags($offset, $maxRecords) {

    global $freetaglib, $smarty;
    
    $objResponse = new xajaxResponse();

	$last_tag = array_pop($freetaglib->get_distinct_tag_suggestion('', $offset-$maxRecords, $maxRecords));
	
    $smarty->assign('tag_suggestion', $freetaglib->get_distinct_tag_suggestion('', $offset, $maxRecords));
    $objResponse->script("document.getElementById('$last_tag-v').style.display='inline'");
    $objResponse->append("ajax-gUpTagListItem", "innerHTML", $smarty->fetch("el-tag_suggest_list.tpl"));
    
    if(($offset + $maxRecords) > $freetaglib->count_distinct_tags()) {
    	$objResponse->assign("ajax-gUpTagSuggestMore", "style.display", "none");
    }
    
    return $objResponse;			
}

?>
