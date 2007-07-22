<?php
// migrado pra 2.0!
global $userHasPermOnFile, $arquivoId;

$ajaxlib->setPermission('save_field', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('save_field');
function save_field($name, $value) {
	
	if ($name == "tags") return editTags($value);
	
	global $arquivo, $tikilib;
	
	$objResponse = new xajaxResponse();
	
	$error = false;
	$error = $arquivo->update(array($name => $value));
	
	if(is_string($error)) {
	    $objResponse->addScriptCall('exibeErro', $name, $error);
	} else {
	    $l = strlen($value);
	    
	    // TODO: avisar usuario
	    $value = strip_tags($value);
	    
	    // TODO: generalizar isso, de acordo com wikiParsed do ajax_textarea
	    if ($name == 'descricao' || $name == 'fichaTecnica' || $name == 'letra') {
			$value = $tikilib->parse_data($value);
	    }
	    $objResponse->addScriptCall('exibeCampo', $name, $value);
	}
	
	$objResponse->addScriptCall('setWaiting',$name,false);
	return $objResponse;

}

$ajaxlib->setPermission('editTags', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction("editTags");
function editTags($tag_string) {
	
	global $smarty, $arquivoId, $freetaglib, $user, $arquivo;

	if (!is_object($freetaglib)) {
		include_once('lib/freetag/freetaglib.php');
    }

	$freetaglib->update_tags($user, $arquivoId, $arquivo->tagType, $tag_string);
	
	$objResponse = new xajaxResponse();
	
	$tags = $freetaglib->get_tags_on_object($arquivoId, $arquivo->tagType);
	$tagString = '';
	foreach ($tags['data'] as $t) {
	    if ($tagString) $tagString .= ', ';
	    $tagString .= $t['tag'];
	}	
	$smarty->assign("fileTags", $tags['data']);
	
	$objResponse->addAssign("show-tags", "innerHTML", $smarty->fetch("el-gallery_tags.tpl"));
    $objResponse->addAssign("input-tags", "value", $tagString);
    $objResponse->addScript("document.getElementById('input-tags').style.display = 'none'; document.getElementById('show-tags').style.display = 'block'");
    
    return $objResponse;
    
}

/* deprecated
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
*/
/*$ajaxlib->setPermission('rollback_arquivo', $userHasPermOnFile && $arquivoId);
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
*/
$ajaxlib->setPermission('generate_thumb', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('generate_thumb');
function generate_thumb() {
	
	global $arquivo, $style;
	
	$objResponse = new xajaxResponse();
	$file =& $arquivo->filereferences[0];
	
	$objResponse->addAssign("ajax-thumbnail", "className", 'gUpThumbImg');	

	if ($file->thumbnail) {
	    $objResponse->addAssign("ajax-thumbnail", "src", $file->baseDir . urlencode($file->thumbnail));
	} else {
	    $objResponse->addAssign("ajax-thumbnail", "src", 'styles/' . preg_replace('/\.css/', '', $style) . 
														 '/img/iThumb' . $arquivo->type . '.png');
	}

	return $objResponse;
}
/* deprecated
$ajaxlib->setPermission('restore_edit', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('restore_edit');
function restore_edit($arquivoId) {
	global $user, $smarty, $freetaglib;
	
	$objResponse = new xajaxResponse();
	
	require_once("lib/persistentObj/PersistentObjectFactory.php");
	$arquivo = PersistentObjectFactory::createObject("Publication", (int)$arquivoId);
	
	// permissao tem q ser dentro da funcao, pois o arquivoId dessa chamada pode nao ser
	// o mesmo do global.
	if (!$user || $user != $arquivo->user) {
		return $objResponse;
	} 
	
	if($arquivo->publishDate && $arquivo->type != "Texto") {
		$templateName = 'el-gallery_metadata_' . $arquivo->type . '.tpl';
		$smarty->assign('permission', true);
		$content = $smarty->fetch($templateName);
		$objResponse->addAppend('ajax-gUpMoreOptionsContent', 'innerHTML', $content);
		$objResponse->addScript(_extractScripts($content));
	}
	
	foreach ($arquivo->getFilledFields() as $field => $value) {
  		$objResponse->addScriptCall('restoreField', $field, $value);
  	}
	
	return $objResponse;
}
*/

$ajaxlib->registerFunction('upload_info');
function upload_info($uploadId, $i, $callback = 'updateProgressMeter') {
	$objResponse = new xajaxResponse();
	$uploadInfo = upload_progress_meter_get_info($uploadId);
	$objResponse->addScriptCall($callback, $uploadInfo, $i);
	return $objResponse;
}

?>
