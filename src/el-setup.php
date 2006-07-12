<?php

if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

ini_set('session.cache_expire',     200000);
ini_set('session.cache_limiter',    'none');
ini_set('session.cookie_lifetime',  2000000);
ini_set('session.gc_maxlifetime',   200000);
ini_set('session.save_handler',     'user');
ini_set('session.use_only_cookies', 1);
ini_set('session.use_trans_sid',    0);

$feature_tooltip = $userlib->get_user_preference($user, 'feature_tooltip', 'y');
$feature_tooltip_max_clicks = $userlib->get_user_preference($user,'feature_tooltip_max_clicks', 5);

if ($feature_tooltip == 'y') {
	require_once("lib/tooltip/tooltiplib.php");
	require_once("el-tooltip_ajax.php");	
}

require_once("el-gallery_stream_ajax.php");

require_once("el-breadcrumbs.php");


$isIE = preg_match('/MSIE/', $_SERVER['HTTP_USER_AGENT']) && !preg_match('/Opera/', $_SERVER['HTTP_USER_AGENT']);
$smarty->assign('isIE',$isIE);

// TODO: Fazer ieGIF2PNG q substitui o {if $isIE}gif{else}png{/if}

?>
