<?php

require_once("dumb_progress_meter.php");

$ajaxlib->registerFunction('upload_info');
function upload_info($uploadId, $callback = 'updateProgressMeter') {
	$objResponse = new xajaxResponse();
	$uploadInfo = upload_progress_meter_get_info($uploadId);
	$objResponse->addScriptCall($callback,$uploadInfo);
	return $objResponse;
}

$ajaxlib->setPermission('save_field', $permission);
$ajaxlib->registerFunction('save_field');
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

?>
