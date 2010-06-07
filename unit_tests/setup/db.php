<?php

define('ADODB_FORCE_NULLS', 1);
define('ADODB_ASSOC_CASE', 2);
define('ADODB_CASE_ASSOC', 2); 

include_once ('adodb.inc.php');
include_once ('adodb-pear.inc.php');

$ADODB_FETCH_MODE = ADODB_FETCH_ASSOC;

$db_type = 'mysql';
$db_host = 'localhost';
$db_user = 'root';
$db_pass = '';
$db_name = 'tests';

$dsn = "$db_type://$db_user:$db_pass@$db_host/$db_name";

$tikilib = &ADONewConnection($db_type);

if (!@$tikilib->Connect($db_host, $db_user, $db_pass, $db_name)) {
    print "Error connecting to database:\n";
    print $tikilib->ErrorMsg();
    exit;
}

?>
