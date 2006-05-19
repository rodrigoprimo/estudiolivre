<?php

if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

/*
 * Smarty plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     ajax_input
 * Purpose:  TODO
 * -------------------------------------------------------------
 * {ajax_input class="gUpTitle" id="titulo" value=$arquivo.titulo default="Titulo"}
 */
function smarty_function_ajax_input($params, &$smarty) {
	$id = $params['id'];
	$class = $params['class'];
	$value = $params['value'];
	$default = $params['default'];
	$display = $params['display'];
	$mode = $params['mode'];

	if ($mode == 'edit') {
	    $edit = 1;
	} elseif ($mode == 'show') {
	    $edit = 0;
	} else {
	    $edit = $value ? 0 : 1;
	}
	
	if (!$display) $display = 'block';
	
	$output = '';
	$output .= '<div id="show-'. $id .'" class="'.$class.'" style="display:' . ($edit ? 'none' : $display ) . '" onClick="editaCampo(' . "'" . $id . "'" . ');">';
	$output .= ($edit ? $default : $value);
	$output .= "</div>";
	// TODO: escape value
	$output .= '<input class="'.$class.'" id="input-'.$id.'" value="'. ($value ? $value : $default) .'" ';
	if (!$value) { $output .= " onFocus=\"limpaCampo('$id');\" onChange=\"mudado['$id']=1;\""; }
	$output .= " onBlur=\"saveField(this)\" style=\"display:" . ($edit ? $display : 'none') . "\">";

	$output .= '<script language="JavaScript">display["'.$id.'"] = "'.$display.'";</script>';
	
		
	return $output;	 	
}

?>

