<script language="JavaScript" src="lib/js/el_array.js"></script>
<script language="JavaScript" src="lib/js/license.js"></script>
<script language="JavaScript" src="lib/elgal/upload.js"></script>
<script language="JavaScript" src="lib/js/edit_field_ajax.js"></script>
<script language="JavaScript" src="lib/js/freetags.js"></script>

<div id="gUpload">
  <div id="gUpLeft">
    <div id="gUpIcons">
      <div class="gUpIcon pointer">
        {*tooltiX text="Clique aqui para enviar um arquivo de <b>áudio</b>"*}<img id="iconeAudio" onMouseOver="acendeTipo('Audio');" onMouseOut="apagaTipo('Audio'); return nd();" onClick="selecionaTipo('Audio')" alt="" src="styles/estudiolivre/iUpAudioOff.png"><br />
        {tr}Áudio{/tr}{*/tooltip*}
      </div>
    
      <div class="gUpIcon pointer">
        {*tooltiX text="Clique aqui para enviar uma <b>imagem</b>"*}<img id="iconeImagem" onMouseOver="acendeTipo('Imagem');" onMouseOut="apagaTipo('Imagem'); return nd();" onClick="selecionaTipo('Imagem')" alt="" src="styles/estudiolivre/iUpImagemOff.png"><br />
        {tr}Imagem{/tr}{*/tooltip*}
      </div>
    
      <div class="gUpIcon pointer">
        {*tooltiX text="Clique aqui para enviar um arquivo de <b>texto</b>"*}<img id="iconeTexto" onMouseOver="acendeTipo('Texto');" onMouseOut="apagaTipo('Texto'); return nd();" onClick="selecionaTipo('Texto')" alt="" src="styles/estudiolivre/iUpTextoOff.png"><br />
        {tr}Texto{/tr}{*/tooltip*}
      </div>
    
      <div class="gUpIcon pointer">
		{*tooltiX text="Clique aqui para enviar um arquivo de <b>vídeo</b>."*}<img id="iconeVideo" onMouseOver="acendeTipo('Video');" onMouseOut="apagaTipo('Video'); return nd();" onClick="selecionaTipo('Video')" alt="" src="styles/estudiolivre/iUpVideoOff.png"><br />
        {tr}Vídeo{/tr}{*/tooltip*}
      </div>
    
    </div>
    
    <img class="separator" src="styles/estudiolivre/separator.png">
    
    <div id="gUpList" style="display:none">
  	<iframe name="uploadTarget" style="display:none" onLoad="finishUpload();"></iframe>

      <div class="gUpListItem gUpSelected">
        
        <img class="gUpListEdit" src="styles/estudiolivre/iSelect.png">
    	<div id="gUpBackground" class="gUpListItemField">
    	  <div id="gUpFileName"></div>
    	  <div id="gUpPercentContainer" class="gUpPercent"><span id="gUpPercent"></span></div>
    	  <div class="gUpStatus" id="gUpStatusBar"></div>
    	</div>
    	<a href="#" class="gUpButton" id="gUpButton">{tr}procurar{/tr}</a>
    	<div class="gUpForm">
	      <form name="uploadForm" target="uploadTarget" action="el-gallery_upload_file.php?UPLOAD_IDENTIFIER={$uploadId}" method="post" enctype="multipart/form-data">
  		    <input type="hidden" name="UPLOAD_IDENTIFIER" value="{$uploadId}">  		    <input type="hidden" name="arquivoId" value="">
  		    <input type="hidden" name="tipo" value="">
   	   	    <input type="file" name="arquivo" onMouseOver="document.getElementById('gUpButton').className='gUpButtonHover'" onMouseOut="document.getElementById('gUpButton').className='gUpButton'" onChange="changeStatus(this.value);">
   	      </form>
         </div>
   
     </div>
    <center>
	    <img class="separator" src="styles/estudiolivre/separator.png">
    </center>
    
    </div>

    {if $pending && $permission}
	 	<div id="fileAltered" style="display:block;text-align:left">
	 		{tr}Arquivos não publicados{/tr}:<br/>
		 	<ul id="gUpPending">
				{foreach from=$pending item=pendente}
					<li id="pendente-{$pendente.arquivoId}">
						<span class="pointer" onClick="xajax_delete_file({$pendente.arquivoId})"><img src="styles/estudiolivre/iDelete.png"></span>
						{tooltip text="Clique para continuar o envio desse arquivo"}
							<span class="pointer" onClick="restoreForm({$pendente.arquivoId}, '{$pendente.tipo}', '{$pendente.arquivo}', '{$pendente.thumbnail}');flip('fileAltered');nd();">
								{$pendente.titulo|default:$pendente.arquivo|default:$pendente.arquivoId}
							</span>
						{/tooltip}
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
	      <img id="thumbnail" alt="" class="gUpThumbImg">
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
        {ajax_input permission=$permission class="gUpTitle" id="titulo" value=$arquivo.titulo default="{tr}Titulo{/tr}" display="inline" truncate=50}
		<div id="gUpAuthorCont">
		  	{tr}Por{/tr} {ajax_input permission=$permission class="gUpAuthor" id="autor" value=$realName default="{tr}Autor da obra{/tr}" display="inline" mode="edit"}
		</div>
    </div>
      
    <br style="clear:both; line-height:30px;">
    <div id="gUpDescription">
    	<div>
	    	{ajax_textarea permission=$permission  display="block" style="width: 250px; height:125px; border: 1px inset rgb(233, 233, 174);padding: 3px;font-size: 12px; font-family: Arial, Verdana, Helvetica, Lucida, Sans-Serif;background-color: #f1f1f1;margin-bottom: 5px;" class="gUpDescription" id="descricao" value=$arquivo.descricao default="{tr}Escreva aqui a descrição da sua obra{/tr}"}
	    </div>
    </div>
    
    <br style=" line-height:20px;">
	{tr}Licença{/tr}: <span onClick="showLightbox('el-license')" style="cursor: pointer;text-decoration:underline"><img id="uImagemLicenca" src="styles/estudiolivre/h_{$licenca.linkImagem}" alt="Escolha uma licença"/></span>
	{assign var="upload" value=1}
	{include file="el-license.tpl"}
	
	<br />
	<br />	
	
    <div id="gUpEditTags">
      {if $feature_freetags eq 'y' && $tiki_p_freetags_tag eq 'y'}
        <span>{tr}Tags{/tr}</span>
	{* O ideal eh que tenha suggest aqui nesse campo *}
	{tooltip text="Escreva aqui as tags desse arquivo (separadas por <b>vírgula</b>)"}{ajax_input permission=$permission class="freetags" id="tags" value="$taglist" noclear=1 display="inline"}{/tooltip}<br>
	  <div id="gUpTagSugest">
	    {* Aqui ficam listadas as tags do usuário.
	    Primeiro as 10 mais usadas, com um botão "exibir +" e outro "exibir todas" *}

	    <div id="gUpTagSuggestUser" >
	      <div id="gUpTagSuggestMore" style="display:block">
	        {include file="el-tag_suggest_more.tpl"}
	      </div>
	   	  {tooltip text="Clique nas tags para adiocioná-las ao campo acima"}
	      <div id="gUpTagListItem">
	        {include file="el-tag_suggest_list.tpl"}
	      </div> 
    	  {/tooltip}
	    </div>
	  </div>
      {/if freetags}
    </div>
    <br style="clear:both; line-height:20px;">
    
    <div id="gUpMoreOptions">
      {tooltip text="Clique para definir outras propriedades do arquivo"}
      	<a class="gUpmore pointer" id="gUpmoreoptionsLink" onclick="javascript:flip('gUpMoreOptionsContent'); toggleImage(document.getElementById('moreOptionArrow'),'iArrowGreyDown.png');return false;">{tr}mais opções{/tr} <img id="moreOptionArrow" src="styles/estudiolivre/iArrowGreyLeft.png"> </a>{/tooltip}<br/>
      <div style="display:none" id="gUpMoreOptionsContent">
      	{include file="el-gallery_metadata.tpl"}
      </div>
    </div>
    
     <br style="clear:both; line-height:20px;">
    
    <div id="save-exit">
       <img src="styles/estudiolivre/bPublicar.png" class="pointer" onClick="checkWaiting('xajax_check_publish()')"/>
    </div>


  </div>
  
</div>

{include file="el-gallery_publish.tpl"}
{include file="el-gallery_error.tpl"}
<div id="errorDiv" style="display:none; width:200px"></div>

{if $restore > -1}
	<script language="JavaScript">restoreForm({$pending.$restore.arquivoId}, '{$pending.$restore.tipo}', '{$pending.$restore.arquivo}', '{$pending.$restore.thumbnail}');flip('fileAltered');</script>
{/if}
<!-- el-gallery_upload_general.tpl end -->
