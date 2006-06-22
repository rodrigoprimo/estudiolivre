<?php

if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

function truncate($string, $max = 0, $rep = '...') {

    if(!$max) {
	return $string;
    }
    
    preg_match_all('/(\&\#\d+;)/', $string, $m);

    $maxOrig = $max;

    if ($m[1] && is_array($m[1])) {
	$i = 0;
	foreach ($m[1] as $bigChar) {
	    if ($i++ == $maxOrig) {
		break;
	    }
	    $max += strlen($bigChar) - 1;
	}
    }

    if(strlen($string) <= $max){
    	return $string;
    }else{
	return substr($string, 0, $max) . $rep;
    }
      
}
?>
