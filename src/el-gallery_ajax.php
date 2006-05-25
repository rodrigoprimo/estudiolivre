<?php

require_once("lib/xajax/xajax.inc.php");

$xajax = new xajax();

$xajax->statusMessagesOff();
$xajax->waitCursorOn();
$xajax->debugOff();
$xajax->setLogFile("/tmp/xajax.log");
/*
$xajax->registerPreFunction('xajax_pre_loading');
function xajax_pre_loading() {
    $objResponse = new xajaxResponse();
    $objResponse->addAssign('elLoading','style.display','none');
    return $objResponse;
}
*/
$xajax->registerFunction("get_files");
$xajax->registerFunction("vota");

$smarty->assign("xajax_js",$xajax->getJavascript());
$xajax->processRequests();

function vota($arquivoId, $nota) {
    global $user, $elgallib;
    $rating = round($elgallib->vote_arquivo($arquivoId, $user, $nota));

    $objResponse = new xajaxResponse();
    $objResponse->addAssign('rt-'.$arquivoId, 'innerHTML', $rating);
    $objResponse->addAssign('rtimg-'.$arquivoId, 'src', 'styles/estudiolivre/rt_'.$rating.'.png');
    return $objResponse;
} 

function get_files($tipos, $offset, $maxRecords, $sort_mode, $userName = '', $find = '', $filters = array()) {
    global $elgallib, $smarty;

    $objResponse = new xajaxResponse();
	$total = $elgallib->count_all_uploads($tipos, $userName);

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

    $objResponse->addAssign("gListCont", "innerHTML", $smarty->fetch("el-gallery_section.tpl"));
    $objResponse->addAssign("listNav", "innerHTML", $smarty->fetch("el-gallery_pagination.tpl"));
    $objResponse->addScript("nd()");
    //$objResponse->addScript("acervoCache('$tiposHr', $offset, $maxRecords, '$sort_mode', '$find', '$filtersHr')");
    
    return $objResponse;
}

?>
