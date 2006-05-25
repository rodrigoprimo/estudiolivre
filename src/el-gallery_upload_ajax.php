<?php

require_once("lib/xajax/xajax.inc.php");
require_once("dumb_progress_meter.php");

$xajax = new xajax();

$xajax->statusMessagesOff();
$xajax->waitCursorOff();
$xajax->debugOff();
$xajax->setLogFile("/tmp/xajax.log");


$xajax->registerFunction('upload_info');
function upload_info($uploadId, $callback = 'updateProgressMeter') {
	$objResponse = new xajaxResponse();
	$uploadInfo = upload_progress_meter_get_info($uploadId);
	$objResponse->addScriptCall($callback,$uploadInfo);
	return $objResponse;
}

$xajax->registerFunction('create_file');
function create_file($tipo, $fileName, $uploadId) {
	$objResponse = new xajaxResponse();
	global $elgallib, $user, $smarty, $tikilib;
	
	$arquivo = array();
	
	$error = $elgallib->validate_filetype($tipo, $fileName);
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
		$content = $smarty->fetch($templateName);
		$objResponse->addAssign('gUpMoreOptionContent', 'innerHTML', $content);	
	}
			
	return $objResponse;
}

$xajax->registerFunction('generate_thumb');
function generate_thumb($arquivoId) {

	//TODO permissao
	global $elgallib;
	$elgallib->generate_thumb($arquivoId);
	$objResponse = new xajaxResponse();
	$arquivo = $elgallib->get_arquivo($arquivoId);
	$objResponse->addScript("document.getElementById('thumbnail').src = 'repo/" . $arquivo['thumbnail'] . "';");
	return $objResponse;
}

$xajax->registerFunction('save_field');
function save_field($arquivoId, $name, $value) {
	$objResponse = new xajaxResponse();

	if ($name == 'tags') {
	    _tag_arquivo($arquivoId, $value);
	} else {
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
	}
	
	return $objResponse;

}

function _tag_arquivo($arquivoId, $tag_string) {
    global $freetaglib, $elgallib;
    if (!is_object($freetaglib)) {
	include_once('lib/freetag/freetaglib.php');
    }
    
    global $user;

    $arquivo = $elgallib->get_arquivo($arquivoId);
    
    $href = "el-arquivo.php?arquivoId=$arquivoId";

    $freetaglib->add_object('acervo', $arquivoId, $arquivo['descricao'], $arquivo['titulo'], $href);	
    $freetaglib->update_tags($user, $arquivoId, 'acervo', $tag_string);
	

}
$xajax->registerFunction('set_arquivo_licenca');
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
    	$objResponse->addScript("document.getElementById('uImagemLicenca').src = 'styles/estudiolivre/" . $licenca['linkImagem'] . "?rand=".rand()."';");
    }
	
	return $objResponse;
	
}

$xajax->registerFunction('publish_arquivo');
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

$xajax->processRequests();

?>
