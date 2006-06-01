<?php
//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

if( !defined( 'PLUGINS_DIR' ) ) {
	define('PLUGINS_DIR', 'lib/wiki-plugins');
}

require_once("lib/freetag/freetaglib.php");
require_once("lib/commentslib.php");
$commentslib = new Comments($dbTiki);

class ELGalLib extends TikiLib {

  var $basic_fields = array("licencaId","titulo","tipo","user","autor","donoCopyright","descricao","produtora","contato","siteRelacionado","rating","thumbnail");
  var $extension_fields = array("duracao","tipoDoAudio","bpm","sampleRate","bitRate","genero","letra","fichaTecnica","tamanhoImagemX","tamanhoImagemY","temAudio","temCor","idiomaVideo","legendas","idiomaLegenda","dpi");
  
  function ELGalLib($db) {
    if (!$db) {
      die ("Invalid db object passed to WikiLib constructor");
    }
    
    $this->db = $db;
  }
  
  function list_most_downloaded() {
    $query = "select * from el_arquivo where `publicado`=1 order by `hits` desc";
    $result = $this->query($query);
    
    if ($result) {
      $ret = array();
      while ($row = $result->fetchRow()) {
	$ret[] = $row;
      }
      return $ret;
    }
    else {
      return false;
    }
  }
  
  function vote_arquivo($arquivoId, $user, $nota) {
      $this->query("delete from `el_arquivo_rating` where `arquivoId`=? and `user`=?",
		   array($arquivoId, $user));

      $query = "insert into `el_arquivo_rating` (`arquivoId`,`user`,`rating`) values (?,?,?)";
      $bindvals = array($arquivoId, $user, $nota);

      $this->query($query, $bindvals);

      $avg = $this->getOne("select avg(`rating`) from `el_arquivo_rating` where `arquivoId`=?",
			   array($arquivoId));

      $avg = round($avg);

      $this->query("update `el_arquivo` set `rating`=? where `arquivoId`=?",
		   array($avg, $arquivoId));

      return $avg;
  }

  function list_most_voted() {
    $query = "select * from el_arquivo where `publicado`=1 order by `rating` desc";
    $result = $this->query($query);
    
    if ($result) {
      $ret = array();
      while ($row = $result->fetchRow()) {
	$ret[] = $row;
      }
      return $ret;
    }
    else {
      return false;
    }
  }
    
  function list_all_uploads($tipos = array(), $offset = 0, $maxRecords = -1, $sort_mode = 'data_publicacao_desc', $userName = '', $find = '', $filters = array()) {
      
      if ($find) {
		  $mid = " where (a.`titulo` like ? or a.`descricao` like ?) ";
		  $bindvals=array('%'.$find.'%','%'.$find.'%');
      } else {
		  $mid = " where 1=1 ";
		  $bindvals=array();
      }
      
      if ($userName) {
      	$mid .= ' and a.`user` = ? ';
      	$bindvals[] = $userName;
      }

      if ($tipos) {
	    $mid .= ' and a.`tipo` in (';
		foreach($tipos as $tipo) {
			$mid .= '?,';
			$bindvals[] = $tipo;
		}
		//1 eh valor impossivel, hackzinho pra nao ter que fazer regexp pra fechar o in
		$mid .= '"0") ';
      } else {
		return array();
      }

      foreach ($filters as $key => $value) {
		$mid .= " and `$key` like ? ";
		$bindvals[] = '%'.$value.'%';
      }

      $tables = " from `el_arquivo` a, `el_licenca` l ";
      
      $query = "select a.*, a.`titulo` as nomeArquivo, l.`descricao` descricaoLicenca, `linkImagem`, `linkHumanReadable` $tables $mid and a.`licencaId`=l.`licencaId` and `publicado`=1 order by ".$this->convert_sortmode($sort_mode);
      $result = $this->query($query,$bindvals,$maxRecords,$offset);
    
      if ($result) {
		  $ret = array();
		  global $freetaglib, $commentslib;
		  while ($row = $result->fetchRow()) {
		  	  $row['commentsCount'] = $commentslib->count_comments('arquivo:' . $row['arquivoId']);
		  	  $row['tags'] = $freetaglib->get_tags_on_object($row['arquivoId'], 'acervo');
		      $ret[] = $row;
		  }
		  return $ret;
      } else {
		  return false;
      }
  }

