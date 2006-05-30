<?
include_once("lib/init/initlib.php");
require_once("tiki-setup.php");
require_once("lib/elgal/elgallib.php");

if (!isset($_REQUEST['arquivo']) || $_REQUEST['arquivo'] == 0) {
    $smarty->assign('msg', tra("Arquivo inexistente"));
    $smarty->display("error.tpl");
    die;
}

$arquivo = $elgallib->get_file($_REQUEST['arquivo']);

// TODO: esse bloco vai sair
if(isset($_REQUEST['thumbnail'])) {
    exit;
    header("Content-type: image/png");
    readfile($arquivo['thumbnail']);
    
}

header("Content-type: ". $arquivo['formato']);

preg_match("/\d+_\d+-(.+)$/", $arquivo['arquivo'], $nome);

if(isset($_REQUEST['action']) and $_REQUEST['action'] == 'download') {
    header("Content-Disposition: attachment; filename=\"$nome[1]\"");
    $elgallib->add_file_hit($_REQUEST['arquivo']);
} else {
	//assume its streaming
    header("Content-Disposition: inline; filename=\"$nome[1]\"");
    $elgallib->add_stream_hit($_REQUEST['arquivo']);
}

$fileinfo = stat("repo/$arquivo[arquivo]");
header("Content-length: ".$fileinfo[7]);

readfile("repo/$arquivo[arquivo]");

?>
