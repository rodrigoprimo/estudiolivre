<?php

// esse arquivo salva o upload
require_once ("tiki-setup.php");

include_once("el-gallery_set_publication.php");

if ($arquivoId && isset($_FILES['arquivo']) && !empty($_FILES['arquivo']['name'])) {

	$errorMsg = '';

	if (!is_uploaded_file($_FILES["arquivo"]['tmp_name'])) {
			require_once ("lib/filegals/filegallib.php");
			$errorMsg = tra('Upload was not successful') . ': ' . FileGalLib :: convert_error_to_string($_FILES["arquivo"]['error']);
			if ($errorMsg) {
				echo "<script language=\"javaScript\">parent.setUploadErrorMsg('$errorMsg');</script>";
			}
	} else {
		
		$class = $arquivo->type == "Imagem" ? "Image" : ($arquivo->type == "Texto" ? "Text" : $arquivo->type);
		
		$fileClass = $class . "File";
		require_once($fileClass . ".php");
		
		$fields = $_FILES["arquivo"];
		$fields["publicationId"] = $arquivoId;
		
		$file = new $fileClass($fields);
	}

}
?>