  function count_all_uploads($tipos = array(), $user = false, $find = '') {
      $query = "select count(*) from `el_arquivo` where publicado=1";
      $bindvals = array();

	  if ($find) {
		  $query .= " and (`titulo` like ? or `descricao` like ?) ";
		  $bindvals[] = '%'.$find.'%';
		  $bindvals[] = '%'.$find.'%';
      }

	  if ($tipos) {
	    $query .= ' and `tipo` in (';
		foreach($tipos as $tipo) {
			$query .= '?,';
			$bindvals[] = $tipo;
		}
		//1 eh valor impossivel, hackzinho pra nao ter que fazer regexp pra fechar o in
		$query .= '"0") ';
      } else {
      	return 0;
      }

      if ($user) {
		  $query .= " and `user`=?";
		  $bindvals[] = $user;
      }

      return $this->getOne($query, $bindvals);
  }

  function validate_filetype($tipo, $filename) {
  	
  	$mimeType = mime_content_type($filename);
  	
  	if ($mimeType == 'application/ogg' && preg_match("/^Audio|Video$/",$tipo)) {
		$mimeType = strtolower($tipo)."/ogg";		 
    } 
  	
  	preg_match("/(.+)\/.+/", $mimeType, $arqTipo);
  	  	
  	if ($arqTipo[1] == "image") {
		$arqTipo[1] = "imagem";
    } elseif ($arqTipo[1] == "text") {
		$arqTipo[1] = "texto";
    }
    
    if($arqTipo[1] != strtolower($tipo)) {
		return "Você deve fornecer um arquivo do tipo: ".$tipo.", e não do tipo: ".$arqTipo[1];
    }
    
    return false;
    
  }

  function list_pending_uploads($user) {
    $query = "select `arquivoId`, `user`, a.`tipo`, `pontoId`, a.`licencaId`, `publicado`, `data_publicacao`, a.`titulo` `nomeArquivo`, `arquivo`, `formato`, `tamanho`, l.`tipo` `licenca` from `el_arquivo` a left join `el_licenca` l on a.licencaId = l.licencaId where a.publicado=0 and `user`=?";

    $query_cant = "select count(*) from `el_arquivo` where `user`=? and not `publicado`";

    $bindvals = array($user);

    $cant = $this->getOne($query_cant, $bindvals);
    
    $data = array();
    $result = $this->query($query, $bindvals);
    while ($row = $result->fetchRow()) {
      $data[] = $row;
    }
    return array('data' => $data,
		 'cant' => $cant);
  }
  
  function create_arquivo($obrigatorio,$user) {
    $valid_types = array('Video','Audio','Imagem','Texto');
    if (!in_array($obrigatorio['tipo'], $valid_types)) {
      return false;
    }

    $query = "insert into `el_arquivo` (`titulo`,`tipo`,`autor`,`donoCopyright`,`descricao`,`user`) values(?,?,?,?,?,?)";
    $bindvals = array();
    
   	$bindvals[] = $obrigatorio['titulo'];
    $bindvals[] = $obrigatorio['tipo'];
    $bindvals[] = $obrigatorio['autor'];
    $bindvals[] = $obrigatorio['donoCopyright'];
    $bindvals[] = $obrigatorio['descricao'];    
    $bindvals[] = $user;
    $result = $this->query($query, $bindvals);

    if ($result) {
      $query = "select max(`arquivoId`) from `el_arquivo` where `titulo`=? and `tipo`=? and `autor`=? and `donoCopyright`=? and `descricao`=? and `user`=?";
      $id = $this->getOne($query, $bindvals);

      $nomeTipo = strtolower($obrigatorio['tipo']);
      if ($this->query("insert into `el_arquivo_$nomeTipo` (`arquivoId`) values (?)",Array($id))){
	return $id;
      }
    }
    return false;
  }

