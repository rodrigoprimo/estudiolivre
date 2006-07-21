<?php

if (!isset($_POST['xajax']) || $_POST['xajax'] != 'upload_info') {
	require_once("tiki-setup.php");
	require_once("lib/elgal/elgallib.php");
} else {
        session_start();
        $feature_ajax = "y";
}

require_once("lib/ajax/ajaxlib.php");
require_once("el-gallery_upload_ajax.php");
require_once("el-license_ajax.php");
require_once("el-tags_ajax.php");

$ajaxlib->processRequests();

// Now check permissions to access this page
if (!$user) {
  $smarty->assign('msg', tra("You are not logged in"));
  $smarty->display("error.tpl");
  die;
}

if ($el_p_upload_files != 'y') {
    $smarty->assign('msg', tra("Permission denied you cannot upload files"));
    $smarty->display("error.tpl");
    die;
}

global $tikilib, $user;

$smarty->assign('headtitle', "subir arquivo");

$smarty->assign('category', 'gallery');

$smarty->assign('tag_suggestion', $freetaglib->get_distinct_tag_suggestion('', 0, 10));
$smarty->assign('moreTagsOffset', 10);

//isto eh uma conveniencia, so pra bloquear a mudanca de campo no cliente
//nao garante seguranca
$smarty->assign('permission', $el_p_upload_files);

// licenca padrao
if ($licencaId = $tikilib->get_user_preference($user, 'licencaPadrao')) {
	$licenca = $elgallib->get_licenca($licencaId);
	$smarty->assign('licenca', $licenca);
}

$pending = $elgallib->list_pending_uploads($user);
$restore = -1;
if(isset($_REQUEST['restore'])) {
	foreach ($pending as $key => $p) {
		if($p['arquivoId'] == $_REQUEST['restore'])
			$restore = $key;
	} 
}
$smarty->assign('restore', $restore);
$smarty->assign('pending', $pending);

$smarty->assign('uploadId',rand() . '.' . time());

$smarty->assign('mid','el-gallery_upload.tpl');
$smarty->display('tiki.tpl');

?>
