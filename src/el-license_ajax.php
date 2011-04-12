<?php
// migrado pra 2.0!
global $user;

$ajaxlib->setPermission('get_license', $user);
$ajaxlib->register(XAJAX_FUNCTION, 'get_license');
function get_license($r1, $r2, $r3) {
    
    require_once("lib/persistentObj/PersistentObjectController.php");
    
    $controller = new PersistentObjectController("License");
    $objResponse = new xajaxResponse();
    
    $answer = $r1 . $r2;
    if ($r3 != '-1') $answer .= $r3;

    $licenca = $controller->noStructureFindAll(array("answer" => $answer));
    $licenca =& $licenca[0];
	    
    $objResponse->assign('ajax-licenseImg', 'src', 'styles/estudiolivre/h_' . $licenca['imageName'] . '?rand='.rand());
    $objResponse->assign('ajax-licenseDesc', 'innerHTML', $licenca['description']);
    $objResponse->script("show('ajax-licenseCont');");

    return $objResponse;			
}

?>