  function delete_arquivo($arquivoId) {
    $query = "select * from `el_arquivo` where `arquivoId` = ?";
    $result = $this->query($query,array($arquivoId));
    
    if(!$result) {
      return false;
    }
    else { 
      $arquivo = $result->fetchRow();
      $query = "delete from `el_arquivo` where `arquivoId` = ?";
      $this->query($query,array($arquivoId));
      $dir = "repo/";
      if($arquivo['arquivo'] != ""){
	$file = $dir.$arquivo['arquivo'];
	unlink($file);
      }
      return true;
    }
    
  }
  
  
  function edit_field($arquivoId, $name, $value) {
  	if (!in_array($name, $this->basic_fields) && !in_array($name, $this->extension_fields)) {
	    return "campo inexistente";
  	}
  	
  	$error = $this->check_field($name, $value);
	if ($error) return $error;

	$arquivo = $this->get_arquivo($arquivoId);
	$cache = $arquivo['editCache'];
	if (!$cache) {
		$cache = array();
	} else {
		$cache = unserialize($cache);
	}
	
	$cache[$name] = $value;
	
	$query = "update `el_arquivo` set `editCache`=? where `arquivoId`=?";
	$this->query($query, array(serialize($cache),$arquivoId));
  }
  
  function commit($arquivoId) {
  	$arquivo = $this->get_arquivo($arquivoId);
  	if (!$arquivo) return false;
  	$cache = unserialize($arquivo['editCache']);
  	
  	if (!is_array($cache)) {
  		return true;
  	}
  	
  	$tipo = $arquivo['tipo'];
  	
  	$query = "update `el_arquivo` set ";
  	$queryExt = "update `el_arquivo_$tipo` set ";
  	
  	$bindvals = array();
  	$bindvalsExt = array();
  	
  	foreach ($cache as $field => $value) {
  		if (in_array($field, $this->basic_fields)) {
	    	$query .= " `$field` = ?, ";
  			$bindvals[] = $value;
  		} elseif (in_array($field, $this->extension_fields)) {
  			$queryExt .= " `$field` = ?, ";
  			$bindvalsExt[] = $value;
  		}
  	}
  	
  	$query .= "`editCache`='' where `arquivoId`=?";
	$bindvals[] = $arquivoId;
	
	if (!$this->query($query, $bindvals)) {
		return false;
	}
	
	if (sizeof($bindvalsExt)) {
		$queryExt = preg_replace('/, $/', 'where `arquivoId`=?');
		$bindvalsExt[] = $arquivoId;
		if (!$this->query($queryExt, $bindvalsExt)) {
			return false;
		}
	}
	
	if (isset($cache['titulo'])) {
	    $this->query("update `tiki_objects` set `name`=? where `itemId`=? and `type`=?",
			 array($cache['titulo'], $arquivoId, 'acervo'));
	}
	if (isset($cache['descricao'])) {
	    $this->query("update `tiki_objects` set `description`=? where `itemId`=? and `type`=?",
			 array($cache['descricao'], $arquivoId, 'acervo'));
	}
	
	return true;
  }
  
  function rollback($arquivoId) {
  	return $this->query("update `el_arquivo` set `editCache`='' where `arquivoId`=?",array($arquivoId));
  }
  
  function check_field($name, $value) {
  	// verifica dados
  	$methodName = "check_field_" . $name;
  	if (method_exists($this, $methodName)) {
  		$error = $this->$methodName($value);
  		if ($error) return $error;
  	}
  }
  
  function check_required_field($value) {
  	if (preg_match('/^\s*$/',$value)) {
  		return "Campo obrigatório!";
  	}
  }
  
  function check_field_titulo($name) { return $this->check_required_field($name);  }
  function check_field_autor($value) { return $this->check_required_field($value);  }
  function check_field_descricao($value) { return $this->check_required_field($value);  }
  /*
   * 
  function check_field_($value) { return $this->check_required_field($value);  }
  function check_field_($value) { return $this->check_required_field($value);  }
  function check_field_($value) { return $this->check_required_field($value);  }
  function check_field_($value) { return $this->check_required_field($value);  }
  */
  
  function check_numeric_field($value) {
  	if (!preg_match('/^\d*$/', $value)) {
  		return "Campo numérico!";
  	}
  }
  
