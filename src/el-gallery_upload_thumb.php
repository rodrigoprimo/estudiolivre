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
	error("O arquivo fornecido nC#o C) uma imagem.");
	
    }

    /*    ob_start();
    print_r($_FILES);
    $saida = ob_get_contents();
    ob_end_clean();
    error($saida);*/

    // Were there any problems with the upload?  If so, report here.
    if (!is_uploaded_file($_FILES["thumb"]['tmp_name'])) {
	error(tra('Upload was not successful').': '.ELGalLib::convert_error_to_string($_FILES["thumb"]['error']));
    } 
    
    $maxSize = $tikilib->get_preference('el_max_thumb_size', 200);

    if ($_FILES['thumb']["size"] > $maxSize * 1024) {
	error("O tamanho mC!ximo da miniatura C) de $maxSize kBytes.");
    }
    
    if (preg_match('/(\..+?)$/', $_FILES["thumb"]["name"], $m)) {
	$ext = $m[1];
    } else {
	$ext = ".png";
    } 

    $handle = fopen($_FILES['thumb']['tmp_name'], "r");
    $thumbData = fread($handle, $_FILES['thumb']['size']);
    fclose($handle);
    
    global $userlib;
    $userId = $userlib->get_user_id($user);
    
    $result = $elgallib->save_thumb($thumbData, $arquivoId, $userId, $ext);
    if (!$result) {
	error(tra('Impossivel gravar miniatura'));
    }
    
    $arquivo = $elgallib->get_arquivo($arquivoId);
    echo "<script>parent.document.getElementById('thumbnail').src = 'repo/".$arquivo['thumbnail']."?rand=".rand()."';</script>";
}

?>
