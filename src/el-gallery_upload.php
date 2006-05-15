<?php
require_once("tiki-setup.php");
require_once("lib/elgal/elgallib.php");

// Now check permissions to access this page
if (!$user) {
  $smarty->assign('msg', tra("You are not logged in"));
  $smarty->display("error.tpl");
  die;
}

// comentado a pedido do NANO
//if ($el_p_upload_files != 'y') {
//    $smarty->assign('msg', tra("Permission denied you cannot upload files"));
//    $smarty->display("error.tpl");
//    die;
//}

include_once("freetag_list.php");

global $tikilib, $user;

$smarty->assign('style', 'estudiolivre_biblio.css');
$smarty->assign('user_uploads', $elgallib->count_all_uploads(false,$user));

$avatar = $tikilib->get_user_avatar($user);
$smarty->assign('avatar', $avatar);

$arquivoId = 0;
$tipo = "";

// Array of lincenses
$licencas = $elgallib->get_licencas();
$smarty->assign('licencas',$licencas);

$tipos = $elgallib->get_tipos();
$smarty->assign('tipos',$tipos);

// Array of types of files
$smarty->assign('tipos',$elgallib->get_tipos());

//Array of values from the form
$smarty->assign('value',$_POST);

if (isset($_GET['tipo'])) {
  $smarty->assign('tipo',$_GET['tipo']);
}

$steps = array('general','license','upload','extrainfo'); 

$step = 'general';
if (isset($_REQUEST['save'])) {
    $step = $_REQUEST['step'];

    switch($step) {
    case 'general':
      if (isset($_REQUEST['ciente'])) {
        $erro = 0;
        foreach($_REQUEST['obrigatorio'] as $key => $value) {
            if($value == false) {
                $erro++;
            }
        }
        if ($erro) {
            $smarty->assign('errormsg',tra('Você deve fornecer as informações obrigatorias'));
	    $smarty->assign('taglist',$_POST['freetag_string']);
        } else {
            $arquivoId = $elgallib->create_arquivo($_REQUEST['obrigatorio'],$user);
	    $arquivo = $elgallib->get_arquivo($arquivoId);

	    $cat_type = $arquivo['tipo'];
	    $cat_objid = $arquivoId;
	    $cat_name = $arquivo['titulo'];
	    $cat_desc = $arquivo['descricao'];
	    $cat_href = 'el-gallery_manage.php?arquivoId='.$arquivoId.'&action=view';
	    include_once("freetag_apply.php");

            $step = 'license';
        }
      }
      else {
	$smarty->assign('errormsg',tra('Você tem que estar ciente...'));
      }
        break;

        case 'license':
	  if(isset($_REQUEST['tipo'])){
            if($_REQUEST['arquivoId']!=0 and $_REQUEST['tipo']!=0) {
                if($_REQUEST['tipo']==1) {
                    if((!@$_REQUEST['resposta1']) and (!@$_REQUEST['resposta2'])) {
                        $smarty->assign('errormsg',tra('Você deve responder as duas perguntas.'));
                    } else {
                        $id_licenca = $elgallib->id_licenca(@$_REQUEST['resposta1'],@$_REQUEST['resposta2']);
                    }
                } else {
                    if($_REQUEST['tipo']==2) {
                        if(!$_REQUEST['resposta1']) {
                            $smarty->assign('errormsg',tra('Você deve escolher um tipo de licença Recombo'));
                        } else  {
                            $id_licenca = $elgallib->id_licenca(@$_REQUEST['resposta1'],$_REQUEST['resposta2']);
                        }
                    }
                }
                if(@$id_licenca != 0 ) {
                    $elgallib->set_licenca($_REQUEST['arquivoId'], $id_licenca);
                    $step = 'upload';
                } else  {
                    $smarty->assign('errormsg',tra('Você deve escolher um tipo de licença'));
                }
            } else {
                $smarty->assign('errormsg',tra('Você deve escolher uma licença'));
            }
	  }
	  $arquivoId = $_REQUEST['arquivoId'];
        break;

        case 'upload':
            if (isset($_REQUEST['arquivoId']) && isset($_FILES['arquivo']) && !empty($_FILES['arquivo']['name'])) {

   	        if ($_FILES["arquivo"]["type"] == 'application/ogg' &&
		    preg_match("/^Audio|Video$/",$_REQUEST['tipo'])) {
		    $_FILES["arquivo"]["type"] = strtolower($_REQUEST['tipo'])."/ogg";		 
		} 

	        preg_match("/(.+)\/.+/", $_FILES["arquivo"]["type"], $arq_tipo);
		
		if ($arq_tipo[1] == "image") {
		  $arq_tipo[1] = "imagem";
		} elseif ($arq_tipo[1] == "text") {
		  $arq_tipo[1] = "texto";
		}
		if($arq_tipo[1] != strtolower($_REQUEST['tipo'])) {
		  $smarty->assign('errormsg', "Você deve fornecer um arquivo do tipo: ".$_REQUEST['tipo'].", e nao do tipo: ".$arq_tipo[1]);
		}
		else {
		  // Were there any problems with the upload?  If so, report here.
		  if (!is_uploaded_file($_FILES["arquivo"]['tmp_name'])) {
		    $smarty->assign('errormsg',tra('Upload was not successful').': '.ELGalLib::convert_error_to_string($_FILES["arquivo"]['error']));
		  } 
		  else {
		    global $userlib;
		    $userId = $userlib->get_user_id($user);
		    $error = $elgallib->send_file($_FILES["arquivo"],$_REQUEST['arquivoId'],$userId);
		    if (!$error) {
		      $step='metadata';
		    }
		    else {
		      $smarty->assign('errormsg',tra('Upload was not successful').': '.$error);
		    }
		  }
		}
	    }
	    $arquivoId = $_REQUEST['arquivoId'];
	    break;
        case 'metadata':

            if (isset($_REQUEST['arquivoId'])) {
	        if (@$_REQUEST['autothumb']) {
		  if ($_REQUEST['tipo'] == "Video") {
		      $gif = $elgallib->create_anim_gif("repo/".$_REQUEST['arquivo']);
		      $_POST['geralStub']['thumbnail'] = $gif;
		  }
		  elseif ($_REQUEST['tipo'] == "Imagem") {
		    $_POST['geralStub']['thumbnail'] = $elgallib->generate_thumbnail("repo/".$_REQUEST['arquivo']);
		  }
		}
		elseif (isset($_FILES['geralStub']['name']['thumbnail'])) {
		  
		  $file = $_FILES['geralStub']['tmp_name']['thumbnail'];
		  
		  if(is_uploaded_file($file)) {
		    $_POST['geralStub']['thumbnail'] = $elgallib->generate_thumbnail($file);
		  }
	
		}

		$elgallib->set_metadata($_POST['geralStub'],$_POST['especificoStub'],strtolower($_POST['tipo']));
		$arquivoId = $_REQUEST['arquivoId'];
		$step = 'manage';
            }
    }
}

if ($step == 'manage') {
  header('location: el-gallery_manage.php');
  exit;
}
else {
  $smarty->assign('mid','el-gallery_upload_'.$step.'.tpl');
}

$smarty->assign('step',$step);

if ($arquivoId) {
  $smarty->assign('arquivoId',$arquivoId);
  $arquivo = $elgallib->get_arquivo($arquivoId);
  $smarty->assign('arquivo',$arquivo);
  $cat_type = $arquivo['tipo'];
  $cat_objid = $arquivoId;
  include_once ("freetag_list.php");
}

$smarty->display('tiki.tpl');

?>
