<?php


// esse arquivo salva o upload
require_once ("tiki-setup.php");
require_once ("lib/elgal/elgallib.php");

if ($arquivoId && isset($_FILES['arquivo']) && !empty($_FILES['arquivo']['name'])) {

	global $arquivoId;
	$errorMsg = '';

	if (!is_uploaded_file($_FILES["arquivo"]['tmp_name'])) {
			$errorMsg = tra('Upload was not successful') . ': ' . ELGalLib :: convert_error_to_string($_FILES["arquivo"]['error']);
	} else {
		if (!$errorMsg = $elgallib->validate_file($_REQUEST['tipo'], $_FILES["arquivo"]["tmp_name"])) {
			global $userlib;
			$userId = $userlib->get_user_id($user);
			if($error = $elgallib->save_file($_FILES["arquivo"], $arquivoId, $userId)) {
				$errorMsg = tra('Upload was not successful') . ': ' . $error;
			}
		}
	}

	if ($errorMsg) {
		echo "<script language=\"javaScript\">parent.setUploadError('$errorMsg');</script>";
		exit;
	}

	$arquivo = $elgallib->get_arquivo($arquivoId);
}
?>
