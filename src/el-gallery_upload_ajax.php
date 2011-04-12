<?php
// migrado 2.0!
require_once("dumb_progress_meter.php");
require_once("el-gallery_file_edit_ajax.php");

global $userHasPermOnFile, $arquivoId, $tiki_p_el_upload_files;

$ajaxlib->setPermission('newUploadForm', $tiki_p_el_upload_files == 'y');
$ajaxlib->register(XAJAX_FUNCTION, 'newUploadForm');
function newUploadForm($i) {
	global $smarty, $arquivo;
	$objResponse = new xajaxResponse();
	
	$smarty->assign('i', $i);
	$smarty->assign('arquivoId', $arquivo->id);
	
	$objResponse->script("uploadI++");
	$objResponse->insertAfter("uploadFormCont" . ($i-1), "span", "uploadFormCont" . $i);
	$objResponse->assign("uploadFormCont" . $i, 'innerHTML', $smarty->fetch("el-gallery_upload_form.tpl"));
	return $objResponse;
}

$ajaxlib->setPermission('create_file', $tiki_p_el_upload_files == 'y');
$ajaxlib->register(XAJAX_FUNCTION, 'create_file');
function create_file($tipo, $fileName, $formNum) {
	$objResponse = new xajaxResponse();
	global $user, $smarty, $tikilib;
	
	$class = $tipo == "Imagem" ? "Image" : ($tipo == "Texto" ? "Text" : ($tipo == "Outro" ? "Other" : $tipo));
	
	$publicationClass = $class . "Publication";
	require_once("FileReference.php");
	require_once($publicationClass . ".php");
	
	if ($error = FileReference::isForbiddenExtension($fileName)) {
	    // Estranho ficar aqui, mas onde colocar?
	    $error .= ' Veja a <a href="tiki-index.php?page=Formatos+de+arquivos+do+Acervo+Livre">lista de formatos suportados</a>';
		$objResponse->script("setUploadErrorMsg('$error')");
		return $objResponse;
	}
	
	$fields = array("user" => $user);
	if ($licencaId = $tikilib->get_user_preference($user, 'licencaPadrao')) {
		$fields["licenseId"] = $licencaId;
	}
	
	$arquivo = new $publicationClass($fields);
	
	$objResponse->call("setPublication", $arquivo->id);
	$objResponse->script("newUpload($formNum);");
	
	if (in_array($tipo, array('Audio','Video','Imagem'))) {
		$templateName = 'el-gallery_metadata_' . $tipo . '.tpl';
		$smarty->assign('permission', true);
		$content = $smarty->fetch($templateName);
		$objResponse->append('ajax-gUpMoreOptionsContent', 'innerHTML', $content);
		$objResponse->script(_extractScripts($content));
	}
			
	return $objResponse;
}

$ajaxlib->setPermission('validateUpload', $userHasPermOnFile && $arquivoId);
$ajaxlib->register(XAJAX_FUNCTION, 'validateUpload');
function validateUpload($fileName, $i) {
	
	$objResponse = new xajaxResponse();
	
	if ($error = FileReference::isForbiddenExtension($fileName)) {
	    // Estranho ficar aqui, mas onde colocar?
	    $error .= ' Veja a <a href="tiki-index.php?page=Formatos+de+arquivos+do+Acervo+Livre">lista de formatos suportados</a>';
		$objResponse->script("setUploadErrorMsg('$error')");
		return $objResponse;
	}

	$objResponse->script("newUpload($i);");
	return $objResponse;

}

$ajaxlib->setPermission('delete_file', $tiki_p_el_upload_files == 'y');
$ajaxlib->register(XAJAX_FUNCTION, 'delete_file');
function delete_file($arquivoId) {
	global $user;
	require_once("lib/persistentObj/PersistentObjectFactory.php");
	$arquivo = PersistentObjectFactory::createObject("Publication", (int)$arquivoId);
	$objResponse = new xajaxResponse();
	
	if (!isset($arquivo->user) || $arquivo->user != $user) {
		return $objResponse;
	}
	
	$arquivo->delete();
	
	$objResponse->remove("ajax-pendente-$arquivoId");
	
	return $objResponse;
}

