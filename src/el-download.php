<?

require_once("tiki-setup.php");
require_once("lib/elgal/elgallib.php");

if (!isset($_REQUEST['arquivo']) || $_REQUEST['arquivo'] == 0) {
    $smarty->assign('msg', tra("Arquivo inexistente"));
    $smarty->display("error.tpl");
    die;
}

$arquivo = $elgallib->get_file($_REQUEST['arquivo']);

header('Content-Description: File Transfer');
header('Content-Type: application/force-download');

preg_match("/\d+_\d+-(.+)$/", $arquivo['arquivo'], $nome);

if(isset($_REQUEST['action']) and $_REQUEST['action'] == 'download') {
    header("Content-Disposition: attachment; filename=\"$nome[1]\"");
    $elgallib->add_file_hit($_REQUEST['arquivo']);
}

$fileinfo = stat("repo/$arquivo[arquivo]");
header("Content-length: ".$fileinfo[7]);

session_write_close();
readfile("repo/$arquivo[arquivo]");
exit;

?>
