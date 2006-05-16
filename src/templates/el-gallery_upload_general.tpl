<!-- el-gallery_upload_general.tpl begin -->
{$xajax_js}
<script language="JavaScript" src="lib/elgal/upload.js"></script>

<div id="gUpload">
  <div id="gUpLeft">
    <div id="gUpIcons">
      {* Aqui terá um JS que colore o ícone selecionado e deixa os outros preto e branco *}
      <div class="gUpIcon">
        <img alt="" src="styles/estudiolivre/iUpAudio.png"><br />
        Áudio
      </div>
    
      <div class="gUpIcon">
        <img alt="" src="styles/estudiolivre/iUpImageOff.png"><br />
        Imagem
      </div>
    
      <div class="gUpIcon">
        <img alt="" src="styles/estudiolivre/iUpTextOff.png"><br />
        Texto
      </div>
    
      <div class="gUpIcon">
        <img alt="" src="styles/estudiolivre/iUpVideoOff.png"><br />
        Video
      </div>
    
    </div>
    
    <img class="separator" src="styles/estudiolivre/separator.png">
    
    <div id="gUpList">
    
  	<iframe name="uploadTarget" style="display:none" onLoad="finishUpload();"></iframe>

   	  <div class="gUpListItem" id="uploadMeter" style="display: none">
        <a href="#" class="gUpListEdit"><img src="styles/estudiolivre/iSelectOff.png"></a>
	    <div class="gUpListItemFieldComplete"><div class="gUpListItemFieldCompleteInside">100%</div></div>
      </div>
      
      <div class="gUpListItem gUpSelected">
        
        <a href="#" onclick="upload('{$uploadId}');" class="gUpListEdit"><img src="styles/estudiolivre/iSelect.png"></a>
    	<div id="gUpBackground" class="gUpListItemField">
    	  <div id="gUpContent"></div>
    	  <div id="gUpStatusBar" class="gUpStatus"></div>
    	</div>
    	<a href="#"class="gUpButton">procurar</a>
    	<div style="position:relative; top:-20px; left:10px; opacity:0; z-index:10">
          <form name="uploadForm" target="uploadTarget" action="el-gallery_upload_file.php?UPLOAD_IDENTIFIER={$uploadId}" method="post" enctype="multipart/form-data">
  		    <input type="hidden" name="UPLOAD_IDENTIFIER" value="{$uploadId}">
   	   	    <input type="file" name="arquivo" onChange="changeStatus(this.value);">
   	      </form>
   	    </div>
   
     </div>
      
      
      <div class="gUpListItem">
        <a href="#"class="gUpListEdit"><img src="styles/estudiolivre/iSelectOff.png"></a>
	<input class="gUpListItemField gUpEditing" name="arquivo" size="12" type="text"> <a href="#"class="gUpButton">cancelar</a>
	<div class="gUpListItemFieldComplete gUpUploading" ><div class="gUpListItemFieldCompleteInside gUpUploadingInside">60%</div></div>
      </div>
      <div class="gUpListItem">
        <a href="#"class="gUpListEdit"><img src="styles/estudiolivre/iSelectOff.png"></a>
	<input class="gUpListItemFieldCompleteInside gUpEditing" name="arquivo" size="12" type="text"> <a href="#"class="gUpButton">procurar</a>
      </div>
      
      <div id="gUpListAddFileCont">
        <a href="#">Adicionar outro arquivo</a>
      </div>
    </div>
    
    <img class="separator" src="styles/estudiolivre/separator.png">
    
    <div id="gUpSet">
      <a href="#"><img alt="" src="styles/estudiolivre/iColection.png"></a>
    
    </div>
    
  </div>
  
  <div id="gUpRight">
    <div id="gUpEditThumbTitleAuthor">
      <div id="gUpThumb">
        <img alt="" height="60" width="60" src="el-download.php?arquivo=53&thumbnail=1" >
      </div>
      
      <div id="gUpTitleAuthor">
        <div id="gUpTitle">
	  Titulo da minha Musica PORRA!!!
	</div>
	<div id="gUpAuthor">
	  Por <a href="#">Uirá Jesus</a>
	</div>
      </div>
      
    </div>
    <br style="line-height:30px;">
    <div id="gUpEditDescription">
      <span id="gUpDescription"> Essa eh a descrição da minha obra ela eh curta e pronto Essa eh a descrição da minha obra ela eh curta e pronto Essa eh a descrição da minha obra ela eh curta e pronto Essa eh a descrição da minha obra ela eh curta e pronto Essa eh a descrição da minha obra ela eh curta e pronto Essa eh a descrição da minha obra ela eh curta e pronto</span>
    
    </div>
    
    <br style=" line-height:20px;">
    
    <div id="gUpEditTags">
      {if $feature_freetags eq 'y' && $tiki_p_freetags_tag eq 'y'}
        <span>Tags</span>
	{* O ideal eh que tenha suggest aqui nesse campo *}
	<input type="text" name="freetag_string" value="{$taglist|escape}" size="12"/><br>
	  <script language="JavaScript">
	    {literal}
	      function addTag(tag) {
	      el = document.getElementById('tagBox');
	      el.value += ' ' + tag;
	      }
	    {/literal}
	  </script>
	  <div id="gUpTagSugest">
	    {* Aqui ficam listadas as tags do usuário.
	    Primeiro as 10 mais usadas, com um botão "exibir +" e outro "exibir todas" *}
	    <div id="gUpTagSuggestUser" >
	      <div id="gUpTagSuggestMore">
	        <a href="#" class="gUpmore" onclick="javascript:flip('gUpTagSugestUserMoreTen'); return false;">+10</a>
	      </div>
	      <div id="gUpTagListItem">
	        {foreach from=$tag_suggestion item=t}
	        <a href="javascript:addTag('{$t}')">{$t}</a> 
	        {/foreach}
	      </div> 
	    </div>
	    
	    <div id="gUpTagSuggestUserMoreTen" style="display:none">
	      {foreach from=$tag_suggestion item=t}
	      <a href="javascript:addTag('{$t}')">{$t}</a> 
	      {/foreach}
	    </div>
	  </div>
      {/if freetags}
    </div>
    <br style="clear:both; line-height:20px;">
    
    <div id="gUpMoreOptions">
      <a class="gUpmore" onclick="javascript:flip('gUpMoreOptionContent'); return false;"> [+] opções </a>
      
      <div style="display:none" id="gUpMoreOptionContent">
        {include file="el-gallery_upload_metadata.tpl"}
	<a href="#" class="gUpmore" onclick="javascript:flip('gUpLicense'); return false;">Escolher Licença para este arquivo</a>
	<div id="gUpLicense" style="display:none">
	 {include file="el-gallery_upload_license.tpl"}
	</div>
      </div>
    </div>
    
     <br style="clear:both; line-height:20px;">
    
    <div id="gUpSave">
      <input type="image" name="login" src="styles/estudiolivre/bSave.png" />
    </div>
    
  
    
  
  </div>

  
