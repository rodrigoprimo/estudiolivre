<?php
/*
 * Created on 31/05/2006
 *
 * by nano
 * migrado pra 2.0!
 */
 
global $tiki_p_el_vote, $arquivoId;
 
$ajaxlib->setPermission('vota', $tiki_p_el_vote && $arquivoId);
$ajaxlib->register(XAJAX_FUNCTION, "vota");
function vota($nota) {
    global $user, $arquivo;
    
    if (!$user) {
    	return false;
    }
    
    $arquivo->vote($user, $nota);

    $objResponse = new xajaxResponse();
    $objResponse->assign('ajax-aRatingImg', 'src', 'styles/estudiolivre/star'.round($arquivo->rating).'.png');
    $objResponse->assign('ajax-aVoteTotal', 'innerHTML', count($arquivo->votes));
    return $objResponse;
} 

$ajaxlib->setPermission('comment', $user && $arquivoId);
$ajaxlib->register(XAJAX_FUNCTION, "comment");
function comment($comment) {
	global $arquivoId, $arquivo, $user, $smarty;
	
	require_once("Comment.php");
	$c = new Comment(array('publicationId' => $arquivoId, 'user' => $user, 'date' => time(), 'comment' => $comment));
	
	$smarty->assign('user', $user);
	$smarty->assign('comment', $c);
	
	$objResponse = new xajaxResponse();
	$objResponse->append("ajax-aCommentsItemsCont", "innerHTML", $smarty->fetch("el-publication_comment.tpl"));
	$objResponse->assign("ajax-commentCount", "innerHTML", count($arquivo->comments) + 1);
	
	return $objResponse;
	
}

$ajaxlib->setPermission('deleteComment', $user && $arquivoId);
$ajaxlib->register(XAJAX_FUNCTION, "deleteComment");
function deleteComment($commentId) {
	global $arquivo, $user, $smarty;
	
	foreach ($arquivo->comments as $comment) {
		if ($comment->id == $commentId) {
			$c =& $comment;
			break;
		}
	}
	
	$objResponse = new xajaxResponse();
	if (!$c || ($c->user != $user)) {
		return $objResponse;
	}

	$objResponse->remove("ajax-commentCont-$c->id");
	$c->delete();
	
	$objResponse->assign("ajax-commentCount", "innerHTML", count($arquivo->comments) - 1);
	
	return $objResponse;
	
}

?>
