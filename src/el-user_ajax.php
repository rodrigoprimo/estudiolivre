<?php

require_once("dumb_progress_meter.php");

$ajaxlib->registerFunction('upload_info');
function upload_info($uploadId, $callback = 'updateProgressMeter') {
	$objResponse = new xajaxResponse();
	$uploadInfo = upload_progress_meter_get_info($uploadId);
	$objResponse->addScriptCall($callback,$uploadInfo);
	return $objResponse;
}

$ajaxlib->setPermission('save_field', $permission);
$ajaxlib->registerFunction('save_field');
function save_field($name, $value) {

    global $user, $userlib;

    if (!$user) {
		return false;
    }

	$objResponse = new xajaxResponse();
    
    $result = $userlib->set_user_field($name, $value);
    
    if(!$result) {
		$objResponse->addAlert("nao foi possivel editar o campo $name");
    } else {
		$objResponse->addScriptCall('exibeCampo', $name, $value);
    }
	
	return $objResponse;

}

$ajaxlib->setPermission('sendMsg', $user);
$ajaxlib->registerFunction('sendMsg');
function sendMsg($subject = '', $body = '', $priority = 3, $cc = '') {
	
	global $messulib, $userwatch, $user, $view_user, $smarty;
	$messulib->post_message($userwatch, $user, $view_user, $cc, $subject, $body, $priority);
	$objResponse = new xajaxResponse();
	$smarty->assign('userMessages', $messulib->list_user_messages($view_user, 0, 5, 'date_desc', '', '', '', '', 'messages'));
	$objResponse->addAssign("uMsgItems", "innerHTML", $smarty->fetch("el-user_msg.tpl"));
	
	return $objResponse;

}

$ajaxlib->setPermission('delMsg', $user);
$ajaxlib->registerFunction('delMsg');
function delMsg($userFrom, $msgId) {
	
	global $messulib, $user, $smarty, $permission, $view_user;
	
	$objResponse = new xajaxResponse();
	
	if ($permission || $user == $userFrom) {

		$messulib->delete_message($view_user, $msgId);
		
		$smarty->assign('permission', $permission);
		$smarty->assign('userMessages', $messulib->list_user_messages($view_user, 0, 5, 'date_desc', '', '', '', '', 'messages'));
		$objResponse->addAssign("uMsgItems", "innerHTML", $smarty->fetch("el-user_msg.tpl"));
	
	}
	
	return $objResponse;

}

?>
