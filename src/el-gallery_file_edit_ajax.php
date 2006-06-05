<?php

global $userHasPermOnFile;

$ajaxlib->setPermission('save_field', $userHasPermOnFile);
$ajaxlib->registerFunction('save_field');
function save_field($arquivoId, $name, $value) {
	global $el_p_admin_gallery;
	
	$objResponse = new xajaxResponse();

	if ($name == 'tags') {
	    _tag_arquivo($arquivoId, $value);
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

$ajaxlib->setPermission('commit_arquivo', $userHasPermOnFile);
$ajaxlib->registerFunction('commit_arquivo');
function commit_arquivo($arquivoId) {
	global $elgallib;
	$objResponse = new xajaxResponse();
	
	if ($elgallib->commit($arquivoId)) {
		$objResponse->addScript('finishEdit()');
	}
	return $objResponse;
}

$ajaxlib->setPermission('rollback_arquivo', $userHasPermOnFile);
$ajaxlib->registerFunction('rollback_arquivo');
function rollback_arquivo($arquivoId) {
	global $elgallib;
	
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

$ajaxlib->setPermission('restore_edit', $userHasPermOnFile);
$ajaxlib->registerFunction('restore_edit');
function restore_edit($arquivoId) {
	global $elgallib;
	
	$objResponse = new xajaxResponse();
	
	$arquivo = $elgallib->get_arquivo($arquivoId);
	$cache = unserialize($arquivo['editCache']);
	
	foreach ($cache as $field => $value) {
  		$objResponse->addScriptCall('restoreField', $field, $value);
  	}
  	
	return $objResponse;
		
}

$ajaxlib->setPermission('generate_thumb', $userHasPermOnFile);
$ajaxlib->registerFunction('generate_thumb');
function generate_thumb($arquivoId) {
	global $elgallib;

	$objResponse = new xajaxResponse();
	$elgallib->generate_thumb($arquivoId);

	$arquivo = $elgallib->get_arquivo($arquivoId);
	$objResponse->addScript("document.getElementById('thumbnail').src = 'repo/" . $arquivo['thumbnail'] . "';");
		
	return $objResponse;
}



?>
