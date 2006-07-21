<?php

global $userHasPermOnFile, $arquivoId, $el_p_upload_files;

$ajaxlib->setPermission('save_field', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('save_field');
function save_field($name, $value) {
	global $el_p_admin_gallery, $arquivoId;
	
	$objResponse = new xajaxResponse();

	global $elgallib;
	
	$error = $elgallib->edit_field($arquivoId, $name, $value);
	
	if($error) {
	    $objResponse->addScriptCall('exibeErro', $name, $error);
	} else {
	    $l = strlen($value);
	    
	    // TODO: avisar usuario
	    $value = strip_tags($value);
	    
	    // TODO: generalizar isso, de acordo com wikiParsed do ajax_textarea
	    if ($name == 'descricao' || $name == 'fichaTecnica' || $name == 'letra') {
		$value = $elgallib->parse_data($value);
	    }
	    $objResponse->addScriptCall('exibeCampo', $name, $value);
	}
	
	$objResponse->addScriptCall('setWaiting',$name,false);
	return $objResponse;

}

$ajaxlib->setPermission('commit_arquivo', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('commit_arquivo');
function commit_arquivo() {
	global $elgallib, $arquivoId;
	$objResponse = new xajaxResponse();
	
	if ($elgallib->commit($arquivoId)) {
		$objResponse->addScript('finishEdit()');
	}
	return $objResponse;
}

$ajaxlib->setPermission('rollback_arquivo', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('rollback_arquivo');
function rollback_arquivo() {
	global $elgallib, $arquivoId;
	
	$objResponse = new xajaxResponse();
	
	if ($elgallib->rollback($arquivoId)) {
		$arquivo = $elgallib->get_arquivo($arquivoId);
		$fields = array_merge($elgallib->basic_fields, $elgallib->extension_fields);
		foreach ($fields as $field) {
			if (isset($arquivo[$field])) {
				$objResponse->addScriptCall('exibeCampo',$field, $arquivo[$field]);
			}
		}
		$objResponse->addScript('finishEdit()');
	}
	return $objResponse;
}

$ajaxlib->setPermission('generate_thumb', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('generate_thumb');
function generate_thumb() {
	global $elgallib, $arquivoId;
	$objResponse = new xajaxResponse();
	$thumb = $elgallib->generate_thumb($arquivoId);

	$objResponse->addAssign("thumbnail", "className", 'gUpThumbImg');	

	if ($thumb) {
	    $objResponse->addAssign("thumbnail", "src", 'repo/' . $thumb);
	} else {
	    $arquivo = $elgallib->get_arquivo($arquivoId);
	    $objResponse->addAssign("thumbnail", "src", 'styles/estudiolivre/iThumb' . $arquivo["tipo"] . '.png');
	}

	return $objResponse;
}

$ajaxlib->setPermission('restore_edit', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('restore_edit');
function restore_edit($arquivoId) {
	global $elgallib, $user, $smarty, $freetaglib;
	
	$objResponse = new xajaxResponse();
	
	$arquivo = $elgallib->get_arquivo($arquivoId);
	
	// permissao tem q ser dentro da funcao, pois o arquivoId dessa chamada pode nao ser
	// o mesmo do global.
	if (!$user || $user != $arquivo['user']) {
		return $objResponse;
	} 
	
	if($arquivo['publicado'] == '0' && $arquivo['tipo'] != "Texto") {
		$templateName = 'el-gallery_metadata_' . $arquivo['tipo'] . '.tpl';
		$smarty->assign('permission', true);
		$content = $smarty->fetch($templateName);
		$objResponse->addAppend('gUpMoreOptionsContent', 'innerHTML', $content);
		$objResponse->addScript(_extractScripts($content));
	}
	
	$tags = $freetaglib->get_tags_on_object($arquivoId, 'gallery');
	$tagString = "";
	foreach ($tags['data'] as $t) {
	    if ($tagString) $tagString .= ', ';
	    $tagString .= $t['tag'];
	}

	$cache = unserialize($arquivo['editCache']);
	//	$cache['tags'] = $tagString;
	
	foreach ($cache as $field => $value) {
  		$objResponse->addScriptCall('restoreField', $field, $value);
  	}
	
	if ($arquivo["arquivo"]) {
	    preg_match("/\d+_\d+-(.+)$/", $arquivo['arquivo'], $nome);
	    $objResponse->addAssign("gUpFileName", "innerHTML", $nome[1]);
	}
	if (!$arquivo['thumbnail']) {
		$objResponse->addAssign("thumbnail", "src", "styles/estudiolivre/iThumb" . $arquivo['tipo'] . ".png");			
	} else {
		$objResponse->addAssign("thumbnail", "src", "styles/estudiolivre/iThumb" . $arquivo['thumbnail'] . ".png");
	}
	return $objResponse;
}


$ajaxlib->registerFunction('upload_info');
function upload_info($uploadId, $callback = 'updateProgressMeter') {
	$objResponse = new xajaxResponse();
	$uploadInfo = upload_progress_meter_get_info($uploadId);
	$objResponse->addScriptCall($callback,$uploadInfo);
	return $objResponse;
}

?>
