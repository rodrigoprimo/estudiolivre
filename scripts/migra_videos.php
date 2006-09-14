<?

require_once("tiki-setup.php");
require_once("lib/elgal/elgallib.php");

$fp = fopen("/noe/data/vhost/estudiolivre.org/htdocs/videos/videos.info", "r");

if (!$fp) {
    print "nao abriu arquivo"; exit;
}

while ($line = rtrim(fgets($fp), "\n")) {
    $info = preg_split('/\t/',$line);
    
    $fileName = $info[0];
    $filePath = $info[1];
    $thumbName = $info[2];
    $thumbPath = $info[3];
    $title = utf8_encode($info[4]);
    $dir = $info[5];
    $user = $info[6];

    $arquivo = array('tipo' => 'Video',
		     'titulo' => $title,
		     'autor' => 'Equipe Cultura Digital',
		     'donoCopyright' => '',
		     'descricao' => '');

    $arquivoId = $elgallib->create_arquivo($arquivo, $user);

    $fileName = $arquivoId . '_' . $user . '-' . $fileName;
    if (!empty($thumbName)) {
	$thumbName = 'thumb_' . $arquivoId . '_' . $user . '-' . $thumbName;
    }

    $valid_ext = array('mpg','ogg','avi');

    $ext = preg_replace('/^.+\./','',$fileName);
    if (in_array($ext, $valid_ext)) {
	if ($ext == 'mpg') $ext = 'mpeg';
	$fileType = "video/$ext";
    } else {
	$fileType = "video"; // verificar qtos tem isso
    }

    $fileTime = time();
    $fileSize = 0;
    if (file_exists($filePath)) {
	$info = stat($filePath);
	$fileSize = $info[7];
	$fileTime = $info[9];
    }

    $bindvals = array();
    $query = "update `el_arquivo` set `arquivo`=?, `thumbnail`=?, `formato`=?, `tamanho`=?, `data_publicacao`=?, `licencaId`=?, `publicado`=1 where `arquivoId`=?";
    $bindvals[] = $fileName;
    $bindvals[] = $thumbName;
    $bindvals[] = $fileType;
    $bindvals[] = $fileSize;
    $bindvals[] = $fileTime;
    $bindvals[] = 7;
    $bindvals[] = $arquivoId;

    $elgallib->query($query, $bindvals);

    $tag = '';
    if ($dir) {
	$tag .= $dir . ', ';
    }
    $tag .= "migrado da pasta videos";
    $elgallib->tag_arquivo($arquivoId, $tag);

    print("ln $filePath repo/$fileName\n");
    if ($thumbPath) {
	print("ln $thumbPath repo/$thumbName\n");
    }
}

?>
