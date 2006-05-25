<?php

if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

function truncate($substring, $max = 0, $rep = '...') {
	
	if(!$max) {
		return $substring;
	} 

	if(strlen($substring) < 1){
    	$string = $rep;
    }else{
    	$string = $substring;
    }
      
    $leave = $max - strlen ($rep);
      
    if(strlen($string) > $max){
    	return substr_replace($string, $rep, $leave);
    }else{
    	return $string;
    }
      
}
?>