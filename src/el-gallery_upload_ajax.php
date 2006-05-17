<?php

require_once("lib/xajax/xajax.inc.php");

$xajax = new xajax();

$xajax->statusMessagesOff();
$xajax->waitCursorOff();
$xajax->debugOff();
$xajax->setLogFile("/tmp/xajax.log");

$xajax->registerFunction('upload_info');
$xajax->registerFunction('create_file');

function upload_info($uploadId) {
	$objResponse = new xajaxResponse();
	$uploadInfo = upload_progress_meter_get_info($uploadId);
	$objResponse->addScriptCall('updateProgressMeter',$uploadInfo);
	return $objResponse;
}

function create_file($tipo, $uploadId) {
	$objResponse = new xajaxResponse();
	global $elgallib, $user;
	$arquivo = array();
	$arquivo['tipo'] = $tipo;
	$arquivo['titulo'] = $arquivo['autor'] = $arquivo['donoCopyright'] = $arquivo['descricao'] = '';
	$arquivoId = $elgallib->create_arquivo($arquivo, $user);
	$objResponse->addScriptCall('startUpload',$arquivoId);
	return $objResponse;
}

$xajax->processRequests();

?>