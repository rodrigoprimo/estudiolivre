<?php

if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

if (!isset($_SESSION["elBreadCrumbs"])) {
	$_SESSION["elBreadCrumbs"] = array();
}

function elAddCrumb($title) {
	global $userbreadCrumb;
	
	$url = $_SERVER['REQUEST_URI'];
	
	$crumbs = array();
	foreach ($_SESSION["elBreadCrumbs"] as $crumb) {
		if ($crumb['title'] != $title) {
			$crumbs[] = $crumb;
		}
	}
	
	$crumbs[] = array('title' => $title, 'url' => $url);
	
	if (sizeof($crumbs) > $userbreadCrumb) {
		array_shift($crumbs);
	}
	
	$_SESSION["elBreadCrumbs"] = $crumbs;	

}

// isso deveria estar no tiki-index.php e tiki-user_information.php, mas nao queremos mexer lah.
// as outras paginas tratarao adicionarao o seu rastro.
if (isset($_REQUEST['page'])) {
	elAddCrumb($_REQUEST['page']);	
} elseif (isset($_REQUEST['view_user'])) {
	elAddCrumb($_REQUEST['view_user']);
}

$smarty->assign_by_ref("elCrumbs",$_SESSION['elBreadCrumbs']);

?>