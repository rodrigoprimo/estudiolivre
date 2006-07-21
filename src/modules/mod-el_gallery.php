<?php
//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

/*require_once("lib/elgal/elgallib.php");
$smarty->assign('pendingUploadFiles', $elgallib->list_pending_uploads($user));
*/
?>