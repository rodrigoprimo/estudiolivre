<?php

global $user;

$ajaxlib->setPermission('get_more_tags', $user);
$ajaxlib->registerFunction('get_more_tags');
function get_more_tags($offset, $maxRecords) {

    global $freetaglib, $smarty;
    
    $objResponse = new xajaxResponse();

    $smarty->assign('tag_suggestion', $freetaglib->get_tag_suggestion('', $offset, $maxRecords));
    $objResponse->addAppend("gUpTagListItem", "innerHTML", $smarty->fetch("el-tag_suggest_list.tpl"));
    
    if(($offset + $maxRecords) < $freetaglib->count_tags()) {
    	$smarty->assign('moreTagsOffset', $offset + $maxRecords);
    	$objResponse->addAssign("gUpTagSuggestMore", "innerHTML", $smarty->fetch("el-tag_suggest_more.tpl"));
    } else {
    	$objResponse->addAssign("gUpTagSuggestMore", "style.display", "none");
    }
    
    return $objResponse;			
}

?>
