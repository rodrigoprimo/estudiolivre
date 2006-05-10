<?php
//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

if( !defined( 'PLUGINS_DIR' ) ) {
	define('PLUGINS_DIR', 'lib/wiki-plugins');
}

class ELGalLib extends TikiLib {

  var $valid_fields = array("album","thumbnail","licencaId","titulo","tipo","user","autor","donoCopyright","descricao","produtora","contato","siteRelacionado","iSampled","sampledMe","rating","duracao","tipoDoAudio","bpm","sampleRate","bitRate","genero","letra","fichaTecnica","tamanhoImagemX","tamanhoImagemY","temAudio","temCor","idiomaVideo","legendas","idiomaLegenda","dpi");

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
    
  function list_all_uploads($tipos = array(), $offset = 0, $maxRecords = -1, $sort_mode = 'data_publicacao_desc', $find = '', $filters = array()) {
      global $user;
      if ($find) {
	  $mid = " where (a.`titulo` like ? or a.`descricao` like ?) ";
	  $bindvals=array('%'.$find.'%','%'.$find.'%');
      } else {
	  $mid = " where 1=1 ";
	  $bindvals=array();
      }

      if ($tipos) {
	  $mid .= ' and a.`tipo` in (';
		foreach($tipos as $tipo) {
			$mid .= '?,';
			$bindvals[] = $tipo;
		}
		//1 eh valor impossivel, hackzinho pra nao ter que fazer regexp pra fechar o in
		$mid .= '"0") ';
      }

      foreach ($filters as $key => $value) {
	$mid .= " and `$key` like ? ";
	$bindvals[] = '%'.$value.'%';
      }

      if (!$user) {
	$tables = " from `el_arquivo` a, `el_licenca` l ";
      } else {
	$tables = ", ur.`rating` as user_rating from `el_arquivo` a,`el_licenca` l left join `el_arquivo_rating` ur on ur.`arquivoId` = a.`arquivoId` and ur.`user`=? ";
	$bindvals = array_merge(array($user),$bindvals);
      }

      $query = "select a.*, a.`titulo` as nomeArquivo, l.`subTipo` licenca, `link_imagem`, `link_human_readable` $tables $mid and a.`licencaId`=l.`licencaId` and `publicado`=1 order by ".$this->convert_sortmode($sort_mode);
      $result = $this->query($query,$bindvals,$maxRecords,$offset);
    
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

  function count_all_uploads($tipos = array(), $user = false) {
      $query = "select count(*) from `el_arquivo` where publicado=1";
      $bindvals = array();

	  if ($tipos) {
	  $query .= ' and `tipo` in (';
		foreach($tipos as $tipo) {
			$query .= '?,';
			$bindvals[] = $tipo;
		}
		//1 eh valor impossivel, hackzinho pra nao ter que fazer regexp pra fechar o in
		$query .= '"0") ';
      }

      if ($user) {
	  $query .= " and `user`=?";
	  $bindvals[] = $user;
      }

      return $this->getOne($query, $bindvals);
  }

  function list_all_user_uploads($user) {
    $query = "select a.*, a.`titulo` as nomeArquivo, ur.`rating` as user_rating, l.`subTipo` licenca, `link_imagem`, `link_human_readable` from `el_arquivo` a,`el_licenca` l left join `el_arquivo_rating` ur on ur.`arquivoId` = a.`arquivoId` and ur.`user`=? where a.`licencaId`=l.`licencaId` and a.`user`=? and `publicado` order by a.`data_publicacao` desc";
    $query_cant = "select count(*) from `el_arquivo` where `user`=? and `publicado`";
    $bindvals = array($user, $user);
    $cant = $this->getOne($query_cant, array($user));
    $data = array();
    $result = $this->query($query, $bindvals);
    while ($row = $result->fetchRow()) {
      $data[] = $row;
    }
    
    return array('data' => $data,
		 'cant' => $cant);
    
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
    $bindvals = $obrigatorio;
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
      
      $arquivo['metadata'] = $result->fetchRow();
    }
    return $arquivo;
  }
    /*
    Resposta 2
     1 = Sim;
     2 = Não;
     3 = Sim, contanto...;
    */
    function id_licenca($resposta1,$resposta2=false) {
        switch($resposta1) {
            case 1:
                switch($resposta2) {
                    case 1:
                        $id_licenca = 4;
                    break;
                    case 2:
                        $id_licenca = 8;
                    break;
                    case 3:
                        $id_licenca = 9;
                    break;
                }
		break;
            case 2:
                switch($resposta2) {
                    case 1:
                        $id_licenca = 5;
                    break;
                    case 2:
                        $id_licenca = 6;
                    break;
                    case 3:
                        $id_licenca = 7;
                    break;
                }
		break;
            case 3:
                $id_licenca = 1;
            break;
            case 4:
                $id_licenca = 2;
            break;
            case 5:
                $id_licenca = 3;
            break;
        }
        return @$id_licenca;
    }

  function set_licenca($arquivoId, $licencaId) {
    $query = "update `el_arquivo` set `licencaId` = ? where `arquivoId` = $arquivoId";
    $bindvals = array($licencaId);
    $this->query($query,$bindvals);
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
  
  function get_tipos() {
    $query = 'select * from `el_tipos_arquivo`';
    $result = $this->query($query);
    while($tipo = $result->fetchRow()) {
      $ret[] = $tipo;
      
    }
    $tipos['data'] = $ret;
    return $tipos;
  }
  
  function send_file($file,$arquivoId,$userId) {
#$destination = '/noe/data/vhost/estudiolivre.piolho.org/htdocs/repo/';
# assim eh melhor pois independe do dir ;P
    $destination = "repo/";
    $data = $this->get_arquivo($arquivoId);
    $query = "update `el_arquivo` set `arquivo`=?,`formato`=?,`tamanho`=?,`publicado`=?,`data_publicacao`=? where `arquivoId`=?";
    $bindvals[] = $arquivoId.'_'.$userId.'-'.$file['name'];
    $bindvals[] = $file['type'];
    $bindvals[] = $file['size'];
    $bindvals[] = 1;
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
  
  function generate_thumbnail($image) {
    
    $fp = fopen($image, 'rb');
    $data = '';
    while (!feof($fp)) {
      $data .= fread($fp, 8192 * 16);
    }
    
    if (function_exists('imagepng')) {
      
      //bloco que acha a proporcao pro thumbnail
      list($width, $height) = getimagesize($image);
      $percent = ($width>(12/7.5)*$height) ? 120/$width : 75/$height;
      $src = imagecreatefromstring($data);
      $img = imagecreatetruecolor($width*$percent, $height*$percent);
      imagecopyresized($img, $src, 0, 0, 0, 0, $width*$percent, $height*$percent, $width, $height);
      
      ob_start();
      imagepng($img);
      $data = ob_get_contents();
      ob_end_clean();
      
    }
    global $tikilib;
    $tikilib->blob_encode($data);
    fclose($fp);
    
    return $data;
    
  }
  
  function create_anim_gif($path) {
     
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
      $tikilib->blob_encode($data);
      fclose($fp);
      
      return $data;
  
  }
  
  function new_files($user) {
    
    $last = $this->getOne("select `lastLogin`  from `users_users` where `login`=?",array($user));

    $query = "select count(*) from `el_arquivo` where `data_publicacao` > ?";

    return $this->getOne($query, array((int)$last));

  }
  
}

global $elgallib;
global $dbTiki;
$elgallib = new ELGalLib($dbTiki);

?>