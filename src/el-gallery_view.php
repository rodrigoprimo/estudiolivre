<?php
require_once("tiki-setup.php");
require_once("lib/elgal/elgallib.php");
require_once("lib/ajax/ajaxlib.php");
require_once("el-gallery_file_edit_ajax.php");
require_once("el-gallery_view_ajax.php");
require_once("el-gallery_stream_ajax.php");

$ajaxlib->processRequests();

require_once("lib/freetag/freetaglib.php");
require_once("lib/commentslib.php");
$commentslib = new Comments($dbTiki);

if (!$arquivoId) {
	$smarty->assign('msg',tra('Você não escolheu nenhum arquivo!'));
	$smarty->display('error.tpl');
	exit;
}   

$arquivo = $elgallib->get_arquivo($arquivoId);

$smarty->assign('headtitle', $arquivo['titulo']);
elAddCrumb($arquivo['titulo']);

$smarty->assign('category', 'gallery');

$arquivo['tags'] = $freetaglib->get_tags_on_object($arquivoId, 'gallery');
$arquivo['userRating'] = $elgallib->getUserRating($arquivoId, $user);

$tagString = '';
foreach ($arquivo['tags']['data'] as $t) {
    if ($tagString) $tagString .= ', ';
    $tagString .= $t['tag'];
}
$arquivo['tagString'] = $tagString;

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

if ($userHasPermOnFile) {
	$smarty->assign('permission', true);
}

include_once ("comments.php");




$smarty->assign('uploadId',rand() . '.' . time());

$smarty->assign('mid','el-gallery_view.tpl');
$smarty->display('tiki.tpl');

?>
