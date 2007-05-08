<?php
/*
 * Created on May 5, 2007
 *
 * by: nano
 */

require_once("lib/persistentObj/PersistentObjectFactory.php");

global $userHasPermOnFile, $arquivoId, $arquivo, $el_p_admin_gallery;

if (isset($_REQUEST['arquivoId'])) {
	$arquivoId = $_REQUEST['arquivoId'];
	$arquivo = PersistentObjectFactory::createObject("Publication", (int)$_REQUEST['arquivoId']);
	if ($arquivo->user == $user || $el_p_admin_gallery == 'y') {
		$userHasPermOnFile = true;
	} else {
		$userHasPermOnFile = false;
	}		
} else {
	$arquivoId = false;
}

?>
