<?php

require_once("lib/xajax/xajax.inc.php");

$xajax = new xajax();

$xajax->statusMessagesOff();
$xajax->waitCursorOff();
$xajax->debugOff();
$xajax->setLogFile("/tmp/xajax.log");

$xajax->registerFunction('register_tooltip_click');

function register_tooltip_click($tipName) {
	global $tooltiplib;
	
	$tooltiplib->register_user_click($tipName);	
				
	return new xajaxResponse();
}

global $smarty;
$smarty->assign('xajax_js',$xajax->getJavascript());

$xajax->processRequests();

?>
