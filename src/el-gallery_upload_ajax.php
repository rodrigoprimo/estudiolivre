<?php

require_once("lib/xajax/xajax.inc.php");

$xajax = new xajax();

$xajax->statusMessagesOff();
$xajax->waitCursorOff();
$xajax->debugOff();
$xajax->setLogFile("/tmp/xajax.log");

$xajax->registerFunction('upload_info');

function upload_info($uploadId) {
	$objResponse = new xajaxResponse();
	$uploadInfo = upload_progress_meter_get_info($uploadId);
	$objResponse->addScriptCall('updateProgressMeter',$uploadInfo);
	return $objResponse;
}

$xajax->processRequests();
?>