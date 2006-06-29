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

$ajaxlib->setPermission('sendMsg', $user && $tikilib->get_user_preference($view_user,'allowMsgs',1));
$ajaxlib->registerFunction('sendMsg');
function sendMsg($subject = '', $body = '', $priority = 3, $cc = '') {
	
	global $messulib, $user, $view_user, $smarty, $permission;
	$messulib->post_message($view_user, $user, $view_user, $cc, $subject, $body, $priority);
	$objResponse = new xajaxResponse();
	
	$smarty->assign('permission', $permission);
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

$ajaxlib->setPermission('set_licenca', $permission);
$ajaxlib->registerFunction('set_licenca');
function set_licenca($r1, $r2, $r3) {
	
	global $userlib, $elgallib;
    
	$objResponse = new xajaxResponse();
	$licencaId = $elgallib->id_licenca($r1, $r2, $r3);
	    
  	$result = $userlib->set_user_field('licencaPadrao', $licencaId);
	if (!$result) {
		$objResponse->addAlert("nao foi possivel definir a licença padrao");
	}
	else {
		$licenca = $elgallib->get_licenca($licencaId);
		$objResponse->addAssign('uLicence', 'src', 'styles/estudiolivre/h_' . $licenca['linkImagem'] . '?rand='.rand());
	}

	return $objResponse;			
}

?>
