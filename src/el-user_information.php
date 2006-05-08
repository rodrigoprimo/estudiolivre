<?php

// Initialization
require_once('tiki-setup.php');
require_once('lib/elgal/elgallib.php');

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

$uploads = $elgallib->list_all_user_uploads($_REQUEST['view_user']);

if ($el_p_view_pendent_files == 'y' || $_REQUEST['view_user'] == $user) {
    $pending = $elgallib->list_pending_uploads($_REQUEST['view_user']);
} else {
    $pending = false;
}

$smarty->assign('all',$uploads);
$smarty->assign('pending',$pending);

include("tiki-user_information.php");

?>
