<?php


$ajaxlib->registerFunction('save_field');
function save_field($arquivoId, $name, $value) {
	global $el_p_admin_gallery;
	
	$objResponse = new xajaxResponse();

	if ($name == 'tags') {
	    _tag_arquivo($arquivoId, $value);
	} else {
	    global $elgallib, $user, $el_p_admin_acervo;
	    $arquivo = $elgallib->get_arquivo($arquivoId);
	    if ($user != $arquivo['user'] && $el_p_admin_gallery != 'y') {
	    	if (!$usr) $objResponse->addAlert('Sua sessao expirou!');
			return $objResponse;
	    }
	    $error = $elgallib->edit_field($arquivoId, $name, $value);
	    
	    if($error) {
			$objResponse->addScriptCall('exibeErro', $name, $error);
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

$ajaxlib->registerFunction('commit_arquivo');
function commit_arquivo($arquivoId) {
	global $elgallib;
	$objResponse = new xajaxResponse();
	
	if ($elgallib->commit($arquivoId)) {
		$objResponse->addScript('finishEdit()');
	}
	return $objResponse;
}

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
?>
