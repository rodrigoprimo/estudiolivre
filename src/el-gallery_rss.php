<?php

require_once ('tiki-setup.php');
require_once ('lib/tikilib.php');
require_once ('lib/elgal/elgallib.php');
require_once ('lib/rss/rsslib.php');

$feed = "acervo";
$id = "arquivoId";
$title = tra("Feed RSS para o acervo livre");
$desc = "Os 10 arquivos mais novos do acervo livre!";
$now = date("U");
$descId = "descricao";
$dateId = "data_publicacao";
$authorId = "autor";
$titleId = "titulo";
$urlparam = "arquivoId";
$readrepl = "el-gallery_view.php?arquivoId=%s";
$uniqueid = $feed;

if (isset($_REQUEST['user'])) {
	$userName = $_REQUEST['user'];
} else {
	$userName = '';
}

if (isset($_REQUEST['type']) && $_REQUEST['type']) {
	$type = array($_REQUEST['type']);
	$title .= " - " . $_REQUEST['type'];
} else {
	$type = array('Audio', 'Video', 'Imagem', 'Texto');
}

$changes = array();
$changes["data"] = $elgallib->list_all_uploads($type, 0, 10, $dateId.'_desc', $userName);

for ($i=0; $i < sizeof($changes["data"]); $i++) {
	$changes["data"][$i]["enclosure"] = array("url"=>"repo/" . $changes["data"][$i]["arquivo"],
			  	   							  "lenght"=>$changes["data"][$i]["tamanho"],
			       							  "type"=>$changes["data"][$i]["formato"]);
}

$output = $rsslib->generate_feed($feed, $uniqueid, '', $changes, $readrepl, $urlparam, $id, $title, $titleId, $desc, $descId, $dateId, $authorId);

header("Content-type: ".$output["content-type"]);
print $output["data"];

?>