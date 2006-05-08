<?
include_once("lib/init/initlib.php");
require_once("tiki-setup_base.php");
require_once("lib/elgal/elgallib.php");

if (!isset($_REQUEST['arquivo']) || $_REQUEST['arquivo'] == 0) {
    $smarty->assign('msg', tra("You are not logged in"));
    $smarty->display("error.tpl");
    die;
}
     
$arquivo = $elgallib->get_file($_REQUEST['arquivo']);

if(isset($_REQUEST['thumbnail'])) {
    header("Content-type: image/png");
    print($arquivo['thumbnail']);
    exit;
}

header("Content-type: $arquivo[formato]");
preg_match("/\d+_\d+-(.+)$/", $arquivo['arquivo'], $nome);
//$nome[1] = preg_replace("/\s/", "%20", $nome[1]);
if(isset($_REQUEST['action']) and $_REQUEST['action'] == 'download') {
    header("Content-Disposition: attachment; filename=\"$nome[1]\"");
    $elgallib->add_file_hit($_REQUEST['arquivo']);
} else {
    header("Content-Disposition: inline; filename=\"$nome[1]\"");
}

$fileinfo = stat("repo/$arquivo[arquivo]");
header("Content-length: ".$fileinfo[7]);

readfile("repo/$arquivo[arquivo]");

?>