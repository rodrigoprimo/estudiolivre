<?php

require_once('tiki-setup.php');
require_once('lib/elgal/elIce/IceStats.php');


$iceStats = new IceStats();
$sources = $iceStats->iceinfo('jaime', '8000', 'admin', 'admin');

$smarty->assign('sources', $sources); 
$smarty->assign('mid', 'el-liveInfo.tpl');
$smarty->display('tiki.tpl');

?>