<?php

require_once("tiki-setup.php");
require_once("lib/elgal/elgallib.php");
require_once("lib/ajax/ajaxlib.php");
require_once("el-gallery_ajax.php");

$ajaxlib->processRequests();

$smarty->assign('headtitle', "acervo");
elAddCrumb('acervo');

$smarty->assign('category', 'gallery');

$info = $tikilib->get_page_info('destak');
$pdata = $tikilib->parse_data($info["data"],$info["is_html"]);
$smarty->assign_by_ref('destak', $pdata);

if(isset($_COOKIE['sortMode'])) {
	$sortField = $_COOKIE['sortMode'];
} else {
	$sortField = 'data_publicacao';
}
if(isset($_COOKIE['sortDirection'])) {
	if($_COOKIE['sortDirection'] == '_desc') {
		$smarty->assign('sortDirection', 'Down');
		$sortDirection = '_desc';
	}
	else {
		$smarty->assign('sortDirection', 'Up');
		$sortDirection = '_asc';
	}	
} else {
	$smarty->assign('sortDirection', 'Down');
	$sortDirection = '_desc';	
}
$smarty->assign('sortMode', $sortField);
$sort_mode =  $sortField .  $sortDirection;
$smarty->assign('sort_mode', $sort_mode);

$localTipos = array('Audio', 'Imagem', 'Video', 'Texto');
$tipos = array();
for($i = 0; $i < sizeof($localTipos); $i++) {
	if(isset($_COOKIE[$localTipos[$i]])) {
		if($_COOKIE[$localTipos[$i]] == '1') {
			$tipos[] = $localTipos[$i];
		}
	}
}
if(!sizeof($tipos)) {
	$tipos = $localTipos;
}

if(isset($_REQUEST['highlight'])) {
	$find = $_REQUEST['highlight'];
} else {
	$find = '';
}

$total = $elgallib->count_all_uploads($tipos, '', $find);

$smarty->assign('maxRecords', 10);
$smarty->assign('offset', 0);
$smarty->assign('total', $total);
//$smarty->assign('userName', '');
$smarty->assign('find', $find);
//$smarty->assign('filters', $filters);
$smarty->assign('page', 1);
$smarty->assign('lastPage', ceil($total/10));

$files = $elgallib->list_all_uploads($tipos, 0, 10, $sort_mode, '', $find);
$smarty->assign_by_ref('arquivos',$files);

$smarty->assign('mid', 'el-gallery_home.tpl');
$smarty->display('tiki.tpl');

?>
