<?php
/*
 * Created on 31/05/2006
 *
 * by nano
 */
 
$ajaxlib->registerFunction("vota");
function vota($arquivoId, $nota) {
    global $user, $elgallib;
    $rating = round($elgallib->vote_arquivo($arquivoId, $user, $nota));

    $objResponse = new xajaxResponse();
    $objResponse->addAssign('aRatingImg', 'src', 'styles/estudiolivre/star'.$rating.'.png');
    return $objResponse;
} 
 
?>
