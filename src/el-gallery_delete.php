<?php

require_once("tiki-setup.php");
require_once("lib/elgal/elgallib.php");

global $arquivoId, $userHasPermOnFile;

if ($arquivoId && $userHasPermOnFile){
	if(isset($_REQUEST['dontAskAgain']) && $_REQUEST['dontAskAgain'] == '1')
		$userlib->set_user_preference($user, "el_dont_check_delete", true);
	if($elgallib->delete_arquivo($arquivoId)){
		header("location: el-gallery_home.php");
	}
}

?>