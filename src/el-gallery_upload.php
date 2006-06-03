<?php

if (!isset($_POST['xajax']) || $_POST['xajax'] != 'upload_info') {
	require_once("tiki-setup.php");
	require_once("lib/elgal/elgallib.php");
} else {
	$feature_ajax = "y";
}

require_once("lib/ajax/ajaxlib.php");
require_once("el-gallery_upload_ajax.php");

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

include_once("freetag_list.php");

global $tikilib, $user;

//TODO tirar abaixo e deixar apenas o category
$smarty->assign('style', 'estudiolivre_biblio.css');
$smarty->assign('category', 'gallery');

$avatar = $tikilib->get_user_avatar($user);
$smarty->assign('avatar', $avatar);

$arquivoId = 0;

//isto eh uma conveniencia, so pra bloquear a mudanca de campo no cliente
//nao garante seguranca
$smarty->assign('permission',true);

// licenca padrao
if ($licencaId = $tikilib->get_user_preference($user, 'licencaPadrao')) {
	$licenca = $elgallib->get_licenca($licencaId);
	$smarty->assign('licenca', $licenca);
}

$smarty->assign('realName',$tikilib->get_user_preference($user, 'realName'));

$smarty->assign('uploadId',rand() . '.' . time());

$smarty->assign('mid','el-gallery_upload.tpl');
$smarty->display('tiki.tpl');

?>
