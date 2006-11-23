<?php

function wikiplugin_acervo_help() {
    $help = tra("Mostra lista de arquivos do acervo com determinada tag ou por id") . "<br/>";
    $help.= "~np~{ACERVO(tag=>MinhaTag)}{ACERVO}~/np~" . "<br/>";
    $help.= "~np~{ACERVO(id=>idDoArquivo)}{ACERVO}~/np~";
    return $help;
}

function retrieveFileInfo($id) {
	
	global $freetaglib, $elgallib, $commentslib;
	
	require_once("lib/elgal/elgallib.php");
		
	$arquivo = $elgallib->get_arquivo($id);
	$arquivo['commentsCount'] = $commentslib->count_comments('arquivo:' . $id);
	$arquivo['tags'] = $freetaglib->get_tags_on_object($id, 'gallery');
	$arquivo['descricaoLicenca'] = $arquivo['licenca']['descricao'];
	$arquivo['linkImagem'] = $arquivo['licenca']['linkImagem'];
	$arquivo['linkHumanReadable'] = $arquivo['licenca']['linkHumanReadable'];
	
	return $arquivo;
}

function wikiplugin_acervo($data, $params) {

    global $smarty, $freetaglib, $style; 
    
    require_once("lib/freetag/freetaglib.php");
    
    $styleUrl = "styles/" . preg_replace('/\.css/', '', $style) . "/css/el-gallery_list_item.css";
	if (file_exists($styleUrl)) {
	    $result = "<link rel='StyleSheet'  href='$styleUrl' type='text/css' />";
	} else {
		$result = "";
	}
    
    if(isset($params['id']) && $params['id'] > 0) {
		$smarty->assign_by_ref("arquivo", retrieveFileInfo($params['id']));
		$result .= $smarty->fetch('el-gallery_list_item.tpl');
	    return "~np~$result~/np~";
    }
    if(!isset($params['tag']) && isset($params['tags'])) { $params['tag'] = $params['tags']; }
    $objects = $freetaglib->get_objects_with_tag_combo(split(",",$params['tag']), 'gallery');
    
    foreach ($objects['data'] as $object) {
		$smarty->assign_by_ref("arquivo", retrieveFileInfo($object['itemId']));
		$result .= $smarty->fetch('el-gallery_list_item.tpl');
    }

    return "~np~$result~/np~";
    
}

?>

