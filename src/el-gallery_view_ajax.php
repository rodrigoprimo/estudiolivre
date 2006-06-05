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
    $objResponse->addAssign('aRatingImg', 'src', 'styles/estudiolivre/star'.$rating.'.png');
    return $objResponse;
} 
 
?>
