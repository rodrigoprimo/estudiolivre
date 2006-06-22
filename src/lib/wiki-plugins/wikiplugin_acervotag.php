<?php

function wikiplugin_acervotag_help() {
    $help = tra("Mostra lista de arquivos do acervo com determinada tag") . "\n";
    $help.= "~np~{ACERVOTAG(tag=>MinhaTag)}{ACERVOTAG}~/np~";
    return $help;
}
function wikiplugin_acervotag($data, $params) {

    global $freetaglib, $elgallib, $smarty, $commentslib;

    require_once("lib/freetag/freetaglib.php");
    require_once("lib/elgal/elgallib.php");
    
    $objects = $freetaglib->get_objects_with_tag($params['tag'], 'gallery');
    $result = "";
    
    foreach ($objects['data'] as $object) {
	$arquivo = $elgallib->get_arquivo($object['itemId']);
	$arquivo['commentsCount'] = $commentslib->count_comments('arquivo:' . $id);
	$arquivo['tags'] = $freetaglib->get_tags_on_object($object['itemId'], 'gallery');
	$arquivo['descricaoLicenca'] = $arquivo['licenca']['descricao'];
	$arquivo['linkImagem'] = $arquivo['licenca']['linkImagem'];
	$arquivo['linkHumanReadable'] = $arquivo['licenca']['linkHumanReadable'];

	$smarty->assign_by_ref("arquivo", $arquivo);

	$result .= $smarty->fetch('el-gallery_list_item.tpl');
    }
    return "~np~$result~/np~";
    
}

?>

