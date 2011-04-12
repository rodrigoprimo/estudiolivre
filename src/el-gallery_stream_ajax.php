<?php
// migrado pra 2.0!
global $tiki_p_el_view;

$ajaxlib->setPermission('streamFile', $tiki_p_el_view == 'y');
$ajaxlib->register(XAJAX_FUNCTION, "streamFile");
function streamFile($arquivoId, $type, $screenSize) {
	global $smarty;
	require_once("lib/persistentObj/PersistentObjectFactory.php");

    $objResponse = new xajaxResponse();
    
    if (!$arquivoId) {
    	return $objResponse;
    }
    
    $arquivo = PersistentObjectFactory::createObject("Publication", (int)$arquivoId);
    $file =& $arquivo->filereferences[0];
    $file->hitStream();
    
    $screenSize-=250;
    if ($type == 'Imagem') {
    	$smarty->assign('src', $file->baseDir . $file->fileName);
    	if($file->width > $screenSize){
    		$file->height = $screenSize*($file->height/$file->width);
    		$file->width = $screenSize;
    		$smarty->assign('note', tra("Imagem redimensionada"));
    	} else {
    		$smarty->assign('note', '');
    	}
    	$objResponse->remove('ajax-gPlayerImagem');
    	$objResponse->append('ajax-contentBubble', 'innerHTML', $smarty->fetch('el-playerImage.tpl'));
    	$objResponse->assign('ajax-gImagem', 'style.maxWidth', $screenSize . "px");
    	$objResponse->assign('ajax-gPlayerImagem', 'style.width', $file->width . "px");
    	$objResponse->assign('ajax-gPlayerImagem', 'style.height', $file->height . "px");
    	$objResponse->script("showLightbox('ajax-gPlayerImagem')");
    	
    	return $objResponse;
    }
    
    $validUrl = 'http://' . $_SERVER['HTTP_HOST'] .  $_SERVER['REQUEST_URI'];
    $validUrl = preg_replace('/el-.+\.php.*$/','',$validUrl);
    $validUrl .= $file->baseDir . $file->fileName;
   	
    if ($type == 'Video') {
    	$width = $file->width;
    	$height = $file->height;
    	$video = "true";
    } else {
    	$width = 200;
    	$height = 20;
    	$video = "false";
    }
        
    /*pra quando rolar tutoriais em swf
     * if (preg_match('/.*\.swf$/i', $arquivo.arquivo)) {
    	$smarty->assign('src', 'repo/' . $arquivo['arquivo']);
    	$objResponse->remove('gPlayerSwf');
    	$objResponse->append('ajax-contentBubble', 'innerHTML', $smarty->fetch('el-playerSwf.tpl'));
    	$objResponse->script("showLightbox('gPlayerSwf')");	
    } else {
    */
    	$objResponse->remove('ajax-gPlayer');
   		$objResponse->append('ajax-contentBubble', 'innerHTML', $smarty->fetch('el-player.tpl'));
    	$objResponse->script("loadFile('$validUrl', $width, $height, '$video')");
    //}
    
    return $objResponse;
    
}

$ajaxlib->setPermission('streamStream', $tiki_p_el_view == 'y');
$ajaxlib->register(XAJAX_FUNCTION, "streamStream");
function streamStream($url, $size) {
	
	global $smarty;
	$objResponse = new xajaxResponse();
	
	preg_match('/(\d+)\sx\s(\d+)/', $size, $matches);
	$width = (int)$matches[1];
	$height = (int)$matches[1];
	
	$objResponse->remove('ajax-gPlayer');
   	$objResponse->append('ajax-contentBubble', 'innerHTML', $smarty->fetch('el-player.tpl'));
    $objResponse->script("loadFile('$url', $width, $height, 'true')");
    
    return $objResponse;  
}

?>
