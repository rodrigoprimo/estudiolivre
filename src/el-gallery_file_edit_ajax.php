<?php
// migrado pra 2.0!
global $userHasPermOnFile, $arquivoId;

$ajaxlib->setPermission('save_field', $userHasPermOnFile && $arquivoId);
$ajaxlib->register(XAJAX_FUNCTION, 'save_field');
function save_field($name, $value, $file = -1) {
	
	if ($name == "tags") return editTags($value);
	
	global $arquivo, $tikilib;
	
	$objResponse = new xajaxResponse();
	
	$error = false;
	if ($file < 0) 
		$error = $arquivo->update(array($name => $value));
	else
		$error = $arquivo->filereferences[(int)$file]->update(array($name => $value));
	
	if(is_string($error)) {
	    $objResponse->call('exibeErro', $name, $error);
	} else {
	    $l = strlen($value);
	    
	    // TODO: avisar usuario
	    $value = strip_tags($value);
	    
	    // TODO: generalizar isso, de acordo com wikiParsed do ajax_textarea
	    if ($name == 'descricao' || $name == 'fichaTecnica' || $name == 'letra') {
			$value = $tikilib->parse_data($value);
	    }
	    $objResponse->call('exibeCampo', $name, $value);
	}
	
	$objResponse->call('setWaiting',$name,false);
	return $objResponse;

}

$ajaxlib->setPermission('editTags', $userHasPermOnFile && $arquivoId);
$ajaxlib->register(XAJAX_FUNCTION, "editTags");
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
	
	$objResponse->assign("show-tags", "innerHTML", $smarty->fetch("el-gallery_tags.tpl"));
    $objResponse->assign("input-tags", "value", $tagString);
    $objResponse->script("document.getElementById('input-tags').style.display = 'none'; document.getElementById('show-tags').style.display = display['tags']");
    
    return $objResponse;
    
}

$ajaxlib->setPermission('setPubThumbFromFile', $userHasPermOnFile && $arquivoId);
$ajaxlib->register(XAJAX_FUNCTION, 'setPubThumbFromFile');
function setPubThumbFromFile($i) {
	
	global $arquivo, $style;
	
	$objResponse = new xajaxResponse();
	if (isset($arquivo->filereferences[$i])) {
		$file =& $arquivo->filereferences[$i];
		
		if ($file->thumbnail) {
			$arquivo->update(array("thumbnail" => $file->thumbnail));
		    $objResponse->assign("js-thumbnailM", "src", $file->baseDir . urlencode($file->thumbnail));
		} else {
		    $objResponse->assign("js-thumbnailM", "src", 'styles/' . preg_replace('/\.css/', '', $style) . 
															 '/img/iThumb' . $arquivo->type . '.png');
		}
	}
	return $objResponse;
}

$ajaxlib->setPermission('expandFile', $userHasPermOnFile && $arquivoId);
$ajaxlib->register(XAJAX_FUNCTION, 'expandFile');
function expandFile($i) {
	
	global $smarty, $arquivo;
	
	$file = &$arquivo->filereferences[$i];
	
	$objResponse = new xajaxResponse();
	if ($file->actualClass == "ZipFile") {
		$files = $file->expand();
		foreach ($files as $newFile) {
			$smarty->assign('file', $newFile);
			$smarty->assign('permission', true);
			$objResponse->append('ajax-pubFilesCont', 'innerHTML', $smarty->fetch("fileBox.tpl"));
		}
		$delete = true;
		$pubHasFiles = count($arquivo->filereferences) > 1;
		if (!$arquivo->allFile && !$pubHasFiles) {
			$arquivo->update(array('allFile' => $file->fullPath()));
			$delete = false;
		}
		$file->delete($delete);
		$objResponse->remove("ajax-file$i");		
	}

    return $objResponse;
}

$ajaxlib->setPermission('deleteFileReference', $userHasPermOnFile && $arquivoId);
$ajaxlib->register(XAJAX_FUNCTION, 'deleteFileReference');
function deleteFileReference($i, $fileId) {
	global $arquivo;
	if ($arquivo->mainFile == (int)$i) $arquivo->update(array('mainFile' => NULL));
	if ($arquivo->mainFile > (int)$i) $arquivo->update(array('mainFile' => $arquivo->mainFile--));
	
	require_once("lib/persistentObj/PersistentObjectFactory.php");
	$file = PersistentObjectFactory::createObject("FileReference", (int)$fileId);
	$file->delete();
	$objResponse = new xajaxResponse();
	$objResponse->remove("ajax-file$i");
	return $objResponse;
}

$ajaxlib->setPermission('setMainFile', $userHasPermOnFile && $arquivoId);
$ajaxlib->register(XAJAX_FUNCTION, 'setMainFile');
function setMainFile($value, $filePos) {
	
	global $arquivo;
	
	if ($value == "1") {
		$arquivo->update(array('mainFile' => (int)$filePos));
	} else {
		$arquivo->update(array('mainFile' => NULL));
	}
	return new xajaxResponse();
}

$ajaxlib->register(XAJAX_FUNCTION, 'upload_info');
function upload_info($uploadId, $i, $callback = 'updateProgressMeter') {
	$objResponse = new xajaxResponse();
	if (function_exists("upload_progress_meter_get_info")) {
		$uploadInfo = upload_progress_meter_get_info($uploadId);
		$objResponse->call($callback, $uploadInfo, $i);
	}
	return $objResponse;
}

?>
