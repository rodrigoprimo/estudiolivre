<?php

require_once("el-gallery_stream_ajax.php");

global $el_p_view;

$ajaxlib->setPermission('get_files', $el_p_view == 'y');
$ajaxlib->registerFunction("get_files");
function get_files($tipos, $offset, $maxRecords, $sort_mode, $userName = '', $find = '', $filters = array()) {
    global $elgallib, $smarty, $user;

    $objResponse = new xajaxResponse();
	$total = $elgallib->count_all_uploads($tipos, $userName, $find);

    $files = $elgallib->list_all_uploads($tipos, $offset, $maxRecords, $sort_mode, $userName, $find, $filters);
    $smarty->assign_by_ref('arquivos',$files);
    $smarty->assign('maxRecords', $maxRecords);
    $smarty->assign('offset', $offset);
	$smarty->assign('sort_mode', $sort_mode);
	$smarty->assign('total', $total);
	$smarty->assign('userName', $userName);
	$smarty->assign('find', $find);
	$smarty->assign('filters', $filters);
	$smarty->assign('page', ($offset/$maxRecords)+1);
	$smarty->assign('lastPage', ceil($total/$maxRecords));
	$smarty->assign('dontAskDelete', $elgallib->get_user_preference($user, 'el_dont_check_delete', 0));
	
    if ($find) {
		$smarty->load_filter('output','highlight');
		$_REQUEST['highlight'] = $find;
	}

	$objResponse->addAssign("ajax-listNav", "innerHTML", $smarty->fetch("el-gallery_pagination.tpl"));
    $objResponse->addAssign("ajax-gListCont", "innerHTML", $smarty->fetch("el-gallery_section.tpl"));
    $objResponse->addScript("nd()");
    //$objResponse->addScript("acervoCache('$tiposHr', $offset, $maxRecords, '$sort_mode', '$find', '$filtersHr')");
    
    return $objResponse;
}

?>
