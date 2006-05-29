<?php

if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

$feature_tooltip = $userlib->get_user_preference($user, 'feature_tooltip', 'y');
$feature_tooltip_max_clicks = $userlib->get_user_preference($user,'feature_tooltip_max_clicks', 5);

$feature_ajax = 'y';

if ($feature_tooltip == 'y') {
	require_once("lib/tooltip/tooltiplib.php");
	require_once("el-tooltip_ajax.php");	
}

?>