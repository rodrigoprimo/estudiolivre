<?php

global $el_p_view;

$ajaxlib->setPermission('streamFile', $el_p_view == 'y');
$ajaxlib->registerFunction("streamFile");
function streamFile($arquivoId, $type) {
	global $elgallib;

    $objResponse = new xajaxResponse();
    
    if (!$arquivoId) {
    	return $objResponse;
    }
    
    $elgallib->add_stream_hit($arquivoId);
    $arquivo = $elgallib->get_arquivo($arquivoId);
    
    
    if ($type == 'Imagem') {
    	$objResponse->addAssign('gImagem', 'src', 'repo/' . $arquivo['arquivo']);
    	$objResponse->addScript("document.getElementById('gPlayerImagem').style.width = '" . $arquivo['tamanhoImagemX'] . "px';");
    	$objResponse->addScript("document.getElementById('gPlayerImagem').style.height = '" . $arquivo['tamanhoImagemY'] . "px';");
    	$objResponse->addScript("showLightbox('gPlayerImagem')");
    	
    	return $objResponse;
    }
    
    $playerName = 'player' . $type;
    $validUrl = 'http://' . $_SERVER['HTTP_HOST'] .  $_SERVER['REQUEST_URI'];
    $validUrl = preg_replace('/\/el-.+\.php.*$/','',$validUrl);
    $validUrl .= '/repo/' . $arquivo['arquivo'];
   	
    if ($type == 'Video') {
    	$width = $arquivo['tamanhoImagemX'];
    	$height = $arquivo['tamanhoImagemY'];
    } else {
    	$width = 200;
    	$height = 50;
    }
        
    $objResponse->addScript("loadFile($playerName, '$validUrl', $width, $height, '$type')");
    
    return $objResponse;
    
}

?>
