<?php
/*
 * Created on May 5, 2007
 *
 * by: nano
 */

require_once("lib/persistentObj/PersistentObjectController.php");

global $userHasPermOnFile, $arquivoId, $arquivo, $tiki_p_el_admin_gallery;

$arquivoId = false;
if (isset($_REQUEST['arquivoId'])) {
	$arquivoId = $_REQUEST['arquivoId'];
	$controller = new PersistentObjectController("Publication");
	$arquivo = $controller->findOne(array("id" => $_REQUEST['arquivoId']));
	if ($arquivo) {
		if ($arquivo->user == $user || $tiki_p_el_admin_gallery == 'y') {
			$userHasPermOnFile = true;
		} else {
			$userHasPermOnFile = false;
		}
	}
}

?>
