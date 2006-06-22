<?php

if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

/*
 * Smarty plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     el_gallery_item
 * Purpose:  TODO
 * -------------------------------------------------------------
 * {el_gallery_item id=$arquivoId}
 */
function smarty_function_el_gallery_item($params, &$smarty) {
	$id = $params['id'];

	if (!$id) return '';

	global $smarty, $elgallib, $commentslib, $freetaglib;
	require_once('lib/elgal/elgallib.php');

	$arquivo = $elgallib->get_arquivo($id);
	$arquivo['commentsCount'] = $commentslib->count_comments('arquivo:' . $id);
	$arquivo['tags'] = $freetaglib->get_tags_on_object($id, 'gallery');
	$arquivo['descricaoLicenca'] = $arquivo['licenca']['descricao'];
	$arquivo['linkImagem'] = $arquivo['licenca']['linkImagem'];
	$arquivo['linkHumanReadable'] = $arquivo['licenca']['linkHumanReadable'];
	$smarty->assign_by_ref('arquivo', $arquivo);
	return $smarty->fetch('el-gallery_list_item.tpl');
}

?>

