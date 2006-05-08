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
$readrepl = "el-gallery_manage.php?action=view&arquivoId=%s";
$uniqueid = $feed;

$changes = array();
$changes["data"] = $elgallib->list_all_uploads(false, 0, 10, $dateId.'_desc');

$output = $rsslib->generate_feed($feed, $uniqueid, '', $changes, $readrepl, $urlparam, $id, $title, $titleId, $desc, $descId, $dateId, $authorId);

header("Content-type: ".$output["content-type"]);
print $output["data"];

?>