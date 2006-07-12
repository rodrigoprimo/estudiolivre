<?php

global $user;

$ajaxlib->setPermission('get_more_tags', $user);
$ajaxlib->registerFunction('get_more_tags');
function get_more_tags($offset, $maxRecords) {

    global $freetaglib, $smarty;
    
    $objResponse = new xajaxResponse();

	$last_tag = array_pop($freetaglib->get_distinct_tag_suggestion('', $offset-$maxRecords, $maxRecords));
	
    $smarty->assign('tag_suggestion', $freetaglib->get_distinct_tag_suggestion('', $offset, $maxRecords));
    $objResponse->addScript("document.getElementById('$last_tag-v').style.display='inline'");
    $objResponse->addAppend("gUpTagListItem", "innerHTML", $smarty->fetch("el-tag_suggest_list.tpl"));
    
    if(($offset + $maxRecords) < $freetaglib->count_distinct_tags()) {
    	$smarty->assign('moreTagsOffset', $offset + $maxRecords);
    	$objResponse->addAssign("gUpTagSuggestMore", "innerHTML", $smarty->fetch("el-tag_suggest_more.tpl"));
    } else {
    	$objResponse->addAssign("gUpTagSuggestMore", "style.display", "none");
    }
    
    return $objResponse;			
}

?>