</div>

<!-- el-gallery_upload_general.tpl end -->





{*
<div id="el-arquivo">
<br/>


<form action="el-gallery_upload.php" method="post">
    
	<table class="el-upload-general el-upload-general4">
		<tr>
			<td class="el-upload-general-right">
				Passo 1 de 4 .:. Informações do arquivo&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
	</table>
	<br />
	
	{if $errormsg}<font color="red">{$errormsg}</font><br /><br />{/if}
	
	Preencha os campos abaixo com as informações do seu arquivo. <br />Os campos com um <font color="red">*</font> são obrigatórios.<BR />
	<br />
	
	<table class="el-upload-general el-upload-general1">
		<tr>
			<td class="el-upload-general-right"><font color="red">*</font> Título:</td><td><input type="text" name="obrigatorio[titulo]"  value="{$value.obrigatorio.titulo}" size=40/></td>
		</tr>
		<tr>
			<td class="el-upload-general-right"><font color="red">*</font> Formato:</td>
			<td >
				<select name="obrigatorio[tipo]">
        			{foreach from=$tipos.data item=t}
						{if $value.obrigatorio.tipo eq $t.nome || $tipo eq $t.nome}
							<option value="{$t.nome}" selected>{$t.nome}</option>
						{else}
							<option value="{$t.nome}">{$t.nome}</option>
						{/if}
        			{/foreach}
        		</select>
			</td>
		</tr>
		<tr>
			<td class="el-upload-general-right"><font color="red">*</font> Autor:</td><td><input type="text" name="obrigatorio[autor]" value="{$value.obrigatorio.autor}" size=40/></td>
		</tr>
		<tr>
			<td class="el-upload-general-right"><font color="red">*</font> Detentor dos <br /> Direitos Autorais:</td><td><input type="text" name="obrigatorio[donoCopyright]" value="{$value.obrigatorio.donoCopyright}" size=40/></td>
		</tr>
	</table>
	<br />
	<table class="el-upload-general el-upload-general2">
		<tr>
			<td colspan="2">
				<font color="red">*</font>
				Descrição:<br />
				<textarea name="obrigatorio[descricao]" cols="50" rows="15">{$value.obrigatorio.descricao}</textarea>
			
			</td>
		</tr>
	
	</table>
	<br />
	<table class="el-upload-general el-upload-general3">
		<tr>
			<td colspan="2">
				<font color="red">*</font>
				Declaração:<br />
				<textarea name="declaracao" disabled>Eu declaro que isso aó é meu memo e não to robando de ninguem.. to aqui pedindo, podia tá roubando...</textarea><BR />
				<input style="width: auto;" type="checkbox" name="ciente" value="1" {if !$value.ciente eq 0}checked{/if}>&nbsp; Estou ciente.
				
			</td>
		</tr>
		<tr>
			<td colspan="2" class="el-upload-general-right">
				<input type="hidden" name="step" value="general" />
    			<input style="width: auto;" type="submit" name="save" value=" Continuar >>" />&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
	</table>


<br />
<br />


</form>

</div> *}
