<?php

require_once("tiki-setup.php");
require_once("lib/elgal/elgallib.php");

global $arquivoId, $userHasPermOnFile;

if ($arquivoId && $userHasPermOnFile){
	if($elgallib->delete_arquivo($arquivoId)){
		header("location: el-gallery_home.php");
	}
}

?>