<?php

require_once ('tiki-setup.php');
require_once ('lib/tikilib.php');
require_once ('lib/elgal/elgallib.php');
require_once ('lib/rss/rsslib.php');

$feed = "acervo";
$id = "arquivoId";
$title = tra("Estúdio Livre: Acervo");
$desc = "Os 10 arquivos mais novos do acervo livre!";
$now = date("U");
$descId = "descricao";
$dateId = "data_publicacao";
$authorId = "autor";
$titleId = "titulo";
$urlparam = "arquivoId";
$readrepl = "el-gallery_view.php?arquivoId=%s";
$uniqueid = $feed;

if (isset($_REQUEST['user']) && $_REQUEST['user']) {
	$userName = $_REQUEST['user'];
	$title .= " - ". $userName;
} else {
	$userName = '';
}

if(isset($_REQUEST['types'])) { $_REQUEST['type'] = $_REQUEST['types']; }
if(isset($_REQUEST['tipos'])) { $_REQUEST['type'] = $_REQUEST['tipos']; }
if(isset($_REQUEST['tipo'])) { $_REQUEST['type'] = $_REQUEST['tipo']; }

if (isset($_REQUEST['type']) && $_REQUEST['type']) {
	$type = split(',', $_REQUEST['type']);
	$title .= " (" . $_REQUEST['type'] . ")";
} else {
	$type = array('Audio', 'Video', 'Imagem', 'Texto');
}

if(!isset($_REQUEST['tag']) && isset($_REQUEST['tags'])) { $_REQUEST['tag'] = $_REQUEST['tags']; }

$changes = array();
if (isset($_REQUEST['tag']) && $_REQUEST['tag']) {
	$tagArray = split(",", $_REQUEST['tag']);
	$title .= " - Tags: " . $type;
	$objects = $freetaglib->get_objects_with_tag_combo($tagArray, 'gallery', $userName);
	$changes["data"] = array();
     
    foreach ($objects['data'] as $object) {
		$arquivo = $elgallib->get_arquivo($object['itemId']);
			if (in_array($arquivo['tipo'], $type))
				$changes["data"][] = $arquivo;
    }
}
else {
	$changes["data"] = $elgallib->list_all_uploads($type, 0, 10, $dateId.'_desc', $userName);
}

$base_url = 'http://' . $_SERVER['HTTP_HOST'] .  $_SERVER['REQUEST_URI'];
$base_url = preg_replace('/\/el-gallery_rss.php.*$/','',$base_url);
$base_url .= '/repo/';

for ($i=0; $i < sizeof($changes["data"]); $i++) {
	$changes["data"][$i]["enclosure"] = array("url"=>$base_url . $changes["data"][$i]["arquivo"],
			  	   							  "lenght"=>$changes["data"][$i]["tamanho"],
			       							  "type"=>$changes["data"][$i]["formato"]);
	
	$changes["data"][$i][$descId] = $elgallib->parse_data($changes["data"][$i][$descId]);
	
	if($changes["data"][$i]["thumbnail"]){
		$changes["data"][$i][$descId]='<img src="' . $base_url . $changes["data"][$i]["thumbnail"].'" align="left">'.$changes["data"][$i][$descId];	
	}
}

$output = $rsslib->generate_feed($feed, $uniqueid, '', $changes, $readrepl, $urlparam, $id, $title, $titleId, $desc, $descId, $dateId, $authorId);

header("Content-type: ".$output["content-type"]);
print $output["data"];

?>