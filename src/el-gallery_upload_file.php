<?php

// esse arquivo salva o upload
require_once ("tiki-setup.php");

include_once("el-gallery_set_publication.php");

if ($arquivoId && isset($_FILES['arquivo']) && !empty($_FILES['arquivo']['name'])) {

	$errorMsg = '';

	if (!is_uploaded_file($_FILES["arquivo"]['tmp_name'])) {
		require_once ("lib/filegals/filegallib.php");
		$errorMsg = tra('Upload was not successful') . ': ' . FileGalLib :: convert_error_to_string($_FILES["arquivo"]['error']);
	} elseif ($error = FileReference::validateExtension($_FILES["arquivo"]['name'])) {
		$errorMsg = $error . ' Veja a <a href="tiki-index.php?page=Formatos+de+arquivos+do+Acervo+Livre">lista de formatos suportados</a>';
	}
	else {
		
		require_once("AudioFile.php");
		require_once("ImageFile.php");
		require_once("VideoFile.php");
		require_once("TextFile.php");
		if (!AudioFile::validateExtension($_FILES["arquivo"]['name']))
			$fileClass = "AudioFile";
		elseif (!ImageFile::validateExtension($_FILES["arquivo"]['name']))
			$fileClass = "ImageFile";
		elseif (!VideoFile::validateExtension($_FILES["arquivo"]['name']))
			$fileClass = "VideoFile";
		else
			$fileClass = "TextFile";
		
		$fields = $_FILES["arquivo"];
		$fields["publicationId"] = $arquivoId;
		
		$file = new $fileClass($fields);
		
		if ($arquivo->allFile)
			unlink($arquivo->allFile);
	}

	if ($errorMsg) {
		echo $errorMsg;exit;
		echo "<script language=\"javaScript\">parent.setUploadErrorMsg('$errorMsg');</script>";
	}

}
?>
