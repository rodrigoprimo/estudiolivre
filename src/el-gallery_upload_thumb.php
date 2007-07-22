<?php

// esse arquivo salva o upload dos thumbnails
require_once("tiki-setup.php");
require_once("lib/filegals/filegallib.php");
include_once("el-gallery_set_publication.php");

function error($errorMsg) {
	global $style, $arquivo;
	echo "<script language=\"javaScript\">alert('".$errorMsg."');</script>";
	echo "<script>parent.document.getElementById('ajax-thumbnail').src = 'styles/" . preg_replace('/\.css/', '', $style) . "/img/iThumb$arquivo->type?rand=".rand()."';</script>";
	exit;
}

if ($arquivoId && isset($_FILES['thumb']) && !empty($_FILES['thumb']['name'])) {

    preg_match("/(.+)\/.+/", $_FILES["thumb"]["type"], $arq_tipo);
    
    if ($arq_tipo[1] != "image") {
		error("O arquivo fornecido não é uma imagem.");
    }

    // Were there any problems with the upload?  If so, report here.
    if (!is_uploaded_file($_FILES["thumb"]['tmp_name'])) {
		error(tra('Upload was not successful').': '.FileGalLib::convert_error_to_string($_FILES["thumb"]['error']));
    } 
    
    $maxSize = $tikilib->get_preference('el_max_thumb_size', 200);

    if ($_FILES['thumb']["size"] > $maxSize * 1024) {
		error("O tamanho máximo da miniatura é de $maxSize kBytes.");
    }
    
    if (preg_match('/(\..+?)$/', $_FILES["thumb"]["name"], $m)) {
		$ext = $m[1];
    } else {
		$ext = ".png";
    } 

    $result = $arquivo->uploadThumb($_FILES["thumb"]['tmp_name'], $_FILES["thumb"]["name"]);
    if (!$result) {
		error(tra('Impossivel gravar miniatura'));
    }
    
    echo "<script>parent.document.getElementById('ajax-thumbnail').src = 'repo/".$arquivo->thumbnail."?rand=".rand()."';</script>";
    
}

?>
