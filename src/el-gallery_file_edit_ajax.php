<?php

global $userHasPermOnFile, $arquivoId, $el_p_upload_files;

$ajaxlib->setPermission('save_field', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('save_field');
function save_field($name, $value) {
	global $el_p_admin_gallery, $arquivoId;
	
	$objResponse = new xajaxResponse();

	if ($name == 'tags') {
	    _tag_arquivo($value);
	} else {
	    global $elgallib;
	    
	    $error = $elgallib->edit_field($arquivoId, $name, $value);
	    
	    if($error) {
			$objResponse->addScriptCall('exibeErro', $name, $error);
	    } else {
	    	// TODO: generalizar isso?
	    	if ($name == 'descricao') {
	    		$value = $elgallib->parse_data($value);
	    		//$value = htmlspecialchars($value);
	    	}
			$objResponse->addScriptCall('exibeCampo', $name, $value);
	    }
	}
	
	$objResponse->addScriptCall('setWaiting',$name,false);
	return $objResponse;

}

function _tag_arquivo($tag_string) {
    global $freetaglib, $elgallib, $arquivoId;
    if (!is_object($freetaglib)) {
		include_once('lib/freetag/freetaglib.php');
    }
    
    global $user;

    $arquivo = $elgallib->get_arquivo($arquivoId);
    
    $href = "el-gallery_view.php?arquivoId=$arquivoId";

    $freetaglib->add_object('gallery', $arquivoId, $arquivo['descricao'], $arquivo['titulo'], $href);	
    $freetaglib->update_tags($user, $arquivoId, 'gallery', $tag_string);
	

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
	
	if ($thumb) {
		$objResponse->addAssign("thumbnail", "src", 'repo/' . $thumb);
	}

	return $objResponse;
}

$ajaxlib->setPermission('restore_edit', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('restore_edit');
function restore_edit($arquivoId) {
	global $elgallib, $user, $smarty;
	
	$objResponse = new xajaxResponse();
	
	$arquivo = $elgallib->get_arquivo($arquivoId);
	// permissao tem q ser dentro da funcao, pois o arquivoId dessa chamada pode nao ser
	// o mesmo do global.
	if (!$user || $user != $arquivo['user']) {
		return $objResponse;
	} 
	
	if($arquivo['publicado'] == '0') {
		$templateName = 'el-gallery_metadata_' . $arquivo['tipo'] . '.tpl';
		$smarty->assign('permission', true);
		$content = $smarty->fetch($templateName);
		$objResponse->addAppend('gUpMoreOptionsContent', 'innerHTML', $content);
		$objResponse->addScript(_extractScripts($content));
	}
	
	$cache = unserialize($arquivo['editCache']);
	
	foreach ($cache as $field => $value) {
  		$objResponse->addScriptCall('restoreField', $field, $value);
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
