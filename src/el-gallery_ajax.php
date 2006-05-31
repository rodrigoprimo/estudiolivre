<?php

$ajaxlib->statusMessagesOff();
$ajaxlib->waitCursorOn();
$ajaxlib->debugOff();
$ajaxlib->setLogFile("/tmp/xajax.log");
/*
$ajaxlib->registerPreFunction('xajax_pre_loading');
function xajax_pre_loading() {
    $objResponse = new xajaxResponse();
    $objResponse->addAssign('elLoading','style.display','none');
    return $objResponse;
}
*/

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

?>
