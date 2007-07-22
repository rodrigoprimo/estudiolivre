<?
//migrado pra 2.0!
require_once("tiki-setup.php");
require_once("lib/persistentObj/PersistentObjectFactory.php");

// compativel com os links antigos
if (isset($_REQUEST['arquivo']) && !isset($_REQUEST['pub'])) {
	$_REQUEST['pub'] = $_REQUEST['arquivo'];
	$_REQUEST['file'] = 0;
}

if (!isset($_REQUEST['pub']) || $_REQUEST['pub'] == 0) {
    $smarty->assign('msg', tra("Publicação inexistente"));
    $smarty->display("error.tpl");
    die;
}

$pub = PersistentObjectFactory::createObject("Publication", (int)$_REQUEST['pub']);

if (isset($_REQUEST['file'])) {
	$file =& $pub->filereferences[(int)$_REQUEST['file']];
	$file->hitDownload();
	$location = $file->fullPath();
} elseif (isset($_REQUEST['action']) && $_REQUEST['action'] == 'downloadAll') {
	if (count($pub->filereferences) == 1) {
		$file =& $pub->filereferences[0];
		$file->hitDownload();
		$location = $file->fullPath();
	} else {
		$fileList = "";
		foreach ($pub->filereferences as $file) {
			$file->hitDownload();
		}
		if (!$pub->allFile) {
			$tarFullPath = $pub->fileDir() . $pub->id . ".tar";
			exec("tar -cf $tarFullPath --exclude thumb* -C repo/ $pub->id", $a, $out);
			if (!$out) $pub->update(array("allFile" => $tarFullPath));
		}
		$location = $pub->allFile;
	}
}

header("location: $location");
exit;

?>
