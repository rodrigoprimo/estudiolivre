<?php

global $el_p_view;

$ajaxlib->setPermission('streamFile', $el_p_view == 'y');
$ajaxlib->registerFunction("streamFile");
function streamFile($arquivoId, $type, $screenSize) {
	global $elgallib, $smarty;
	require_once("lib/elgal/elgallib.php");

    $objResponse = new xajaxResponse();
    
    if (!$arquivoId) {
    	return $objResponse;
    }
    
    $elgallib->add_stream_hit($arquivoId);
    $arquivo = $elgallib->get_arquivo($arquivoId);
    
    $screenSize-=250;
    if ($type == 'Imagem') {
    	$smarty->assign('src', 'repo/' . $arquivo['arquivo']);
    	if($arquivo['tamanhoImagemX'] > $screenSize){
    		$arquivo['tamanhoImagemY'] = $screenSize*($arquivo['tamanhoImagemY']/$arquivo['tamanhoImagemX']);
    		$arquivo['tamanhoImagemX'] = $screenSize;
    		$smarty->assign('note', tra("Imagem redimensionada"));
    	} else {
    		$smarty->assign('note', '');
    	}
    	$objResponse->addRemove('gPlayerImagem');
    	$objResponse->addAppend('contentBubble', 'innerHTML', $smarty->fetch('el-playerImage.tpl'));
    	$objResponse->addAssign('gImagem', 'style.maxWidth', $screenSize . "px");
    	$objResponse->addAssign('gPlayerImagem', 'style.width', $arquivo['tamanhoImagemX'] . "px");
    	$objResponse->addAssign('gPlayerImagem', 'style.height', $arquivo['tamanhoImagemY'] . "px");
    	$objResponse->addScript("showLightbox('gPlayerImagem')");
    	
    	return $objResponse;
    }
    
    $validUrl = 'http://' . $_SERVER['HTTP_HOST'] .  $_SERVER['REQUEST_URI'];
    $validUrl = preg_replace('/\/el-.+\.php.*$/','',$validUrl);
    $validUrl .= '/repo/' . $arquivo['arquivo'];
   	
    if ($type == 'Video') {
    	$width = $arquivo['tamanhoImagemX'];
    	$height = $arquivo['tamanhoImagemY'];
    	$video = "true";
    } else {
    	$width = 200;
    	$height = 20;
    	$video = "false";
    }
        
    /*pra quando rolar tutoriais em swf
     * if (preg_match('/.*\.swf$/i', $arquivo.arquivo)) {
    	$smarty->assign('src', 'repo/' . $arquivo['arquivo']);
    	$objResponse->addRemove('gPlayerSwf');
    	$objResponse->addAppend('contentBubble', 'innerHTML', $smarty->fetch('el-playerSwf.tpl'));
    	$objResponse->addScript("showLightbox('gPlayerSwf')");	
    } else {
    */
    	$objResponse->addRemove('gPlayer');
   		$objResponse->addAppend('contentBubble', 'innerHTML', $smarty->fetch('el-player.tpl'));
    	$objResponse->addScript("loadFile('$validUrl', $width, $height, '$video')");
    //}
    
    return $objResponse;
    
}

?>
