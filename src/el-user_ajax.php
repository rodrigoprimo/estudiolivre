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
	
	$objResponse->addAssign("moduleuMsgItems", "innerHTML", $smarty->fetch("el-user_msg.tpl"));
	
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
		$objResponse->addAssign("moduleuMsgItems", "innerHTML", $smarty->fetch("el-user_msg.tpl"));
	
	}
	
	return $objResponse;

}

$ajaxlib->setPermission('markMsgRead', $user);
$ajaxlib->registerFunction('markMsgRead');
function markMsgRead($msgId) {
	
	global $messulib, $user, $smarty, $permission, $view_user;
	
	$objResponse = new xajaxResponse();
	
	if ($permission) {

		$messulib->flag_message($view_user, $msgId, 'isRead', 'y');
		
		$smarty->assign('permission', $permission);
		$smarty->assign('userMessages', $messulib->list_user_messages($view_user, 0, 5, 'date_desc', '', '', '', '', 'messages'));
		$objResponse->addAssign("moduleuMsgItems", "innerHTML", $smarty->fetch("el-user_msg.tpl"));
		include_once("modules/mod-el_msgs.php");
		$objResponse->addAssign("mod-el_msgs", "innerHTML", $smarty->fetch("modules/mod-el_msgs.tpl"));
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

$ajaxlib->setPermission('set_mount_point', $permission);
$ajaxlib->registerFunction('set_mount_point');
function set_mount_point($mountPoint, $pass) {
	global $elgallib, $user, $smarty;
	$objResponse = new xajaxResponse();

	if (!preg_match('/^[a-zA-Z0-9]+$/', $pass) || !preg_match('/^[a-zA-Z0-9]+$/', $mountPoint)) {
		$objResponse->addAssign('ajax-liveError', 'innerHTML', tra('O ponto de montagem e a senha devem ser apenas compostos por letras (sem acento) e numeros, sem espaços.'));
		return $objResponse;
	}
	
	if ($elgallib->getOne('select mountPoint from el_ice where user != ? and mountPoint = ?', array($user, $mountPoint))) {
		$objResponse->addAssign('ajax-liveError', 'innerHTML', tra('Esse ponto de montagem já existe, por favor escolha outro.'));
		return $objResponse;
	}
	
	if ($elgallib->getOne('select mountPoint from el_ice where user = ? and mountPoint = ?', array($user, $mountPoint))) {
		system("./iceWrapper update $mountPoint $pass", $out);
		$action = 'modificado';
	} else {
		system("./iceWrapper add $mountPoint $pass", $out);
		$action = 'criado';
	}
	// se tiver saida = 0, nao deu erro (herdado de shell, porque die no perl retorna 255)
	if (!$out) {
		$elgallib->query("replace into el_ice values(?, ?, ?)", array($user, $mountPoint, $pass));
		$objResponse->addAlert(tra("Seu ponto de transmissão no EstúdioLivre foi $action com sucesso!"));
		$objResponse->addScript("hideLightbox();document.getElementById('ajax-livePoint').value='';document.getElementById('ajax-livePass').value='';");
		$objResponse->addAssign('ajax-liveError', 'innerHTML', '');
		if($action == 'criado') {
			$smarty->assign('channel', array('mountPoint' => $mountPoint, 'password' => $pass));
			$smarty->assign('permission', true);
			$objResponse->addAppend('ajax-liveCont', 'innerHTML', $smarty->fetch('elLiveChannels.tpl'));
		}
	} else {
		$objResponse->addAssign('ajax-liveError', 'innerHTML', tra('Esse ponto de montagem já existe, por favor escolha outro.'));
	}

	return $objResponse;
}

$ajaxlib->setPermission('delete_mount_point', $permission);
$ajaxlib->registerFunction('delete_mount_point');
function delete_mount_point($mountPoint) {
	global $elgallib, $user;
	$objResponse = new xajaxResponse();
	
	if (!$elgallib->getOne('select mountPoint from el_ice where user = ? and mountPoint = ?', array($user, $mountPoint))) {
		return $objResponse;
	}
	
	system("./iceWrapper delete $mountPoint", $out);
	if (!$out) {
		$elgallib->query("delete from el_ice where mountPoint = ?", array($mountPoint));
		$objResponse->addAlert(tra("Seu ponto de transmissão no EstúdioLivre foi removido com sucesso!"));
		$objResponse->addRemove("ajax-live$mountPoint");
	}
	
	return $objResponse;
}

?>
