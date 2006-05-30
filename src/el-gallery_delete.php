<?php
    //if we have arquivoId, we can delete the file.
    if (isset($_REQUEST['arquivoId'])){
      if($elgallib->delete_arquivo($_REQUEST['arquivoId'])){
	$smarty->assign('msg','arquivo apagado com sucesso, id:'.$_REQUEST['arquivoId']);
      }
    }
    $smarty->assign('all',$elgallib->list_all_user_uploads($user));
    $smarty->assign('pending',$elgallib->list_pending_uploads($user));
    $smarty->assign('mid','el-gallery_manage.tpl');
?>