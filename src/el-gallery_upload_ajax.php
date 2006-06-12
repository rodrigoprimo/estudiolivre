<?php

require_once("dumb_progress_meter.php");
require_once("el-gallery_file_edit_ajax.php");

global $userHasPermOnFile, $arquivoId, $el_p_upload_files;

$ajaxlib->registerFunction('upload_info');
function upload_info($uploadId, $callback = 'updateProgressMeter') {
	$objResponse = new xajaxResponse();
	$uploadInfo = upload_progress_meter_get_info($uploadId);
	$objResponse->addScriptCall($callback,$uploadInfo);
	return $objResponse;
}

$ajaxlib->setPermission('create_file', $el_p_upload_files);
$ajaxlib->registerFunction('create_file');
function create_file($tipo, $fileName, $uploadId) {
	$objResponse = new xajaxResponse();
	global $elgallib, $user, $smarty, $tikilib;
	
	$arquivo = array();
	
	$error = $elgallib->validate_filetype($tipo, $fileName, true);
	if ($error) {
		$objResponse->addAlert($error);
		return $objResponse;
	}
	
	$arquivo['tipo'] = $tipo;
	$arquivo['titulo'] = $arquivo['autor'] = $arquivo['donoCopyright'] = $arquivo['descricao'] = '';
	$arquivoId = $elgallib->create_arquivo($arquivo, $user);
	
	if ($licencaId = $tikilib->get_user_preference($user, 'licencaPadrao')) {
		$elgallib->set_licenca($arquivoId, $licencaId);
	}
	
	$objResponse->addScriptCall('startUpload',$arquivoId);
	
	if (in_array($tipo, array('Audio','Video','Imagem'))) {
		$templateName = 'el-gallery_upload_' . $tipo . '.tpl';
		$smarty->assign('permission', true);
		$content = $smarty->fetch($templateName);
		$objResponse->addAssign('gUpMoreOptionsContent', 'innerHTML', $content);
		$objResponse->addScript(_extractScripts($content));
	}
			
	return $objResponse;
}

function _extractScripts($content) {
	preg_match_all('/<script[^>]*>(.+?)<\/script>/', $content, $matches);
	$script = '';
	for ($i=0; $i<sizeof($matches[1]); $i++) {
		$script .= $matches[1][$i];
		$script .= ";\n"; 
	}
	return $script;
}

$ajaxlib->setPermission('get_file_info', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('get_file_info');
function get_file_info() {
	global $elgallib, $arquivoId, $user;
	
	$objResponse = new xajaxResponse();

	$cache = $elgallib->get_edit_cache($arquivoId);
	$result = $elgallib->extract_file_info($arquivoId);
	
	// merge com as infos basicas
	$basicInfos = array('autor' => $elgallib->get_user_preference($user, 'realName'), 'titulo' => $elgallib->get_file_name($arquivoId));
	$result = array_merge($result, $basicInfos);

	// diff para saber campos novos
	$result = array_diff($result, $cache);
	
	// merge
	$cache = array_merge($cache, $result);
	$elgallib->set_edit_cache($arquivoId, $cache);
	
	// deixa o foreach no php, q js eh uma bosta pra isso
	$formattedResult = array();
	foreach ($result as $key => $value) {
		array_push($formattedResult, $key, $value);
	}
	
	if (sizeOf($result) > 0) {
		$objResponse->addScriptCall('setAutoFields', $formattedResult);
	}
		
	return $objResponse;
}


$ajaxlib->setPermission('set_arquivo_licenca', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('set_arquivo_licenca');
function set_arquivo_licenca ($resposta1, $resposta2, $padrao = false) {

    global $userlib, $elgallib, $arquivoId;
    
	$objResponse = new xajaxResponse();
	$licencaId = $elgallib->id_licenca($resposta1, $resposta2);
	    
	if ($padrao) {
	  	$result = $userlib->set_user_field('licencaPadrao', $licencaId);
	   	if(!$result) $objResponse->addAlert("nao foi possivel editar o campo licencaPadrao");
	}
	    
	$result = $elgallib->set_licenca($arquivoId, $licencaId);
		
	if(!$result) {
		$objResponse->addAlert("nao foi possivel editar o campo licencaId");
	} else {
	  	$licenca = $elgallib->get_licenca($licencaId);
	  	$objResponse->addScript("document.getElementById('uImagemLicenca').src = 'styles/estudiolivre/h_" . $licenca['linkImagem'] . "?rand=".rand()."';");
	}
		
	return $objResponse;
	
}

$ajaxlib->setPermission('publish_arquivo', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('publish_arquivo');
function publish_arquivo() {
	global $elgallib, $arquivoId;
	$objResponse = new xajaxResponse();
	
	if ($elgallib->publish_arquivo($arquivoId)) {
    	$objResponse->addRedirect("el-gallery_view.php?arquivoId=$arquivoId");
    } else {
    	$objResponse->addAlert("Não foi possível publicar o arquivo");
    }

    return $objResponse;
}

$ajaxlib->setPermission('check_publish', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('check_publish');
function check_publish() {
	global $elgallib, $arquivoId;
	$objResponse = new xajaxResponse();
	
    if ($errorList = $elgallib->check_publish($arquivoId)) {
    	$errorMsgs = '';
    	foreach ($errorList as $field => $error) {
    		$errorMsgs .= $error . "<br>\n";
    		$objResponse->addScriptCall('exibeErro',$field, $error);
    	}
    	$objResponse->addAssign("gUpErrorList", "innerHTML", $errorMsgs);
    	$objResponse->addScript("showLightbox('gUpError')");
    } else {
    	$objResponse->addScript("showLightbox('el-publish')");
    }
    return $objResponse;    
}


?>
