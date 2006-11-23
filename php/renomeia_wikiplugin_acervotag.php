<?php

require_once("tiki-setup.php");

$result = $tikilib->query("select pageName, data from tiki_pages where data like '%ACERVOTAG%'");

while ($row = $result->fetchRow()) {
    $row['data'] = preg_replace('/ACERVOTAG/','ACERVO',$row['data']);
    $tikilib->query("update tiki_pages set data=? where pageName=?",
		    array($row['data'], $row['pageName']));
}

?>