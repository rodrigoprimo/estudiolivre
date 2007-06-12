<?php
// migrado pra 2.0!
require_once("tiki-setup.php");
include_once("el-gallery_set_publication.php");
require_once("lib/ajax/ajaxlib.php");
require_once("el-gallery_file_edit_ajax.php");
require_once("el-gallery_view_ajax.php");
require_once("el-gallery_stream_ajax.php");

$ajaxlib->processRequests();

if (!$arquivoId) {
	$smarty->assign('msg',tra('Você não escolheu nenhum arquivo!'));
	$smarty->display('error.tpl');
	exit;
}   

if (!$arquivo || !$arquivo->publishDate) {
	$smarty->assign('msg',tra('Arquivo inexistente!'));
	$smarty->display('error.tpl');
	exit;
}   

$tagString = '';
foreach ($arquivo->tags as $t) {
	$tagString .= $t['tag'] . ", ";
}
$tagString = substr($tagString, 0, strlen($tagString)-2);
$arquivo->tagString = $tagString;

$smarty->assign('headtitle', $arquivo->title);
elAddCrumb($arquivo->title);

$smarty->assign('category', 'gallery');

$smarty->assign('arquivoId',$arquivoId);
$smarty->assign('arquivo',$arquivo);

if ($userHasPermOnFile) {
	$smarty->assign('permission', true);
}

$smarty->assign('dontAskDelete', $tikilib->get_user_preference($user, 'el_dont_check_delete', 0));
$smarty->assign('uploadId',rand() . '.' . time());


$smarty->assign('mid','el-gallery_view.tpl');
$smarty->display('tiki.tpl');

?>
