<?php
require_once("tiki-setup.php");
require_once("lib/persistentObj/PersistentObjectFactory.php");
require_once("lib/ajax/ajaxlib.php");

global $userHasPermOnFile, $arquivoId, $el_p_admin_gallery;

if (isset($_REQUEST['arquivoId'])) {
	$arquivoId = $_REQUEST['arquivoId'];
	$arquivo = PersistentObjectFactory::createObject("Publication", (int)$_REQUEST['arquivoId']);
	if ($arquivo->user == $user || $el_p_admin_gallery == 'y') {
		$userHasPermOnFile = true;
	} else {
		$userHasPermOnFile = false;
	}		
} else {
	$arquivoId = false;
}

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
