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

header('Content-Description: File Transfer');
header('Content-Type: application/force-download');
$file =& $arquivo->filereferences[0];

if(isset($_REQUEST['action']) and $_REQUEST['action'] == 'download') {
    header("Content-Disposition: attachment; filename=\"$file->parseDownloadName()\"");
    $file->hitDownload();
}

$fileinfo = stat($file->fullPath());
header("Content-length: ".$fileinfo[7]);

session_write_close();
readfile($file->fullPath());
exit;

?>
