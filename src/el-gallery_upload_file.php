<?php

// esse arquivo salva o upload
require_once("tiki-setup.php");
require_once("lib/elgal/elgallib.php");

if (isset($_REQUEST['arquivoId']) && isset($_FILES['arquivo']) && !empty($_FILES['arquivo']['name'])) {

    $arquivoId = $_REQUEST['arquivoId'];
    
    if ($_FILES["arquivo"]["type"] == 'application/ogg' &&
	preg_match("/^Audio|Video$/",$_REQUEST['tipo'])) {
		$_FILES["arquivo"]["type"] = strtolower($_REQUEST['tipo'])."/ogg";		 
    } 
    
    preg_match("/(.+)\/.+/", $_FILES["arquivo"]["type"], $arq_tipo);
    
    if ($arq_tipo[1] == "image") {
	$arq_tipo[1] = "imagem";
    } elseif ($arq_tipo[1] == "text") {
	$arq_tipo[1] = "texto";
    }
    if($arq_tipo[1] != strtolower($_REQUEST['tipo'])) {
		$errorMsg = "Você deve fornecer um arquivo do tipo: ".$_REQUEST['tipo'].", e nao do tipo: ".$arq_tipo[1];
    }
    else {
		// Were there any problems with the upload?  If so, report here.
		if (!is_uploaded_file($_FILES["arquivo"]['tmp_name'])) {
		    $errorMsg = tra('Upload was not successful').': '.ELGalLib::convert_error_to_string($_FILES["arquivo"]['error']);
		} 
		else {
		    global $userlib;
		    $userId = $userlib->get_user_id($user);
		    $error = $elgallib->send_file($_FILES["arquivo"],$arquivoId,$userId);
		    if ($error) {
			$errorMsg = tra('Upload was not successful').': '.$error;
		    }
		}
    }
    
    if ($errorMsg) {
    	echo "<script language=\"javaScript\">alert('".$errorMsg."');</script>";
	exit;
    }

    if ($_REQUEST['tipo'] == "Video") {
	$gif = $elgallib->create_anim_gif("repo/".$_REQUEST['arquivo']);
	$thumbData = $gif;
    }
    elseif ($_REQUEST['tipo'] == "Imagem") {
	$thumbData = $elgallib->generate_thumbnail("repo/".$_REQUEST['arquivo']);
    } else {
	exit;
    }

    $elgallib->edit_field($arquivoId, 'thumbnail', $thumbData);
    echo "<script>alert(".strlen($thumbData).")</script>";exit;
    echo "<script>parent.document.getElementById('thumbnail').src = 'el-download.php?arquivo=$arquivoId&thumbnail=1';</script>";
}

?>