  function check_field_tamanhoImagemX($value) { return $this->check_numeric_field($value); } 
  function check_field_tamanhoImagemY($value) { return $this->check_numeric_field($value); } 
  function check_field_dpi($value) { return $this->check_numeric_field($value); } 
  function check_field_duracao($value) { return $this->check_numeric_field($value); } 
  function check_field_bpm($value) { return $this->check_numeric_field($value); } 
  function check_field_sampleRate($value) { return $this->check_numeric_field($value); } 
  function check_field_bitRate($value) { return $this->check_numeric_field($value); } 
   
  
  function get_arquivo($arquivoId) {
    $query = "select * from `el_arquivo` where `arquivoId`=?";
    $result = $this->query($query, array($arquivoId));
    
    if (!$result) {
      return false;
    }
    
    $arquivo = $result->fetchRow();
    
    $query = "select * from `el_licenca` where `licencaId`=?";
    $result = $this->query($query,array($arquivo['licencaId']));
    
    $arquivo['licenca'] = $result->fetchRow();
    
    if (isset($arquivo['tipo'])) {
      $tipo = preg_replace('/[^a-z]/','',$arquivo['tipo']);
      $table = 'el_arquivo_' . strtolower($arquivo['tipo']);
      
      $query = "select * from `$table` where arquivoId=?";
      $result = $this->query($query,array($arquivoId));
      
      $metadata = $result->fetchRow();
      $arquivo = array_merge($metadata, $arquivo);
    }
    return $arquivo;
  }
    /*
    Resposta 2
     1 = Sim;
     2 = Não;
     3 = Sim, contanto...;
    */
    function id_licenca($resposta1, $resposta2) {
        if($resposta1 == 1) {
        	switch($resposta2) {
        		case 1:
        			$id_licenca = 6;
        			break;
        		case 2:
        			$id_licenca = 5;
        			break;
        		case 3:
        			$id_licenca = 7;
        			break;
        	}
        } else {
        	switch($resposta2) {
        		case 1:
        			$id_licenca = 8;
        			break;
        		case 2:
        			$id_licenca = 4;
        			break;
        		case 3:
        			$id_licenca = 9;
        			break;
        	}
        }
        return @$id_licenca;
    }

  function set_licenca($arquivoId, $licencaId) {
    $query = "update `el_arquivo` set `licencaId` = ? where `arquivoId` = $arquivoId";
    return $this->query($query,array($licencaId));
  }
  
  function get_licencas() {
    $query = 'select * from `el_licenca`';
    $result = $this->query($query);
    $ret = array();
    while($licenca = $result->fetchRow()) {
      $ret[$licenca['tipo']][] = $licenca;
    }
    $licencas['data'] = $ret;
    return $licencas;
  }
  
  function get_licenca($licencaId) {
	$query = "select * from `el_licenca` where licencaId = $licencaId";
    $result = $this->query($query);
    return $result->fetchRow();
  }
  
  function get_tipos() {
    $query = 'select * from `el_tipos_arquivo`';
    $result = $this->query($query);
    while($tipo = $result->fetchRow()) {
      $ret[] = $tipo;
      
    }
    $tipos['data'] = $ret;
    return $tipos;
  }
  
  function save_file($file,$arquivoId,$user) {
    $destination = "repo/";
    $data = $this->get_arquivo($arquivoId);
    $query = "update `el_arquivo` set `arquivo`=?,`formato`=?,`tamanho`=?,`data_publicacao`=? where `arquivoId`=?";
    $bindvals[] = $arquivoId.'_'.$user.'-'.$file['name'];
    $bindvals[] = $file['type'];
    $bindvals[] = $file['size'];
    $bindvals[] = time();
    $bindvals[] = $arquivoId;

    $path = $destination.$bindvals[0];

    if(!$this->query($query, $bindvals)) {
      // deu pau
      return "Erro nas informacoes do banco de dados...";
    }
    if (move_uploaded_file($file['tmp_name'], $path)) {
        $query = "update `el_arquivo` set `idFisico`=? where `arquivoId`=?";
        $bindvals = array($this->set_id_fisico($arquivoId),$arquivoId);
        $this->query($query,$bindvals);
	// rolooooowww
	return FALSE;
    }
    else {
      // deu pau
      return "impossivel mover o arquivo para: ".$destination;
    }
  }

