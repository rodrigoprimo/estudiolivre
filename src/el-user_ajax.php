<?php

require_once("lib/xajax/xajax.inc.php");

$xajax = new xajax();

$xajax->statusMessagesOff();
$xajax->waitCursorOff();
$xajax->debugOff();
$xajax->setLogFile("/tmp/xajax.log");

$xajax->registerFunction('save_field');
$xajax->registerFunction('upload_info');
$xajax->registerFunction('get_files');

function upload_info($uploadId, $callback = 'updateProgressMeter') {
	$objResponse = new xajaxResponse();
	$uploadInfo = upload_progress_meter_get_info($uploadId);
	$objResponse->addScriptCall($callback,$uploadInfo);
	return $objResponse;
}

function save_field($name, $value) {
	$objResponse = new xajaxResponse();

    global $user, $userlib;
    
    if (!$user) {
		return false;
    }
    
    $result = $userlib->set_user_field($name, $value);
    
    if(!$result) {
		$objResponse->addAlert("nao foi possivel editar o campo $name");
    } else {
		$objResponse->addScriptCall('exibeCampo', $name, $value);
    }
	
	return $objResponse;

}

function get_files($tipos, $offset, $maxRecords, $sort_mode, $userName, $find, $filters = array()) {
    global $elgallib, $smarty;

    $objResponse = new xajaxResponse();
	$total = $elgallib->count_all_uploads($tipos);

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

$xajax->processRequests();

?>
