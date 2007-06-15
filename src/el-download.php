<?
//migrado pra 2.0!
require_once("tiki-setup.php");
require_once("lib/persistentObj/PersistentObjectFactory.php");

if (!isset($_REQUEST['arquivo']) || $_REQUEST['arquivo'] == 0) {
    $smarty->assign('msg', tra("Arquivo inexistente"));
    $smarty->display("error.tpl");
    die;
}

$arquivo = PersistentObjectFactory::createObject("Publication", (int)$_REQUEST['arquivo']);

$file =& $arquivo->filereferences[0];
$file->hitDownload();

header("location: " . $file->fullPath());
exit;

?>
