<?php

if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

/*
 * Smarty plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     ajax_textarea
 * Purpose:  TODO
 * -------------------------------------------------------------
 * {ajax_input class="gUpTitle" id="titulo" value=$arquivo.titulo default="Titulo"}
 */
function smarty_function_ajax_textarea($params, &$smarty) {
	$id = $params['id'];
	$class = $params['class'];
	$value = $params['value'];
	$default = $params['default'];
	$display = $params['display'];
	
	if (!$display) $display = 'block';
	
	$output = '';
	$output .= '<div id="show-'. $id .'" class="'.$class.'" style="display:' . ($value ? $display : 'none') . '" onClick="editaCampo(' . "'" . $id . "'" . ');">';
	$output .= ($value ? $value : $default);
	$output .= "</div>";
	
	$output .= '<textarea class="'.$class.'" id="input-'.$id. '"  onBlur="saveField(this)" style="display:' . ($value ? "none" : $display) . '" '; 
	if (!$value) { $output .= " onFocus=\"limpaCampo('$id');\" onChange=\"mudado['$id']=1;\""; }
	$output .= '>'. ($value ? htmlspecialchars($value) : $default) .'</textarea>';
	$output .= '<script language="JavaScript">display["'.$id.'"] = "'.$display.'";</script>';		

	return $output;	 	
}

?>
