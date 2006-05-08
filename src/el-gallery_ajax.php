<?php

require_once("tiki-setup.php");
require_once("lib/xajax/xajax.inc.php");
require_once("lib/elgal/elgallib.php");

$xajax = new xajax();

$xajax->statusMessagesOff();
$xajax->waitCursorOn();
$xajax->debugOff();
$xajax->setLogFile("/tmp/xajax.log");

$xajax->registerPreFunction('xajax_pre_loading');
function xajax_pre_loading() {
    $objResponse = new xajaxResponse();
    $objResponse->addAssign('elLoading','style.display','none');
    return $objResponse;
}

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

function get_files($tipo, $offset, $maxRecords, $sort_mode, $find, $filters) {
    global $elgallib, $smarty;

    $objResponse = new xajaxResponse();

    $files = $elgallib->list_all_uploads($tipo, $offset, $maxRecords, $sort_mode, $find, $filters);
    $smarty->assign_by_ref('arquivos',$files);
    $smarty->assign('maxRecords', $maxRecords);
    $smarty->assign('tipo', $tipo);
    $smarty->assign('offset', $offset);
    $smarty->assign('total', $elgallib->count_all_uploads($tipo));

    $objResponse->addAssign("content-".$tipo,
			    "innerHTML",
			    $smarty->fetch("el-gallery_section.tpl"));
    $objResponse->addScript("acervoCache('$tipo', $offset, $maxRecords, '$sort_mode', '$find', '$filters')");
    
    return $objResponse;

}

?>
