<?php
/*
 * Created on 31/05/2006
 *
 * by nano: thenano@gmail.com
 */
 
global $el_p_vote, $arquivoId;
 
$ajaxlib->setPermission('vota', $el_p_vote && $arquivoId);
$ajaxlib->registerFunction("vota");
function vota($nota) {
    global $user, $elgallib, $arquivoId;
    
    if (!$user) {
    	return false;
    }
    
    $rating = round($elgallib->vote_arquivo($arquivoId, $user, $nota));

    $objResponse = new xajaxResponse();
    $objResponse->addAssign('ajax-aRatingImg', 'src', 'styles/estudiolivre/star'.$rating.'.png');
    return $objResponse;
} 

$ajaxlib->setPermission('editTags', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction("editTags");
function editTags($tag_string) {
	
	global $smarty, $arquivoId, $elgallib, $freetaglib;

	$elgallib->tag_arquivo($arquivoId, $tag_string);
	
	$objResponse = new xajaxResponse();
	
	$tags = $freetaglib->get_tags_on_object($arquivoId, 'gallery');
	$tagString = '';
	foreach ($tags['data'] as $t) {
	    if ($tagString) $tagString .= ', ';
	    $tagString .= $t['tag'];
	}	
	$smarty->assign("fileTags", $tags);
	
	$objResponse->addAssign("show-tags", "innerHTML", $smarty->fetch("el-gallery_tags.tpl"));
    $objResponse->addAssign("input-tags", "value", $tagString);
    $objResponse->addScript("document.getElementById('input-tags').style.display = 'none'; document.getElementById('show-tags').style.display = 'block'");
    
    return $objResponse;
    
}

?>
