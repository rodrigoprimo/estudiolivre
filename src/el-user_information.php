<?php

// Initialization
require_once('tiki-setup.php');
require_once('lib/elgal/elgallib.php');
require_once('lib/blogs/bloglib.php');
require_once('lib/messu/messulib.php');
require_once('lib/commentslib.php');
$commentslib = new Comments($dbTiki);

if (isset($_REQUEST['view_user'])) {
	$userwatch = $_REQUEST['view_user'];
} else {
	if ($user) {
		$userwatch = $user;
	} else {
		$smarty->assign('msg', tra("You are not logged in and no user indicated"));

		$smarty->display("error.tpl");
		die;
	}
}

$_REQUEST['view_user'] = $userwatch;

$info = $tikilib->get_page_info("Usuário_" . $_REQUEST['view_user']);
$pdata = $tikilib->parse_data($info["data"],$info["is_html"]);
$smarty->assign_by_ref('userWiki', $pdata);

$uploads = $elgallib->list_all_user_uploads($_REQUEST['view_user'], 0, 5);
$smarty->assign('arquivos',$uploads);

$userPosts = $bloglib->list_user_posts($_REQUEST['view_user'], 0, 5);
for($i = 0; $i < sizeof($userPosts['data']); $i++) {
	$userPosts['data'][$i]['commentsCount'] = $commentslib->count_comments('post:' . $userPosts['data'][$i]['postId']);
}
$smarty->assign('userPosts', $userPosts);

$smarty->assign('userMessages', $messulib->list_user_messages($_REQUEST['view_user'], 0, 5, 'date_desc', '', '', '', '', 'messages'));

include("tiki-user_information.php");

?>
