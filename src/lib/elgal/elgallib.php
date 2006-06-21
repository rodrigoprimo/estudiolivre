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
  var $extension_fields = array("duracao","tipoDoAudio","bpm","sampleRate","bitRate","genero","letra","fichaTecnica","tamanhoImagemX","tamanhoImagemY","temAudio","temCor","idioma","legendas","idiomaLegenda","dpi");
  
  var $licencas = array(0 => array(0 => array(0 => 6,  //Attribution non-comercial no derivatives
					      1 => 5,  //Attribution non-comercial
					      2 => 7), //Attribution non-comercial share-alike
				   1 => 3),            //Sampling plus non-comercial
			1 => array(0 => array(0 => 8,  //Attribution no derivatives
					      1 => 4,  //Attribution
					      2 => 9), //Attribution share-alike
				   1 => 2));           //Sampling plus
						
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
  	  if (!$user) {
  	  	return false;
  	  }
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
		  	  $row['tags'] = $freetaglib->get_tags_on_object($row['arquivoId'], 'gallery');
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

  function validate_filename($tipo, $filename) {

	  // TODO: completar lista
      
	  $types = array();
	  $types['Imagem'] = array('png','jpg','jpeg','gif','tiff','svg','bmp','psd','xcf','eps');
	  $types['Audio'] = array('mp3','ogg','wav','aiff');
	  $types['Video'] = array('mpg','mpeg','avi','ogg','theora','3gp','mp4','yuv','mp2');
	  $types['Texto'] = true;

	  if (!$types[$tipo]) {
	      return "Tipo $tipo invalido"; // nao deve acontecer
	  }
	  if (!is_array($types[$tipo])) {
	      return '';
	  }
	  if (!preg_match('/\.([^.]{3,4})/', $filename, $m)) {
	      return 'Erro: formato de arquivo inválido';
	  }
	  if (in_array($m[1], $types[$tipo])) {
	      return '';
	  } else {
	      return "Erro: formato de arquivo nao suportado";
	  }
    
      
  }
  
  function validate_file($tipo, $filename) {
      
      if($tipo == "Texto")
      	return false;
      
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
    
    $query = "select * from `el_arquivo` where `publicado`=0 and `user`=?";
    $bindvals = array($user);

    $result = $this->query($query, $bindvals);

	$data = array();
    while ($row = $result->fetchRow()) {
      if ($row['arquivo'] || $row['thumbnail'] || $row['editCache']) {
      	if ($row['editCache']) {
      		$row = array_merge($row, unserialize($row['editCache']));
      	}
      	$data[] = $row;
      } else {
      	$this->delete_arquivo($row['arquivoId']);
      }
    }
    return $data;
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

	  if (in_array($obrigatorio['tipo'], array('Audio','Video','Imagem'))) {
        $nomeTipo = strtolower($obrigatorio['tipo']);
        $this->query("insert into `el_arquivo_$nomeTipo` (`arquivoId`) values (?)",Array($id));
      }
      return $id;
    }
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
      
      if (in_array($arquivo['tipo'], array('Audio','Video','Imagem'))) {
	      $table = 'el_arquivo_' . strtolower($arquivo['tipo']);
	      $query = "delete from `$table` where `arquivoId` = ?";
	      $this->query($query,array($arquivoId));
      }
      
      $dir = "repo/";
      if ($arquivo['arquivo'] != "") {
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

	$cache = $this->get_edit_cache($arquivoId);
	
	$cache[$name] = $value;
	
	$this->set_edit_cache($arquivoId, $cache);

  }
  
  function get_edit_cache($arquivoId) {
	$arquivo = $this->get_arquivo($arquivoId);
	$cache = $arquivo['editCache'];
	if (!$cache) {
		$cache = array();
	} else {
		$cache = unserialize($cache);
	}
  	return $cache;
  }
  
  function set_edit_cache($arquivoId, $cache) {
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
  	
  	$tipo = strtolower($arquivo['tipo']);
  	
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
		$queryExt = preg_replace('/, $/', ' where `arquivoId`=?', $queryExt);
		$bindvalsExt[] = $arquivoId;
		if (!$this->query($queryExt, $bindvalsExt)) {
			return false;
		}
	}
	
	if (isset($cache['titulo'])) {
	    $this->query("update `tiki_objects` set `name`=? where `itemId`=? and `type`=?",
			 array($cache['titulo'], $arquivoId, 'gallery'));
	}
	if (isset($cache['descricao'])) {
	    $this->query("update `tiki_objects` set `description`=? where `itemId`=? and `type`=?",
			 array($cache['descricao'], $arquivoId, 'gallery'));
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
  
  function check_required_field($value, $msg = 'Campo obrigatório') {
  	if (preg_match('/^\s*$/',$value)) {
  		return "$msg";
  	}
  }
  
  function check_field_titulo($name) { return $this->check_required_field($name, 'O título é obrigatório');  }
  function check_field_autor($value) { return $this->check_required_field($value, 'O autor é obrigatório');  }
  function check_field_descricao($value) { return $this->check_required_field($value, 'A descrição é obrigatória');  }
  
  function check_numeric_field($value, $msg = 'Campo numérico') {
  	if (!preg_match('/^\d*$/', $value)) {
  		return $msg;
  	}
  }
  
  function check_field_tamanhoImagemX($value) { return $this->check_numeric_field($value, 'Largura deve ser um número'); } 
  function check_field_tamanhoImagemY($value) { return $this->check_numeric_field($value, 'Altura deve ser um número'); } 
  function check_field_dpi($value) { return $this->check_numeric_field($value, 'DPI deve ser um número'); } 
  function check_field_duracao($value) { return $this->check_numeric_field($value, 'Duração deve ser um número'); } 
  function check_field_bpm($value) { return $this->check_numeric_field($value, 'BPM deve ser um número'); } 
  function check_field_sampleRate($value) { return $this->check_numeric_field($value, 'Sample rate deve ser um número'); } 
  function check_field_bitRate($value) { return $this->check_numeric_field($value, 'Bit rate deve ser um número'); } 
   
  
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
    
    if (isset($arquivo['tipo']) && $arquivo['tipo'] != "Texto") {
      $tipo = preg_replace('/[^a-z]/','',$arquivo['tipo']);
      $table = 'el_arquivo_' . strtolower($arquivo['tipo']);
      
      $query = "select * from `$table` where arquivoId=?";
      $result = $this->query($query,array($arquivoId));
      
      $metadata = $result->fetchRow();
      $arquivo = array_merge($metadata, $arquivo);
    }
    return $arquivo;
  }

  function id_licenca($resposta1, $resposta2, $resposta3) {
      $licenca = $this->licencas[$resposta1][$resposta2];
      if (is_array($licenca)) {
	  $licenca = $licenca[$resposta3];
      }
      return $licenca;
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
    $arquivo = $this->get_arquivo($arquivoId);
    if (isset($arquivo['arquivo']) && file_exists($destination.$arquivo['arquivo'])) {
    	unlink($destination.$arquivo['arquivo']);
    }
    if (isset($arquivo['thumbnail']) && file_exists($destination.$arquivo['thumbnail'])) {
    	unlink($destination.$arquivo['thumbnail']);
    }
        
    
    $query = "update `el_arquivo` set `arquivo`=?,`formato`=?,`tamanho`=?,`data_publicacao`=? where `arquivoId`=?";
    $bindvals[] = $arquivoId.'_'.$user.'-'.$file['name'];
    $bindvals[] = $file['type'];
    $bindvals[] = $file['size'];
    $bindvals[] = time();
    $bindvals[] = $arquivoId;

    if(!$this->query($query, $bindvals)) {
      // deu pau
      return "Erro nas informacoes do banco de dados...";
    }
	$path = $destination.$bindvals[0];
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
  	$cache = unserialize($arquivo['editCache']);
  	$errorList = array();
  	
  	foreach ($arquivo as $key => $value) {
  		if (isset($cache[$key])) {
  			$value = $cache[$key];
  		} else {
  			$value = '';
  		}
  		if (!is_array($value)) {
	  		if ($error = $this->check_field($key, $value)) {
  				$errorList[$key] = $error;
  			}
  		}
  	}

  	if (!$arquivo['licencaId']) {
  		$errorList['licenca'] = 'Você deve escolher uma licença';
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

  function get_file_name($id) {
  	$query = "select arquivo from `el_arquivo` where `arquivoId`=?";
    $bindvals = array($id);
    $file_name = $this->getOne($query,$bindvals);
  	preg_match("/\d+_\d+-(.+)\..+$/", $file_name, $ret_name);
  	return $ret_name[1];
  }

  function get_file($id) {
  	// TODO esse methodo nao eh usado, ou entao nao deveria ser.... o get_arquivo faz tudo e melhor.
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
		if ($thumbData) {
			return $this->save_thumb($thumbData, $arquivoId, $user, '.gif');
		}
    }
    elseif ($arquivo['tipo'] == "Imagem") {
		$thumbData = $this->create_thumb_imagem("repo/".$arquivo['arquivo']);
		if ($thumbData) {
			return $this->save_thumb($thumbData, $arquivoId, $user, '.png');
		}
    }
    
    return false;
    
  }
  
  function save_thumb($fileBlob,$arquivoId,$user, $ext) {
      $destination = "repo/";
      
      $arquivo = $this->get_arquivo($arquivoId);

      $fileName = 'thumb_' . $arquivo['arquivo'];
      $fileName = preg_replace('/\.(.+?)$/', $ext, $fileName);
      $path = $destination.$fileName;
      $fp = fopen($path, "w");
      if (!$fp) {
	  	return false;
      }
      fwrite($fp, $fileBlob);
      fclose($fp);
      
      $query = "update `el_arquivo` set `thumbnail`=? where `arquivoId`=?";
      $bindvals = array($fileName,$arquivoId);
      $this->query($query,$bindvals);
      // rolooooowww
      return $fileName;
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
    
    $thumbSide = $this->get_preference('el_thumb_side', 100);
    
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
     
      if (!class_exists('ffmpeg_movie')) {
	  	return false;
      }
      
      //first, get movie and gif info
      $movie = new ffmpeg_movie($path, 0);
      //if error, return false
      if (!is_object($movie)) {
      	return false;
      }

      $width = $movie->getFrameWidth();
      $height = $movie->getFrameHeight();
      $frameTotal = $movie->getFrameCount();
      
      $thumbSide = $this->get_preference('el_thumb_side', 100);
      $thumbVideoSize = $this->get_preference('el_thumb_video_size', 10);
      
      $rate = (int)($frameTotal/$thumbVideoSize);
      $percent = ($width>$height) ? $thumbSide/$width : $thumbSide/$height;
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
  
  
  function extract_file_info($arquivoId) {
  	$arquivo = $this->get_arquivo($arquivoId);
  	$tipo = $arquivo["tipo"];
  	$methodName = 'extract_file_info_' . strtolower($tipo);
  	if (method_exists($this, $methodName)) {
  		
  		$path = "repo/" . $arquivo["arquivo"];
  		return $this->$methodName($path);
  	} else {
  		return array();
  	}
  }
  
  function extract_file_info_imagem($path) {
	$result = array();
	list($result['tamanhoImagemX'], $result['tamanhoImagemY']) = getimagesize($path);
	return $result;
  }

  function extract_file_info_audio($path) {
      if (!class_exists('ffmpeg_movie')) {
	  	return array();
      }
      $audio = new ffmpeg_movie($path, 0);
      //if error, return false
      if (!is_object($audio)) {
      	return array();
      }
      
      $result = array();
      $result['duracao'] = (int)$audio->getDuration();
      $result['bitRate'] = (int)$audio->getBitRate();
      
      return $result;
  }  
  
  function extract_file_info_video($path) {
      if (!class_exists('ffmpeg_movie')) {
	  	return array();
      }
      $movie = new ffmpeg_movie($path, 0);
      //if error, return false
      if (!is_object($movie)) {
      	return array();
      }
      
      $result = array();
      $result['tamanhoImagemX'] = $movie->getFrameWidth();
      $result['tamanhoImagemY'] = $movie->getFrameHeight();
      $result['duracao'] = (int)$movie->getDuration();
      $result['temAudio'] = $movie->hasAudio();
      
      // TODO tem cor ?
      
      return $result;
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

global $elgallib, $dbTiki, $userHasPermOnFile, $arquivoId, $el_p_admin_gallery;
$elgallib = new ELGalLib($dbTiki);

if (isset($_REQUEST['arquivoId'])) {
	$arquivoId = $_REQUEST['arquivoId'];
	$arquivo = $elgallib->get_arquivo($_REQUEST['arquivoId']);
	if ($arquivo['user'] == $user || $el_p_admin_gallery == 'y') {
		$userHasPermOnFile = true;
	} else {
		$userHasPermOnFile = false;
	}		
} else {
	$arquivoId = false;
}
	
?>
