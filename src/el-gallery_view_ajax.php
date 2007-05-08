<?php
/*
 * Created on 31/05/2006
 *
 * by nano
 * migrado pra 2.0!
 */
 
global $el_p_vote, $arquivoId;
 
$ajaxlib->setPermission('vota', $el_p_vote && $arquivoId);
$ajaxlib->registerFunction("vota");
function vota($nota) {
    global $user, $arquivo;
    
    if (!$user) {
    	return false;
    }
    
    $arquivo->vote($user, $nota);

    $objResponse = new xajaxResponse();
    $objResponse->addAssign('ajax-aRatingImg', 'src', 'styles/estudiolivre/star'.round($arquivo->rating).'.png');
    $objResponse->addAssign('ajax-aVoteTotal', 'innerHTML', count($arquivo->votes));
    return $objResponse;
} 

$ajaxlib->setPermission('editTags', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction("editTags");
function editTags($tag_string) {
	
	global $smarty, $arquivoId, $freetaglib, $user, $arquivo;

	if (!is_object($freetaglib)) {
		include_once('lib/freetag/freetaglib.php');
    }

	$href = "el-gallery_view.php?arquivoId=$arquivoId";

	$freetaglib->add_object('gallery', $arquivoId, $arquivo->description, $arquivo->title, $href);
	$freetaglib->update_tags($user, $arquivoId, $arquivo->tagType, $tag_string);
	
	$objResponse = new xajaxResponse();
	
	$tags = $freetaglib->get_tags_on_object($arquivoId, $arquivo->tagType);
	$tagString = '';
	foreach ($tags['data'] as $t) {
	    if ($tagString) $tagString .= ', ';
	    $tagString .= $t['tag'];
	}	
	$smarty->assign("fileTags", $tags['data']);
	
	$objResponse->addAssign("show-tags", "innerHTML", $smarty->fetch("el-gallery_tags.tpl"));
    $objResponse->addAssign("input-tags", "value", $tagString);
    $objResponse->addScript("document.getElementById('input-tags').style.display = 'none'; document.getElementById('show-tags').style.display = 'block'");
    
    return $objResponse;
    
}

?>