  function _update_arquivo($dados, $tabela, $id) {

    $query = "update `".$tabela."` set ";
    
    $bindvals = array();
    foreach($dados as $key => $value) {
      if (in_array($key, $this->valid_fields)) {
	$query .= "`$key` = ? ,";
	$bindvals[] = $value;
      }
    }
    $query = substr($query,0,strlen($query)-2);

    $query .= " where `arquivoId` = ?";
    $bindvals[] = $id;
    
    $this->query($query, $bindvals);

  }
    
  function set_metadata($gerais, $especificos, $tipo) {
    
    $this->_update_arquivo($gerais, "el_arquivo", $gerais['arquivoId']);

    $this->_update_arquivo($especificos, "el_arquivo_".$tipo, $gerais['arquivoId']);

  }
  
  function publish_arquivo($arquivoId) {
  	global $user;
  	
  	$this->commit($arquivoId);
  	
  	// TODO permissoes mais complexas, tipo admin
  	// TODO verificar erros
  	$query = "update `el_arquivo` set `publicado`=1 where `arquivoId`=? and `user`=?";
  	$result = $this->query($query, array($arquivoId, $user));
  	return $result;
  }

  function check_publish($arquivoId) {
  	$arquivo = $this->get_arquivo($arquivoId);
  	
  	$errorList = '';
  	
  	
  	foreach ($arquivo as $key => $value) {
  		if (!is_array($value)) {
	  		if ($error = $this->check_field($key, $value)) {
  				$errorList .= $error . "\n";
  			}
  		}
  	}
  	
  	return $errorList;
  	
  }

  function convert_error_to_string($error) {
    switch($error) {
    case 0: //no error; possible file attack!
      return tra("There was a problem with your upload.");
    case 1: //uploaded file exceeds the upload_max_filesize directive in php.ini
    case 2: //uploaded file exceeds the MAX_FILE_SIZE directive that was specified in the html form
      return tra("The file you are trying to upload is too big.");
    case 3: //uploaded file was only partially uploaded
      return tra("The file you are trying to upload was only partially uploaded.");
    case 4: //no file was uploaded
      return tra("You must select a file for upload.");
    default: //a default error, just in case!  :)
      return tra("There was a problem with your upload.");
    }
  }

  function get_file($id) {
    $dir = "repo/";
    $query = "select * from `el_arquivo` where `arquivoId`=?";
    $bindvals = array($id);
    $result = $this->query($query,$bindvals);
    return $result->fetchRow();
  }

  function add_file_hit($id) {
    $query = "update el_arquivo set `hits`=`hits`+1 where `arquivoId`=?";
    $result = $this->query($query,array($id));
  }

  function add_stream_hit($id) {
    $query = "update el_arquivo set `streamHits`=`streamHits`+1 where `arquivoId`=?";
    $result = $this->query($query,array($id));
  }

  function set_id_fisico($arquivoId) {
    $id = "";
    $mes = date("m");
    $ano = date("y");
    $query = "select * from `el_arquivo` where `arquivoId`=?";
    $bindvals = array($arquivoId);
    $result = $this->query($query,$bindvals);
    $row = $result->fetchRow();
    $tipos = array("Video"=>"AV","Audio"=>"A","Imagem"=>"E","Texto"=>"E");
    $pos = array_search($row['tipo'],$tipos);
    if($pos ===false) {
      $id .=$tipos[$row['tipo']]. "-" .$ano. "." .$mes. "." .$row['arquivoId']. "-" .$row['arquivo'];
    }
    return $id;
  }
  
  function generate_thumb($arquivoId) {	
    global $user;
    
    $arquivo = $this->get_arquivo($arquivoId);

    if ($arquivo['tipo'] == "Video") {
		$thumbData = $this->create_thumb_video("repo/".$arquivo['arquivo']);
    }
    elseif ($arquivo['tipo'] == "Imagem") {
		$thumbData = $this->create_thumb_imagem("repo/".$arquivo['arquivo']);
    } else {
		return false;
    }
	
    $this->save_thumb($thumbData, $arquivoId, $user);
  }
  
