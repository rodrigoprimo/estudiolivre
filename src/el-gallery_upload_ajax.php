<?php
// migrado 2.0!
require_once("dumb_progress_meter.php");
require_once("el-gallery_file_edit_ajax.php");

global $userHasPermOnFile, $arquivoId, $el_p_upload_files;

$ajaxlib->setPermission('newUploadForm', $el_p_upload_files == 'y');
$ajaxlib->registerFunction('newUploadForm');
function newUploadForm($i) {
	global $smarty, $arquivo;
	$objResponse = new xajaxResponse();
	
	$smarty->assign('i', $i);
	$smarty->assign('arquivoId', $arquivo->id);
	
	$objResponse->addScript("uploadI++");
	$objResponse->addAppend('ajax-uploadForms', 'innerHTML', $smarty->fetch("el-gallery_upload_form.tpl"));
	return $objResponse;
}

$ajaxlib->setPermission('create_file', $el_p_upload_files == 'y');
$ajaxlib->registerFunction('create_file');
function create_file($tipo, $fileName) {
	$objResponse = new xajaxResponse();
	global $user, $smarty, $tikilib;
	
	$class = $tipo == "Imagem" ? "Image" : ($tipo == "Texto" ? "Text" : $tipo);
	
	$fileClass = $class . "File";
	$publicationClass = $class . "Publication";
	require_once($fileClass . ".php");
	require_once($publicationClass . ".php");
	
	eval('$error = ' . $fileClass . "::validateExtension('" . $fileName . "');");
	if ($error) {
	    // Estranho ficar aqui, mas onde colocar?
	    $error .= ' Veja a <a href="tiki-index.php?page=Formatos+de+arquivos+do+Acervo+Livre">lista de formatos suportados</a>';
		$objResponse->addScript("setUploadErrorMsg('$error')");
		return $objResponse;
	}
	
	$fields = array("user" => $user);
	if ($licencaId = $tikilib->get_user_preference($user, 'licencaPadrao')) {
		$fields["licenseId"] = $licencaId;
	}
	
	$arquivo = new $publicationClass($fields);
	
	$objResponse->addScriptCall("setPublication", $arquivo->id);
	$objResponse->addScript("newUpload(0);");
	
	if (in_array($tipo, array('Audio','Video','Imagem'))) {
		$templateName = 'el-gallery_metadata_' . $tipo . '.tpl';
		$smarty->assign('permission', true);
		$content = $smarty->fetch($templateName);
		$objResponse->addAppend('ajax-gUpMoreOptionsContent', 'innerHTML', $content);
		$objResponse->addScript(_extractScripts($content));
	}
			
	return $objResponse;
}

$ajaxlib->setPermission('clear_uploaded_file', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('clear_uploaded_file');
function clear_uploaded_file() {
    global $arquivo;
    
    foreach ($arquivo->filereferences as $file)
    	$file->delete();
    if ($arquivo->thumbnail)
    	unlink("repo/" . $arquivo->thumbnail);

    $objResponse = new xajaxResponse();
    $objResponse->addScriptCall("newUpload();");    

    return $objResponse;
}

$ajaxlib->setPermission('delete_file', $el_p_upload_files == 'y');
$ajaxlib->registerFunction('delete_file');
function delete_file($arquivoId) {
	global $user;
	require_once("lib/persistentObj/PersistentObjectFactory.php");
	$arquivo = PersistentObjectFactory::createObject("Publication", (int)$arquivoId);
	$objResponse = new xajaxResponse();
	
	if (!isset($arquivo->user) || $arquivo->user != $user) {
		return $objResponse;
	}
	
	$arquivo->delete();
	
	$objResponse->addRemove("ajax-pendente-$arquivoId");
	
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
$ajaxlib->registerFunction('get_file_info');
function get_file_info() {
	global $tikilib, $arquivo, $user;
	
	$objResponse = new xajaxResponse();

	$file =& $arquivo->filereferences[0];
	
	$result = $file->autoInfos();
	
	// merge com as infos basicas
	$basicInfos = array();
	if (!$arquivo->title)
		$basicInfos['title'] = $file->parseFileName();
	if (($autor = $tikilib->get_user_preference($user, 'realName')) && !$arquivo->author)
		 $basicInfos['author'] = $autor;
	$arquivo->update($basicInfos);

	// deixa o foreach no php, q js eh uma bosta pra isso
	$result = array_merge($result, $basicInfos);
	$formattedResult = array();
	foreach ($result as $key => $value) {
		array_push($formattedResult, $key, $value);
	}
	
	if (sizeOf($result) > 0) {
		$objResponse->addScriptCall('setAutoFields', $formattedResult);
	}
		
	return $objResponse;
}


$ajaxlib->setPermission('set_arquivo_licenca', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('set_arquivo_licenca');
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
	   	if(!$result) $objResponse->addAlert("Não foi possivel editar o campo licencaPadrao");
	}
	
	if (!$arquivo->update(array("licenseId" => $licenca["id"]))) {
		$objResponse->addAlert("Não foi possivel editar o campo licencaId");
	} else {
	  	$objResponse->addAssign('ajax-uImagemLicenca', 'src', 'styles/' . preg_replace('/\.css/', '', $style) . '/img/h_' . $licenca["imageName"] . '?rand='.rand());
	}
		
	return $objResponse;
	
}

function _publish_arquivo() {
    global $arquivo;
    $objResponse = new xajaxResponse();
    
    if ($arquivo->publish()) {
    	$objResponse->addRedirect("el-gallery_view.php?arquivoId=$arquivo->id");
    } else {
    	$objResponse->addAlert("Não foi possível publicar o arquivo");
    }

    return $objResponse;
}

$ajaxlib->setPermission('check_publish', $userHasPermOnFile && $arquivoId);
$ajaxlib->registerFunction('check_publish');
function check_publish($showDisclaimer = true, $dontShowAgain = false) {
    global $user, $userlib, $arquivo, $isIE;
    $objResponse = new xajaxResponse();
	
    if ($errorList = $arquivo->checkPublish()) {
    	$errorMsgs = '';
    	foreach ($errorList as $field => $error) {
    		$errorMsgs .= $error . ($isIE ? "" : "<br/>") . "\n";
    		$objResponse->addScriptCall('exibeErro',$field, $error);
    	}
    	if ($isIE) {
    		$objResponse->addAlert($errorMsgs);
    	} else {
    		$objResponse->addAssign("ajax-gUpErrorList", "innerHTML", $errorMsgs);
    		$objResponse->addScript("showLightbox('ajax-gUpError')");
    	}
    } else {
		if (!$showDisclaimer || $userlib->get_user_preference($user, 'el_disclaimer_seen', false)) {
		    if ($dontShowAgain) {
				global $userlib, $user;
				$userlib->set_user_preference($user, "el_disclaimer_seen", true);
		    }
		    return _publish_arquivo();
		} else {
		    $objResponse->addScript("showLightbox('ajax-el-publish')");
		}
    }
    return $objResponse;    
}

?>
