<?php


// esse arquivo salva o upload
require_once ("tiki-setup.php");
require_once ("lib/elgal/elgallib.php");

if ($arquivoId && isset ($_FILES['arquivo']) && !empty ($_FILES['arquivo']['name'])) {

	global $arquivoId;

	if ($_FILES["arquivo"]["type"] == 'application/ogg' && preg_match("/^Audio|Video$/", $_REQUEST['tipo'])) {
		$_FILES["arquivo"]["type"] = strtolower($_REQUEST['tipo']) . "/ogg";
	}

	preg_match("/(.+)\/.+/", $_FILES["arquivo"]["type"], $arq_tipo);

	if ($arq_tipo[1] == "image") {
		$arq_tipo[1] = "imagem";
	}
	elseif ($arq_tipo[1] == "text") {
		$arq_tipo[1] = "texto";
	}
	if ($arq_tipo[1] != strtolower($_REQUEST['tipo'])) {
		$errorMsg = "Você deve fornecer um arquivo do tipo: " . $_REQUEST['tipo'] . ", e nao do tipo: " . $arq_tipo[1];
	} else {
		// Were there any problems with the upload?  If so, report here.
		if (!is_uploaded_file($_FILES["arquivo"]['tmp_name'])) {
			$errorMsg = tra('Upload was not successful') . ': ' . ELGalLib :: convert_error_to_string($_FILES["arquivo"]['error']);
		} else {
			global $userlib;
			$userId = $userlib->get_user_id($user);
			$error = $elgallib->save_file($_FILES["arquivo"], $arquivoId, $userId);
			if ($error) {
				$errorMsg = tra('Upload was not successful') . ': ' . $error;
			}
		}
	}

	if (isset ($errorMsg)) {
		echo "<script language=\"javaScript\">alert('" . $errorMsg . "');</script>";
		exit;
	}

	$arquivo = $elgallib->get_arquivo($arquivoId);
}
?>