  function save_thumb($fileBlob,$arquivoId,$user) {
      $destination = "repo/";
      
      $arquivo = $this->get_arquivo($arquivoId);

      $fileName = 'thumb_' . $arquivo['arquivo'];
      $path = $destination.$fileName;
      $fp = fopen($path, "w");
      if (!$fp) {
	  return "Impossivel gravar arquivo!";
      }
      fwrite($fp, $fileBlob);
      fclose($fp);
      
      $query = "update `el_arquivo` set `thumbnail`=? where `arquivoId`=?";
      $bindvals = array($fileName,$arquivoId);
      $this->query($query,$bindvals);
      // rolooooowww
      return FALSE;
  }
    
  function create_thumb_imagem($image) {
    
    $fp = fopen($image, 'rb');
    if (!$fp) return false;
    
    $data = '';
    while (!feof($fp)) {
      $data .= fread($fp, 8192 * 16);
    }
    fclose($fp);
    
    
    if (!function_exists('imagepng')) {
    	return false;
    }
    
    $thumbSide = $this->get_preference('el_thumb_side', 60);
    
    //bloco que acha a proporcao pro thumbnail
    list($width, $height) = getimagesize($image);
	
	if ($width < $thumbSide && $height < $thumbSide) {
		return $data;
	}
	
    
    $sourceX = 0;
    $sourceY = 0;
    $destX = 0;
    $destY = 0;
    $sourceW = $width;
    $sourceH = $height;
    
    // crop normal
    if ($width > $height) {
    	$sourceX = ($width - $height) / 2;
    	$sourceW = $height;
    	
    } elseif ($height > $width) {
    	$sourceY = ($height - $width) / 2;
    	$sourceH = $width;

    }
    
    $destW = $thumbSide;
    $destH = $thumbSide;
	
	// se o lado da imagem eh menor q o thumb
   	if ($height < $thumbSide) {
   		$destY = ($thumbSide - $height) / 2;
   		$destH = $height;
   	}
   	if ($width < $thumbSide) {
   		$destX = ($thumbSide - $width) / 2;
   		$destW = $width;
   	}
    
    
    $src = imagecreatefromstring($data);
    $img = imagecreatetruecolor($thumbSide, $thumbSide);
    
    imagecopyresized($img, $src, $destX, $destY, $sourceX, $sourceY, $destW, $destH, $sourceW, $sourceH);
	
    
    
    ob_start();
    imagepng($img);
    $data = ob_get_contents();
    ob_end_clean();
    
    return $data;
  }
  
  
  function create_thumb_video($path) {
     
      //first, get movie and gif info
      $movie = new ffmpeg_movie($path, 0);
      $width = $movie->getFrameWidth();
      $height = $movie->getFrameHeight();
      $frameTotal = $movie->getFrameCount();
      $rate = (int)($frameTotal/20);
      $percent = ($width>(12/7.5)*$height) ? 120/$width : 75/$height;
      $width = (int)($percent*$width);
      $height = (int)($percent*$height);
      if($width%2 != 0) $width++;
      if($height%2 != 0) $height++;
      $gif = new ffmpeg_animated_gif("/tmp/el-thumb.gif", $width, $height, 1, 0);

      for ($i=1; $i <= $frameTotal; $i+=$rate) {
	  $gif->addFrame($movie->getFrame($i));
      }
      
      $fp = fopen("/tmp/el-thumb.gif", 'rb');
      $data = '';
      while (!feof($fp)) {
	  $data .= fread($fp, 8192 * 16);
      }
      
      global $tikilib;
      $tikilib->blob_encode ($data);
      
      fclose($fp);
      
      return $data;
  }
  
  function new_files($user) {
    
    $last = $this->getOne("select `lastLogin`  from `users_users` where `login`=?",array($user));

    $query = "select count(*) from `el_arquivo` where `data_publicacao` > ?";

    return $this->getOne($query, array((int)$last));

  }
  
  function getUserRating($arquivoId, $userName) {
  	return $this->getOne("select `rating` from `el_arquivo_rating` where `arquivoId`=? and `user`=?", array($arquivoId, $userName));
  }
  
}

global $elgallib;
global $dbTiki;
$elgallib = new ELGalLib($dbTiki);

?>
