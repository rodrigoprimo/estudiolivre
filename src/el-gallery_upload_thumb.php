<?php

// esse arquivo salva o upload
require_once("tiki-setup.php");
require_once("lib/elgal/elgallib.php");

function error($errorMsg) {
      	echo "<script language=\"javaScript\">alert('".$errorMsg."');</script>";
	exit;
}

if ($arquivoId && isset($_FILES['thumb']) && !empty($_FILES['thumb']['name'])) {

    global $arquivoId;
    
    preg_match("/(.+)\/.+/", $_FILES["thumb"]["type"], $arq_tipo);
    
    if ($arq_tipo[1] != "image") {
	error("O arquivo fornecido não é uma imagem.");
	
    }

    // Were there any problems with the upload?  If so, report here.
    if (!is_uploaded_file($_FILES["thumb"]['tmp_name'])) {
	error(tra('Upload was not successful').': '.ELGalLib::convert_error_to_string($_FILES["thumb"]['error']));
    } 
    
    $maxSize = $tikilib->get_preference('el_max_thumb_size', 200);
    
    if ($_FILES['thumb']["size"] > $maxSize * 1024) {
	error("O tamanho máximo da miniatura é de $maxSize kBytes.");
    }
    
    $handle = fopen($_FILES['thumb']['tmp_name'], "r");
    $thumbData = fread($handle, $_FILES['thumb']['size']);
    fclose($handle);
    
    global $userlib;
    $userId = $userlib->get_user_id($user);
    $error = $elgallib->save_thumb($thumbData,$arquivoId,$userId);
    if ($error) {
	error(tra('Upload was not successful').': '.$error);
    }
    
    $arquivo = $elgallib->get_arquivo($arquivoId);
    echo "<script>parent.document.getElementById('thumbnail').src = 'repo/".$arquivo['thumbnail']."?rand=".rand()."';</script>";
}

?>
