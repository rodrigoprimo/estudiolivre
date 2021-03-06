<?php
// migrado pra 2.0!
require_once ('tiki-setup.php');
require_once ('lib/tikilib.php');
require_once ('lib/persistentObj/PersistentObjectController.php');
require_once ('lib/persistentObj/PersistentObjectFactory.php');
require_once ('lib/rss/rsslib.php');
require_once ('lib/freetag/freetaglib.php');

$feed = "acervo";
$id = "id";
$title = tra("Estúdio Livre: Acervo");
$desc = "Os últimos arquivos do acervo livre!";
$now = date("U");
$descId = "description";
$dateId = "publishDate";
$authorId = "author";
$titleId = "title";
$urlparam = "id";
$itemurl = "el-gallery_view.php?arquivoId=%s";

$filters = array();
if (isset($_REQUEST['user']) && $_REQUEST['user']) {
	$userName = $_REQUEST['user'];
	$filters["user"] = $userName;
} else {
	$userName = '';
}

if(isset($_REQUEST['max'])) {
	if ($_REQUEST['max'] == '0') {
		$maxRecords = -1;
	} else {
		$maxRecords = (int)$_REQUEST['max'];
	}
} else {
	$maxRecords = 10;
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

$actualClass = array("Video" => "VideoPublication",
					 "Audio" => "AudioPublication",
					 "Imagem" => "ImagePublication",
					 "Texto" => "TextPublication");
$filters["actualClass"] = array();
foreach ($type as $tipo) {
	$filters["actualClass"][] = $actualClass[$tipo];
}
$filters["publishDate"] = true;

if(!isset($_REQUEST['tag']) && isset($_REQUEST['tags'])) { $_REQUEST['tag'] = $_REQUEST['tags']; }

$files = array();
if (isset($_REQUEST['tag']) && $_REQUEST['tag']) {
	$tagArray = split(",", $_REQUEST['tag']);
	$title .= " - Tags: " . $_REQUEST['tag'];

	$objects = $freetaglib->get_objects_with_tag_combo($tagArray, 'gallery', $userName);

    foreach ($objects['data'] as $object) {
		$arquivo = PersistentObjectFactory::createObject("Publication", (int)$object['itemId']);
		if (in_array($arquivo->type, $type))
			$files[] = $arquivo;
    }
} else {
	$controller = new PersistentObjectController("Publication");
	$files = $controller->findAll($filters, 0, $maxRecords, $dateId.'_desc');
}

$uniqueid = $feed . $userName . $maxRecords . implode('', $type);

$changes = array();
$changes["data"] = array();
for ($i=0; $i < sizeof($files); $i++) {
	
    if (sizeof($files[$i]->filereferences)) {
	$arquivo = array();
	
	$file =& $files[$i]->filereferences[0];
	// TODO: devem haver outros casos de nome de arquivo invalido alem de
	// 		 nomes de arquivo com espacos
	$arquivo["sefurl"] = str_replace(' ', '+', $file->fullPath());
	$arquivo["filesize"] = $file->size;
	$arquivo["filetype"] = $file->mimeType;
	
	$arquivo[$descId] = $tikilib->parse_data($files[$i]->$descId);
	
	if($files[$i]->thumbnail){
		$arquivo[$descId]='<img src="' . $base_url . $files[$i]->fileDir() . $files[$i]->thumbnail.'" align="left">'.$arquivo[$descId];	
	}
	
	$arquivo["id"] = $files[$i]->id;
	$arquivo["author"] = $files[$i]->author;
	$arquivo["title"] = $files[$i]->title;
	$arquivo["publishDate"] = $files[$i]->publishDate;
	
	$changes["data"][] = $arquivo;
    }
	
}

$output = $rsslib->generate_feed($feed, $uniqueid, '', $changes, $itemurl, $urlparam, $id, $title, $titleId, $desc, $descId, $dateId, $authorId);

header("Content-type: ".$output["content-type"]);
print $output["data"];

?>