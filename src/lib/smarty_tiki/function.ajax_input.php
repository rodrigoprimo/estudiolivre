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
	if (!$display) $display = 'block';
	
	$output = '';
	$output .= '<div class="'.$class.'" style="display:' . ($value ? $display : 'none') . '">';
	$output .= ($value ? $value : $default);
	$output .= "</div>";
	
	$output .= '<input class="'.$class.'" id="input-'.$id.'" value="'. ($value ? escape($value) : $default) .'" ';
	if (!$value) { $output .= " onFocus=\"this.value='';\" "; }
	$output .= " onBlur=\"saveField(this)\" style=\"display:" . ($value ? 'none' : $display) . "\">";
	
	return $output;	 	
}

?>