function _extractScripts($content) {
	preg_match_all('/<script[^>]*>(.+?)<\/script>/', $content, $matches);
	$script = '';
	for ($i=0; $i<sizeof($matches[1]); $i++) {
		$script .= $matches[1][$i];
		$script .= ";\n"; 
	}
	return $script;
}

$ajaxlib->setPermission('get_file_info', $userHasPermOnFile && $arquivoId);
$ajaxlib->register(XAJAX_FUNCTION, 'get_file_info');
function get_file_info() {
	global $tikilib, $arquivo, $user;
	
	$objResponse = new xajaxResponse();

	$file = &$arquivo->filereferences[0];

	$result = array();
	if (!$arquivo->title)
		$result['title'] = $file->parseFileName();
	if (($autor = $tikilib->get_user_preference($user, 'realName')) && !$arquivo->author)
		 $result['author'] = $autor;
	$arquivo->update($result);

	$formattedResult = array();
	foreach ($result as $key => $value) {
		array_push($formattedResult, $key, $value);
	}
	
	if (count($result) > 0) {
		$objResponse->call('setAutoFields', $formattedResult);
	}
		
	return $objResponse;
}


$ajaxlib->setPermission('set_arquivo_licenca', $userHasPermOnFile && $arquivoId);
$ajaxlib->register(XAJAX_FUNCTION, 'set_arquivo_licenca');
function set_arquivo_licenca ($r1, $r2, $r3, $padrao = false) {

    global $userlib, $arquivo, $style;
    require_once("lib/persistentObj/PersistentObjectController.php");
    
    $controller = new PersistentObjectController("License");
    $objResponse = new xajaxResponse();
    
    $answer = $r1 . $r2;
    if ($r3 != '-1') $answer .= $r3;

    $licenca = $controller->noStructureFindAll(array("answer" => $answer));
    $licenca =& $licenca[0];
	
	if ($padrao) {
	  	$result = $userlib->set_user_field('licencaPadrao', $licenca["id"]);
	   	if(!$result) $objResponse->alert("Não foi possivel editar o campo licencaPadrao");
	}
	
	if (!$arquivo->update(array("licenseId" => $licenca["id"]))) {
		$objResponse->alert("Não foi possivel editar o campo licencaId");
	} else {
	  	$objResponse->assign('ajax-uImagemLicenca', 'src', 'styles/' . preg_replace('/\.css/', '', $style) . '/img/h_' . $licenca["imageName"] . '?rand='.rand());
	}
		
	return $objResponse;
	
}

function _publish_arquivo() {
    global $arquivo;
    $objResponse = new xajaxResponse();
    
    if ($arquivo->publish()) {
    	$objResponse->redirect("el-gallery_view.php?arquivoId=$arquivo->id");
    } else {
    	$objResponse->alert("Não foi possível publicar o arquivo");
    }

    return $objResponse;
}

$ajaxlib->setPermission('check_publish', $userHasPermOnFile && $arquivoId);
$ajaxlib->register(XAJAX_FUNCTION, 'check_publish');
function check_publish($showDisclaimer = true, $dontShowAgain = false) {
    global $user, $userlib, $arquivo, $isIE;
    $objResponse = new xajaxResponse();
	
    if ($errorList = $arquivo->checkPublish()) {
    	$errorMsgs = '';
    	foreach ($errorList as $field => $error) {
    		$errorMsgs .= $error . ($isIE ? "" : "<br/>") . "\n";
    		$objResponse->call('exibeErro',$field, $error);
    	}
    	if ($isIE) {
    		$objResponse->alert($errorMsgs);
    	} else {
    		$objResponse->assign("ajax-gUpErrorList", "innerHTML", $errorMsgs);
    		$objResponse->script("showLightbox('ajax-gUpError')");
    	}
    } else {
		if (!$showDisclaimer || $userlib->get_user_preference($user, 'el_disclaimer_seen', false)) {
		    if ($dontShowAgain) {
				global $userlib, $user;
				$userlib->set_user_preference($user, "el_disclaimer_seen", true);
		    }
		    return _publish_arquivo();
		} else {
		    $objResponse->script("showLightbox('ajax-el-publish')");
		}
    }
    return $objResponse;    
}

?>
