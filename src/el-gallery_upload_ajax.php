<?php

require_once("dumb_progress_meter.php");
require_once("el-gallery_file_edit_ajax.php");

$ajaxlib->statusMessagesOff();
$ajaxlib->waitCursorOff();
$ajaxlib->debugOff();
$ajaxlib->setLogFile("/tmp/xajax.log");


$ajaxlib->registerFunction('upload_info');
function upload_info($uploadId, $callback = 'updateProgressMeter') {
	$objResponse = new xajaxResponse();
	$uploadInfo = upload_progress_meter_get_info($uploadId);
	$objResponse->addScriptCall($callback,$uploadInfo);
	return $objResponse;
}

$ajaxlib->registerFunction('create_file');
function create_file($tipo, $fileName, $uploadId) {
	$objResponse = new xajaxResponse();
	global $elgallib, $user, $smarty, $tikilib;
	
	$arquivo = array();
	
	$error = false;// TODO $elgallib->validate_filetype($tipo, $fileName);
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

$ajaxlib->registerFunction('generate_thumb');
function generate_thumb($arquivoId) {

	//TODO permissao
	global $elgallib;
	$elgallib->generate_thumb($arquivoId);
	$objResponse = new xajaxResponse();
	$arquivo = $elgallib->get_arquivo($arquivoId);
	$objResponse->addScript("document.getElementById('thumbnail').src = 'repo/" . $arquivo['thumbnail'] . "';");
	return $objResponse;
}

$ajaxlib->registerFunction('set_arquivo_licenca');
function set_arquivo_licenca ($arquivoId, $resposta1, $resposta2, $padrao = false) {

    global $user, $userlib, $elgallib;
	$el_p_admin_acervo = 'y';
	$arquivo = $elgallib->get_arquivo($arquivoId);
	
	if (!$user || $user != $arquivo['user'] || $el_p_admin_acervo != 'y') {
		return false;
    }

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

$ajaxlib->registerFunction('publish_arquivo');
function publish_arquivo($arquivoId) {
	global $user, $elgallib;
	$objResponse = new xajaxResponse();
    
    if ($elgallib->publish_arquivo($arquivoId)) {
    	$objResponse->addRedirect("el-gallery_manage.php?arquivoId=$arquivoId&action=view");
    } else {
    	$objResponse->addAlert("Não foi possível publicar o arquivo");
    }
    return $objResponse;
}

$ajaxlib->registerFunction('check_publish');
function check_publish($arquivoId) {
	global $elgallib;
	$objResponse = new xajaxResponse();
    
    if ($error = $elgallib->check_publish($arquivoId)) {
    	$objResponse->addAssign("gUpErrorList", "innerHTML", nl2br($error));
    	$objResponse->addScript("showLightbox('gUpError')");
    } else {
    	$objResponse->addScript("showLightbox('el-publish')");
    }
    return $objResponse;    
}


?>
