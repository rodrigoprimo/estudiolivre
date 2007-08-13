<?php

// esse arquivo salva o upload
require_once ("tiki-setup.php");

include_once("el-gallery_set_publication.php");

if ($arquivoId && isset($_FILES['arquivo']) && !empty($_FILES['arquivo']['name'])) {

	$errorMsg = '';

	if (!is_uploaded_file($_FILES["arquivo"]['tmp_name'])) {
		require_once ("lib/filegals/filegallib.php");
		$errorMsg = tra('Upload was not successful') . ': ' . FileGalLib :: convert_error_to_string($_FILES["arquivo"]['error']);
	} elseif ($error = FileReference::isForbiddenExtension($_FILES["arquivo"]['name'])) {
		$errorMsg = $error . ' Veja a <a href="tiki-index.php?page=Formatos+de+arquivos+do+Acervo+Livre">lista de formatos suportados</a>';
	}
	else {
		
		require_once("FileReference.php");
		$fileClass = FileReference::getSubClass($_FILES["arquivo"]['name'], $_FILES["arquivo"]['tmp_name']);
		
		$fields = $_FILES["arquivo"];
		$fields["publicationId"] = $arquivoId;
		
		require_once($fileClass . ".php");
		$file = new $fileClass($fields);
		
		if ($arquivo->allFile)
			unlink($arquivo->allFile);
		
		$formNum = $_REQUEST['formNum'];
		echo "<script language=\"javaScript\">parent.finishUpload($formNum);</script>";
	}

	if ($errorMsg) {
		echo "<script language=\"javaScript\">parent.setUploadErrorMsg('$errorMsg');</script>";
	}

}
?>
