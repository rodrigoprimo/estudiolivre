<!-- el-gallery_upload_general.tpl begin -->
<script language="JavaScript" src="lib/elgal/upload.js"></script>
<script language="JavaScript" src="lib/js/edit_field_ajax.js"></script>
<script language="JavaScript" src="lib/js/freetags.js"></script>

<div id="gUpload">
  <div id="gUpLeft">
    <div id="gUpIcons">
      {* Aqui terá um JS que colore o ícone selecionado e deixa os outros preto e branco *}
      <div class="gUpIcon">
        {*tooltip text="Clique aqui para enviar um arquivo de <b>áudio</b>"*}<img id="iconeAudio" onMouseOver="acendeTipo('Audio');" onMouseOut="apagaTipo('Audio')" onClick="selecionaTipo('Audio')" alt="" src="styles/estudiolivre/iUpAudioOff.png"><br />
        Áudio{*/tooltip*}
      </div>
    
      <div class="gUpIcon">
        {*tooltip text="Clique aqui para enviar uma <b>imagem</b>"*}<img id="iconeImagem" onMouseOver="acendeTipo('Imagem');" onMouseOut="apagaTipo('Imagem')" onClick="selecionaTipo('Imagem')" alt="" src="styles/estudiolivre/iUpImagemOff.png"><br />
        Imagem{*/tooltip*}
      </div>
    
      <div class="gUpIcon">
        {*tooltip text="Clique aqui para enviar um arquivo de <b>texto</b>"*}<img id="iconeTexto" onMouseOver="acendeTipo('Texto');" onMouseOut="apagaTipo('Texto')" onClick="selecionaTipo('Texto')" alt="" src="styles/estudiolivre/iUpTextoOff.png"><br />
        Texto{*/tooltip*}
      </div>
    
      <div class="gUpIcon">
		{*tooltip text="Clique aqui para enviar um arquivo de <b>vídeo</b>."*}<img id="iconeVideo" onMouseOver="acendeTipo('Video');" onMouseOut="apagaTipo('Video')" onClick="selecionaTipo('Video')" alt="" src="styles/estudiolivre/iUpVideoOff.png"><br />
        Video{*/tooltip*}
      </div>
    
    </div>
    
    <img class="separator" src="styles/estudiolivre/separator.png">
    
    <div id="gUpList" style="display:none">
    
  	<iframe name="uploadTarget" style="display:none" onLoad="finishUpload();"></iframe>

      <div class="gUpListItem gUpSelected">
        
        <a href="#" onclick="upload();" class="gUpListEdit"><img src="styles/estudiolivre/iSelect.png"></a>
    	<div id="gUpBackground" class="gUpListItemField">
    	  <div id="gUpFileName"></div>
    	  <div id="gUpPercentContainer" class="gUpPercent"><span id="gUpPercent"></span></div>
    	  <div class="gUpStatus" id="gUpStatusBar"></div>
    	</div>
    	<a href="#" class="gUpButton" id="gUpButton">procurar</a>
    	<div class="gUpForm">
	      <form name="uploadForm" target="uploadTarget" action="el-gallery_upload_file.php?UPLOAD_IDENTIFIER={$uploadId}" method="post" enctype="multipart/form-data">
  		    <input type="hidden" name="UPLOAD_IDENTIFIER" value="{$uploadId}">  		    <input type="hidden" name="arquivoId" value="">
  		    <input type="hidden" name="tipo" value="">
   	   	    <input type="file" name="arquivo" onMouseOver="document.getElementById('gUpButton').className='gUpButtonHover'" onMouseOut="document.getElementById('gUpButton').className='gUpButton'" onChange="changeStatus(this.value);">
   	      </form>
         </div>
   
     </div>
    
    <img class="separator" src="styles/estudiolivre/separator.png">
	    
    </div>

    {if $pending && $permission}
	 	<div id="fileAltered" style="display:block;text-align:left">
	 		Arquivos não publicados:<br/>
		 	<ul>
				{foreach from=$pending item=pendente}
					<li>
						<a onClick="restoreForm({$pendente.arquivoId}, '{$pendente.tipo}', '{$pendente.arquivo}', '{$pendente.thumbnail}');flip('fileAltered')">{$pendente.titulo|default:$pendente.arquivo|default:$pendente.arquivoId}</a>&nbsp;&nbsp;&nbsp;&nbsp;
					    <a href="el-gallery_delete.php?arquivoId={$arquivo.arquivoId}">(apagar)</a>
					</li>
				{/foreach}
			 </ul>
		 </div>
	 {/if}
    
    
    
  </div>

  <div id="gUpRight" style="display:none">
  
    <div id="gUpThumbImgForm">
      <div id="gUpThumb">
	    <div id="gUpThumbImg">
	      <img id="thumbnail" alt="" height="60" width="60" src="">
	      <div id="gUpThumbStatus"></div>
	    </div>
      </div>
      <div id="gUpThumbForm">
  	<iframe name="thumbUpTarget" style="display:none" onLoad="finishUpThumb();"></iframe>
        {tooltip text="Clique para selecionar outra <b>miniatura</b> para o arquivo"}<form action="el-gallery_upload_thumb.php?UPLOAD_IDENTIFIER=thumb.{$uploadId}" method="post" enctype="multipart/form-data" name="thumbForm" target="thumbUpTarget">
	  <input type="hidden" name="UPLOAD_IDENTIFIER" value="thumb.{$uploadId}">
	  <input type="hidden" name="arquivoId" value="">
	  <input type="file" name="thumb" onChange="changeThumbStatus()" class="gUpThumbFormButton">
        </form>{/tooltip}
      </div>
    </div>

    <div id="gUpTitleAuthor">
        {ajax_input permission=$permission class="editable gUpTitle" id="titulo" value=$arquivo.titulo default="Titulo" display="inline" truncate=50}
		<div id="gUpAuthorCont">
		  	Por {ajax_input permission=$permission class="gUpAuthor editable" id="autor" value=$realName default="Autor da obra" display="inline" mode="edit"}
		</div>
    </div>
      
    <br style="clear:both; line-height:30px;">
    <div id="gUpDescription">
    	<div>
	    	{ajax_textarea permission=$permission  display="block" style="width: 250px; height:125px; border: 1px inset rgb(233, 233, 174);padding: 3px;font-size: 12px; font-family: Arial, Verdana, Helvetica, Lucida, Sans-Serif;background-color: #f1f1f1;margin-bottom: 5px;" class="editable gUpDescription" id="descricao" value=$arquivo.descricao default="Escreva aqui a descrição da sua obra"}
	    </div>
    </div>
    
    <br style=" line-height:20px;">
	Licença: <span onClick="showLightbox('el-license')" style="cursor: pointer;text-decoration:underline"><img id="uImagemLicenca" src="styles/estudiolivre/h_{$licenca.linkImagem}" alt="Escolha uma licença"/></span>
	{include file="el-gallery_license.tpl"}
	
	<br />
	<br />	
	
    <div id="gUpEditTags">
      {if $feature_freetags eq 'y' && $tiki_p_freetags_tag eq 'y'}
        <span>Tags</span>
	{* O ideal eh que tenha suggest aqui nesse campo *}
	{tooltip text="Escreva aqui as tags desse arquivo (separadas por <b>vírgula</b>)"}{ajax_input permission=$permission class="freetags" id="tags" value="$taglist" noclear=1 display="inline"}{/tooltip}<br>
	  <div id="gUpTagSugest">
	    {* Aqui ficam listadas as tags do usuário.
	    Primeiro as 10 mais usadas, com um botão "exibir +" e outro "exibir todas" *}

	    <div id="gUpTagSuggestUser" >
	      <div id="gUpTagSuggestMore" style="display:block">
	        <a href="#" class="gUpmore" onclick="document.getElementById('gUpTagListItem').innerHTML=document.getElementById('gUpTagListItem').innerHTML+document.getElementById('gUpTagSuggestUserMoreTen').innerHTML;flip('gUpTagSuggestMore');return false;">+10</a>
	      </div>
	   	  {tooltip text="Clique nas tags para adiocioná-las ao campo acima"}
	      <div id="gUpTagListItem">
	        {foreach from=$tag_suggestion item=t}
		  		<span class="pointer" onclick="addTag(this)">{$t}</span>
	        {/foreach}
	      </div> 
    	  {/tooltip}
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
      {tooltip text="Clique para definir outras propriedades do arquivo"}<a class="gUpmore" id="gUpmoreoptionsLink" onclick="javascript:flip('gUpMoreOptionsContent'); return false;"> [+] opções </a>{/tooltip}<br/>
      <div style="display:none" id="gUpMoreOptionsContent">
      </div>
    </div>
    
     <br style="clear:both; line-height:20px;">
    
    <div id="save-exit">
       <img src="styles/estudiolivre/bPublicar.png" onClick="xajax_check_publish()"/>
    </div>


  </div>
  
</div>

{include file="el-gallery_publish.tpl"}
{include file="el-gallery_error.tpl"}

<!-- el-gallery_upload_general.tpl end -->

