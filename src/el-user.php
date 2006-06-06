<?php

// Initialization
require_once('tiki-setup.php');
require_once('lib/elgal/elgallib.php');
require_once('lib/ajax/ajaxlib.php');

if (isset($_REQUEST['view_user'])) {
	$userwatch = $_REQUEST['view_user'];
	if ($userwatch == $user) 
		$permission = true;
	else 
		$permission = false;
} else {
	if ($user) {
		$userwatch = $user;
		$permission = true;
	} else {
		$noUser = true;
		$permission = false;
	}
}

$_REQUEST['view_user'] = $userwatch;
$view_user = $_REQUEST['view_user'];

require_once('lib/messu/messulib.php');
require_once("el-user_ajax.php");
require_once("el-gallery_ajax.php");

$ajaxlib->processRequests();

require_once('lib/blogs/bloglib.php');
require_once('lib/commentslib.php');
$commentslib = new Comments($dbTiki);

if (isset($noUser)) {
	$smarty->assign('msg', tra("You are not logged in and no user indicated"));
	$smarty->display("error.tpl");
	die;
}

$info = $tikilib->get_page_info("Usuário_" . $view_user);
$pdata = $tikilib->parse_data($info["data"],$info["is_html"]);
$smarty->assign_by_ref('userWiki', $pdata);

$sort_mode = 'data_publicacao_desc';

$uploads = $elgallib->list_all_uploads(array('Audio', 'Video', 'Imagem', 'Texto'), 0, 5, $sort_mode, $view_user);
$smarty->assign_by_ref('arquivos',$uploads);

$total = $elgallib->count_all_uploads(array('Audio', 'Video', 'Imagem', 'Texto'), $view_user);

$smarty->assign('permission', $permission);
$smarty->assign('userName', $view_user);
$smarty->assign('maxRecords', 5);
$smarty->assign('offset', 0);
$smarty->assign('sort_mode', $sort_mode);
$smarty->assign('total', $total);
$smarty->assign('find', '');
$smarty->assign('filters', array());
$smarty->assign('page', 1);
$smarty->assign('lastPage', ceil($total/5));


$userPosts = $bloglib->list_user_posts($view_user, 0, 5);
for($i = 0; $i < sizeof($userPosts['data']); $i++) {
	$userPosts['data'][$i]['commentsCount'] = $commentslib->count_comments('post:' . $userPosts['data'][$i]['postId']);
}
$smarty->assign('userPosts', $userPosts);

$smarty->assign('userMessages', $messulib->list_user_messages($view_user, 0, 5, 'date_desc', '', '', '', '', 'messages'));

$smarty->assign('uploadId',rand() . '.' . time());

include("tiki-user_information.php");

?>
