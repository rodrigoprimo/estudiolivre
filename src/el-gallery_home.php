<?
require_once("tiki-setup.php");
require_once("lib/elgal/elgallib.php");

$smarty->assign('style', 'estudiolivre_biblio.css');

$info = $tikilib->get_page_info('destak');
$pdata = $tikilib->parse_data($info["data"],$info["is_html"]);
$smarty->assign_by_ref('destak', $pdata);

$avatar = $tikilib->get_user_avatar($user);
$smarty->assign('avatar', $avatar);

$smarty->assign('new_files', $elgallib->new_files($user));
$smarty->assign('arquivos',$elgallib->list_all_uploads(false, 0, 5));
$smarty->assign('user_uploads', $elgallib->count_all_uploads(false,$user));
$smarty->assign('mid', 'el-gallery_home.tpl');
$smarty->display('tiki.tpl');

?>
