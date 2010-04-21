<?php
function pathSeparator() {
	static $separator;
	if (!isset($separator)) {
	    if (strtoupper(substr(PHP_OS, 0, 3)) == 'WIN') {
		$separator = ';';
	    } else {
		$separator = ':';
	    }
	}
	return $separator;
}
    
function prependIncludePath($path) {
	$include_path = ini_get('include_path');
	if ($include_path) {
	    $include_path = $path . pathSeparator(). $include_path;
	} else {
	    $include_path = $path;
	}
	return ini_set('include_path', $include_path);
}

// for persistentObject
prependIncludePath("../src");
prependIncludePath('lib/adodb');

require_once("setup/db.php");

?>
