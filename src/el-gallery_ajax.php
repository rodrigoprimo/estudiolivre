<?php
// migrado pra 2.0!
require_once("lib/persistentObj/PersistentObjectController.php");

global $tiki_p_el_view;

$ajaxlib->setPermission('get_files', $tiki_p_el_view == 'y');
$ajaxlib->register(XAJAX_FUNCTION, "get_files");
function get_files($tipos, $offset, $maxRecords, $sort_mode, $userName = '', $find = '', $filters = array()) {
    global $smarty, $user, $tikilib;

    $objResponse = new xajaxResponse();
	
	$actualClass = array("Video" => "VideoPublication",
						 "Audio" => "AudioPublication",
						 "Imagem" => "ImagePublication",
						 "Texto" => "TextPublication",
					 	 "Outro" => "OtherPublication");
	$filters = array("actualClass" => array());
	foreach ($tipos as $tipo) {
		$filters["actualClass"][] = $actualClass[$tipo];
	}

	if ($userName) {
		$filters["user"] = $userName;
	}
	
	if ($find) {
		$smarty->load_filter('output','highlight');
		$_REQUEST['highlight'] = $find;
		require_once("lib/elgal/model/Find.php");
		$key = new Find(array("title", "description"));
		$filters[$find] = $key;
	}
	$filters["publishDate"] = true;
	$controller = new PersistentObjectController("Publication");
    $files = $controller->findAll($filters, $offset, $maxRecords, $sort_mode);
    $total = $controller->countAll($filters);
    
    $smarty->assign_by_ref('arquivos',$files);
    $smarty->assign('maxRecords', $maxRecords);
    $smarty->assign('offset', $offset);
	$smarty->assign('sort_mode', $sort_mode);
	$smarty->assign('total', $total);
	$smarty->assign('userName', $userName);
	$smarty->assign('find', $find);
	$smarty->assign('filters', $filters);
	$smarty->assign('currentPage', ($offset/$maxRecords)+1);
	$smarty->assign('lastPage', ceil($total/$maxRecords));
	$smarty->assign('dontAskDelete', $tikilib->get_user_preference($user, 'el_dont_check_delete', 0));
	
    

    $objResponse->assign("ajax-listNav", "innerHTML", $smarty->fetch("el-gallery_pagination.tpl"));
    $objResponse->assign("ajax-navBottom", "innerHTML", $smarty->fetch("el-gallery_pagination.tpl"));
    $objResponse->assign("ajax-gListCont", "innerHTML", $smarty->fetch("el-gallery_section.tpl"));
    $objResponse->script("nd()");
    
    return $objResponse;
}

?>
