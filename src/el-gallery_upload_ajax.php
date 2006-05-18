<?php

require_once("lib/xajax/xajax.inc.php");

$xajax = new xajax();

$xajax->statusMessagesOff();
$xajax->waitCursorOff();
$xajax->debugOff();
$xajax->setLogFile("/tmp/xajax.log");

$xajax->registerFunction('upload_info');
$xajax->registerFunction('create_file');
$xajax->registerFunction('save_field');

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

function save_field($arquivoId, $name, $value) {
	$objResponse = new xajaxResponse();
	global $elgallib, $user, $el_p_admin_acervo;
	$el_p_admin_acervo = 'y';
	$arquivo = $elgallib->get_arquivo($arquivoId);
	if (!$user || $user != $arquivo['user'] || $el_p_admin_acervo != 'y') {
		return false;
	}
	$result = $elgallib->edit_field($arquivoId, $name, $value);
	
	if(!$result) {
		$objResponse->addAlert("nao foi possivel editar o campo $name");
	} else {
		$objResponse->addScriptCall('exibeCampo', $name, $value);
	}
	
	return $objResponse;
	
}

$xajax->processRequests();

?>
