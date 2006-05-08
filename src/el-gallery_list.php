<?

require_once("tiki-setup.php");
require_once("lib/elgal/elgallib.php");

require_once("el-gallery_ajax.php");

$smarty->assign('style', 'estudiolivre_biblio.css');

$avatar = $tikilib->get_user_avatar($user);
$smarty->assign('avatar', $avatar);

if (isset($_COOKIE['el-tab'])) {
    $cookietab = $_COOKIE['el-tab'];
} else {
    $cookietab = '';
}
$smarty->assign('cookietab',$cookietab);  

$smarty->assign('new_files', $elgallib->new_files($user));
$smarty->assign('user_uploads', $elgallib->count_all_uploads(false,$user));
$smarty->assign('mid', 'el-gallery_list_ajax.tpl');
$smarty->display('tiki.tpl');

?>