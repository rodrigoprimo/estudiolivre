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
	$elgallib->generate_thumb($arquivoId);

	$arquivo = $elgallib->get_arquivo($arquivoId);
	$objResponse->addScript("document.getElementById('thumbnail').src = 'repo/" . $arquivo['thumbnail'] . "';");
		
	return $objResponse;
}



?>
