<?php

global $el_p_view;

$ajaxlib->registerFunction("get_files");
function get_files($tipos, $offset, $maxRecords, $sort_mode, $userName = '', $find = '', $filters = array()) {
    global $elgallib, $smarty;

    $objResponse = new xajaxResponse();
	$total = $elgallib->count_all_uploads($tipos, $userName, $find);

    $files = $elgallib->list_all_uploads($tipos, $offset, $maxRecords, $sort_mode, $userName, $find, $filters);
    $smarty->assign_by_ref('arquivos',$files);
    $smarty->assign('maxRecords', $maxRecords);
    $smarty->assign('offset', $offset);
	$smarty->assign('sort_mode', $sort_mode);
	$smarty->assign('total', $total);
	$smarty->assign('userName', $userName);
	$smarty->assign('find', $find);
	$smarty->assign('filters', $filters);
	$smarty->assign('page', ($offset/$maxRecords)+1);
	$smarty->assign('lastPage', ceil($total/$maxRecords));

	if ($find) {
		$smarty->load_filter('output','highlight');
		$_REQUEST['highlight'] = $find;
	}
    $objResponse->addAssign("gListCont", "innerHTML", $smarty->fetch("el-gallery_section.tpl"));
    $objResponse->addAssign("listNav", "innerHTML", $smarty->fetch("el-gallery_pagination.tpl"));
    $objResponse->addScript("nd()");
    //$objResponse->addScript("acervoCache('$tiposHr', $offset, $maxRecords, '$sort_mode', '$find', '$filtersHr')");
    
    return $objResponse;
}

$ajaxlib->setPermission('streamFile', $el_p_view);
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
    	$objResponse->addScript("document.getElementById('gPlayerImagem').style.width = " . $arquivo['tamanhoImagemX']);
    	$objResponse->addScript("document.getElementById('gPlayerImagem').style.height = " . $arquivo['tamanhoImagemY']);
    	$objResponse->addScript("showLightbox('gPlayerImagem')");
    	
    	return $objResponse;
    }
    
    $playerName = 'player' . $type;
    $validUrl = 'http://' . $_SERVER['HTTP_HOST'] . '/estudiolivre/repo/' . $arquivo['arquivo'];
    if ($type == 'Video' || $type == 'Imagem') {
    	$width = $arquivo['tamanhoImagemX'];
    	$height = $arquivo['tamanhoImagemY'];
    } else {
    	$width = 200;
    	$height = 50;
    }
        
    $objResponse->addScript("loadFile($playerName, '" . $validUrl . "', $width, $height, '" . $type . "')");
    
    return $objResponse;
    
}

?>
