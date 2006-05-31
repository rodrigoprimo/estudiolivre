<?php
require_once("tiki-setup.php");
require_once("lib/elgal/elgallib.php");
require_once("lib/ajax/ajaxlib.php");
require_once("el-gallery_file_edit_ajax.php");

$ajaxlib->processRequests();

// TODO: mudar nos templates a verificacao da galeria por category, nao style
$smarty->assign('style', 'estudiolivre_biblio.css');
$smarty->assign('category', 'gallery');

$avatar = $tikilib->get_user_avatar($user);
$smarty->assign('avatar', $avatar);

if (!isset($_REQUEST['arquivoId'])) {
	$smarty->assign('msg',tra('Você não escolheu nenhum arquivo!'));
	$smarty->display('error.tpl');
	exit;
}   
$arquivoId = $_REQUEST['arquivoId'];
$arquivo = $elgallib->get_arquivo($arquivoId);

elAddCrumb($arquivo['titulo']);

$smarty->assign('arquivoId',$arquivoId);
$smarty->assign('arquivo',$arquivo);

if ($feature_freetags == 'y') {     // And get the Tags for the posts
    include_once("lib/freetag/freetaglib.php");
    $tags = $freetaglib->get_tags_on_object($arquivo['arquivoId'], $arquivo['tipo']);
    $smarty->assign('freetags',$tags);
}
    
// $comments_per_page = 10;
// $comments_default_ordering = $blog_comments_default_ordering;
$comments_vars = array('arquivoId','action');
$comments_prefix_var = 'arquivo:';
$comments_object_var = 'arquivoId';

if (isset($el_p_admin_gallery) && $el_p_admin_gallery == 'y' || $user == $arquivo['user']) {
	$smarty->assign('permission', true);
}

include_once ("comments.php");

$smarty->assign('mid','el-gallery_view.tpl');
$smarty->display('tiki.tpl');

?>