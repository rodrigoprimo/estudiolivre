<?php

require_once("dumb_progress_meter.php");

$ajaxlib->statusMessagesOff();
$ajaxlib->waitCursorOff();
$ajaxlib->debugOff();
$ajaxlib->setLogFile("/tmp/xajax.log");

$ajaxlib->registerFunction('save_field');
$ajaxlib->registerFunction('upload_info');
$ajaxlib->registerFunction('get_files');

function upload_info($uploadId, $callback = 'updateProgressMeter') {
	$objResponse = new xajaxResponse();
	$uploadInfo = upload_progress_meter_get_info($uploadId);
	$objResponse->addScriptCall($callback,$uploadInfo);
	return $objResponse;
}

function save_field($name, $value) {

    global $user, $userlib;

    if (!$user) {
		return false;
    }

	$objResponse = new xajaxResponse();
    
    $result = $userlib->set_user_field($name, $value);
    
    if(!$result) {
		$objResponse->addAlert("nao foi possivel editar o campo $name");
    } else {
		$objResponse->addScriptCall('exibeCampo', $name, $value);
    }
	
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
