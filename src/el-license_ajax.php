<?php

global $user;

$ajaxlib->setPermission('get_license', $user);
$ajaxlib->registerFunction('get_license');
function get_license($r1, $r2, $r3) {
    global $elgallib;
    
    $objResponse = new xajaxResponse();
    $licencaId = $elgallib->id_licenca($r1, $r2, $r3);
	    
    $licenca = $elgallib->get_licenca($licencaId);
    $objResponse->addAssign('licenseImg', 'src', 'styles/estudiolivre/h_' . $licenca['linkImagem'] . '?rand='.rand());
    $objResponse->addAssign('licenseDesc', 'innerHTML', $licenca['descricao']);
    $objResponse->addScript("show('licenseCont');");

    return $objResponse;			
}

?>
