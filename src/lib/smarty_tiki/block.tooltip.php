<?php

if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

/*
 * Smarty plugin
 * -------------------------------------------------------------
 * Type:     block
 * Name:     tooltip
 * Purpose:  Show tooltip when user passes mouse over an element, 
 * depending on user preferences  
  
 * -------------------------------------------------------------
 */
function smarty_block_tooltip($params, $text) {
 	$tip = tra($params['text']);
 	$tipName = $params['name'];
 	
 	global $tooltiplib, $feature_tooltip, $feature_tooltip_max_clicks;
 	
	if (!$tipName) {
	    $tipName = md5($tip);
	}

	// TODO: refatorar essa __*MERDA*__ HORRIVEL!!!
	// foi feito para que os módulos (mod-*.tpl) funcionem. mas é feio de doer.
	if(!$tooltiplib){
		if(!$userlib){
			$dbTiki = &ADONewConnection($db_tiki);
			$userlib = new UsersLib($dbTiki);
		}
		$feature_tooltip = $userlib->get_user_preference($user, 'feature_tooltip', 'y');
		$feature_tooltip_max_clicks = $userlib->get_user_preference($user,'feature_tooltip_max_clicks', 5);
		require_once("lib/tooltip/tooltiplib.php");
		require_once("el-tooltip_ajax.php");	
	}
 	$clicks = $tooltiplib->get_user_clicks($tipName);
 	
 	if ($feature_tooltip == 'y' && ($clicks <= $feature_tooltip_max_clicks || !$feature_tooltip_max_clicks)) {
 		$text = "<span onMouseover=\"tooltip('".tra($tip)."');\" onMouseout=\"nd();\" onMousedown=\"xajax_register_tooltip_click('$tipName');\">".$text."</span>";
 	}
 	return $text;
}

?>
