<?php
//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}


/*ISSO NAO FUNCIONOU :( ......
require_once("lib/ajax/ajaxlib.php");
require_once("el-gallery_upload_ajax.php");
require_once("lib/elgal/elgallib.php");
$ajaxlib->processRequests();
$smarty->assign('pendingUploadFiles', $elgallib->list_pending_uploads($user));
*/
?>