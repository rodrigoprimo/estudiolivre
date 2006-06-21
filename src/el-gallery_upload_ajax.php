<?php

require_once("dumb_progress_meter.php");
require_once("el-gallery_file_edit_ajax.php");

global $userHasPermOnFile, $arquivoId, $el_p_upload_files;

$ajaxlib->setPermission('create_file', $el_p_upload_files == 'y');
$ajaxlib->registerFunction('create_file');
function create_file($tipo, $fileName, $uploadId) {
	$objResponse = new xajaxResponse();
	global $elgallib, $user, $smarty, $tikilib;
	
	$arquivo = array();
	
	$error = $elgallib->validate_filename($tipo, $fileName);
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
		$templateName = 'el-gallery_metadata_' . $tipo . '.tpl';
		$smarty->assign('permission', true);
		$content = $smarty->fetch($templateName);
		$objResponse->addAppend('gUpMoreOptionsContent', 'innerHTML', $content);
		$objResponse->addScript(_extractScripts($content));
	}
			
	return $objResponse;
}

$ajaxlib->setPermission('delete_file', $el_p_upload_files == 'y');
$ajaxlib->registerFunction('delete_file');
function delete_file($arquivoId) {
	global $elgallib, $user;
	$arquivo = $elgallib->get_arquivo($arquivoId);
	$objResponse = new xajaxResponse();
	
	if (!isset($arquivo['user']) || $arquivo['user'] != $user) {
		return $objResponse;
	}
	
	$elgallib->delete_arquivo($arquivoId);
	
	$objResponse->addRemove("pendente-$arquivoId");
	
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

	// deixa o foreach no php, q js eh uma bosta pra isso
	$formattedResult = array();
	foreach ($result as $key => $value) {
		if (!isset($cache[$key])) {
			array_push($formattedResult, $key, $value);
		}
	}
	
	// merge
	$cache = array_merge($result, $cache);
	$elgallib->set_edit_cache($arquivoId, $cache);
	
	if (sizeOf($result) > 0) {
		$objResponse->addScriptCall('setAutoFields', $formattedResult);
	}
		
	return $objResponse;
}


$ajaxlib->setPermission('set_arquivo_licenca', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('set_arquivo_licenca');
function set_arquivo_licenca ($resposta1, $resposta2, $resposta3, $padrao = false) {

    global $userlib, $elgallib, $arquivoId;
    
	$objResponse = new xajaxResponse();
	$licencaId = $elgallib->id_licenca($resposta1, $resposta2, $resposta3);
	    
	if ($padrao) {
	  	$result = $userlib->set_user_field('licencaPadrao', $licencaId);
	   	if(!$result) $objResponse->addAlert("Não foi possivel editar o campo licencaPadrao");
	}
	    
	$result = $elgallib->set_licenca($arquivoId, $licencaId);
		
	if(!$result) {
		$objResponse->addAlert("Não foi possivel editar o campo licencaId");
	} else {
	  	$licenca = $elgallib->get_licenca($licencaId);
	  	$objResponse->addAssign('uImagemLicenca', 'src', 'styles/estudiolivre/h_' . $licenca['linkImagem'] . '?rand='.rand());
	}
		
	return $objResponse;
	
}

$ajaxlib->setPermission('publish_arquivo', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('publish_arquivo');
function publish_arquivo($dontShowAgain = false) {
    global $elgallib, $arquivoId;
    $objResponse = new xajaxResponse();
    
    if ($elgallib->publish_arquivo($arquivoId)) {
    	$objResponse->addRedirect("el-gallery_view.php?arquivoId=$arquivoId");
    } else {
    	$objResponse->addAlert("Não foi possível publicar o arquivo");
    }

    if ($dontShowAgain) {
	global $userlib, $user;
	$userlib->set_user_preference($user, "el_disclaimer_seen", true);
    }	

    return $objResponse;
}

$ajaxlib->setPermission('check_publish', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('check_publish');
function check_publish() {
    global $user, $userlib, $elgallib, $arquivoId;
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
	if ($userlib->get_user_preference($user, 'el_disclaimer_seen', false)) {
	    return publish_arquivo();
	} else {
	    $objResponse->addScript("showLightbox('el-publish')");
	}
    }
    return $objResponse;    
}

?>
