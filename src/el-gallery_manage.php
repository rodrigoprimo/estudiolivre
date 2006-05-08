<?php
require_once("tiki-setup.php");
require_once("lib/elgal/elgallib.php");

if (!$user) {
  $smarty->assign('msg', tra("You are not logged in"));
  $smarty->display("error.tpl");
  die;
}

global $tikilib, $user;

$smarty->assign('style', 'estudiolivre_biblio.css');
$smarty->assign('user_uploads', $elgallib->count_all_uploads(false,$user));

$avatar = $tikilib->get_user_avatar($user);
$smarty->assign('avatar', $avatar);

if (!isset($_REQUEST['action'])) {
  $smarty->assign('all',$elgallib->list_all_user_uploads($user));
  $smarty->assign('pending',$elgallib->list_pending_uploads($user));
  
  $smarty->assign('mid','el-gallery_manage.tpl');
} else {
  if ($_REQUEST['action'] == 'delete') {
    //if we have arquivoId, we can delete the file.
    if (isset($_REQUEST['arquivoId'])){
      if($elgallib->delete_arquivo($_REQUEST['arquivoId'])){
	$smarty->assign('msg','arquivo apagado com sucesso, id:'.$_REQUEST['arquivoId']);
      }
    }
    $smarty->assign('all',$elgallib->list_all_user_uploads($user));
    $smarty->assign('pending',$elgallib->list_pending_uploads($user));
    $smarty->assign('mid','el-gallery_manage.tpl');
  }

  if ($_REQUEST['action'] == 'edit') {
    $smarty->assign('licencas',$elgallib->get_licencas());
    $smarty->assign('tipos',$elgallib->get_tipos());
    $smarty->assign('arquivoId',$_REQUEST['arquivoId']);
    $smarty->assign('arquivo',$elgallib->get_arquivo($_REQUEST['arquivoId']));
    $smarty->assign('mid','el-gallery_edit.tpl');
  }
  
  if ($_REQUEST['action'] == 'save') {
    $elgallib->set_metadata($_REQUEST['geralStub'], $_REQUEST['especificoStub'], strtolower($_REQUEST['geralStub']['tipo']));
    $smarty->assign('all',$elgallib->list_all_user_uploads($user));
    $smarty->assign('pending',$elgallib->list_pending_uploads($user));
    $smarty->assign('mid','el-gallery_manage.tpl');
  }

  if ($_REQUEST['action'] == 'view') {
    
    $arquivoId = $_REQUEST['arquivoId'];
    $arquivo = $elgallib->get_arquivo($arquivoId);

    if ($feature_freetags == 'y') {     // And get the Tags for the posts
      include_once("lib/freetag/freetaglib.php");
      $tags = $freetaglib->get_tags_on_object($arquivo['arquivoId'], $arquivo['tipo']);
      $smarty->assign('freetags',$tags);
    }
    
    $smarty->assign('arquivoId',$arquivoId);
    $smarty->assign('arquivo',$arquivo);
    $smarty->assign('mid','el-gallery_view_file.tpl');

    // $comments_per_page = 10;
    // $comments_default_ordering = $blog_comments_default_ordering;
    $comments_vars = array('arquivoId','action');
    $comments_prefix_var = 'arquivo:';
    $comments_object_var = 'arquivoId';
    include_once ("comments.php");
  }
}

$smarty->display('tiki.tpl');

?>