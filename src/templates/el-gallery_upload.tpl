<!-- el-gallery_upload_general.tpl begin -->

<script language="JavaScript" src="lib/elgal/upload.js"></script>

<div id="gUpload">
  <div id="gUpLeft">
    <div id="gUpIcons">
      {* Aqui terá um JS que colore o ícone selecionado e deixa os outros preto e branco *}
      <div class="gUpIcon">
        <img id="iconeAudio" onMouseOver="acendeTipo('Audio');" onMouseOut="apagaTipo('Audio')" onClick="selecionaTipo('Audio')" alt="" src="styles/estudiolivre/iUpAudioOff.png"><br />
        Áudio
      </div>
    
      <div class="gUpIcon">
        <img id="iconeImagem" onMouseOver="acendeTipo('Imagem');" onMouseOut="apagaTipo('Imagem')" onClick="selecionaTipo('Imagem')" alt="" src="styles/estudiolivre/iUpImageOff.png"><br />
        Imagem
      </div>
    
      <div class="gUpIcon">
        <img id="iconeTexto" onMouseOver="acendeTipo('Texto');" onMouseOut="apagaTipo('Texto')" onClick="selecionaTipo('Texto')" alt="" src="styles/estudiolivre/iUpTextOff.png"><br />
        Texto
      </div>
    
      <div class="gUpIcon">
        <img id="iconeVideo" onMouseOver="acendeTipo('Video');" onMouseOut="apagaTipo('Video')" onClick="selecionaTipo('Video')" alt="" src="styles/estudiolivre/iUpVideoOff.png"><br />
        Video
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
   	   	    <input type="file" name="arquivo" onChange="changeStatus(this.value);">
   	      </form>
         </div>
   
     </div>
      
    </div>
    
    
  </div>
  
  <form>
  <div id="gUpRight" style="display: none">
    <div id="gUpEditThumbTitleAuthor">
      <div id="gUpThumb">
        <img id="thumbnail" alt="" height="60" width="60" src="" >
      </div>

      <div id="gUpTitleAuthor">
        {ajax_input class="gUpTitle gUpEdit" id="titulo" value=$arquivo.titulo default="Titulo" display="inline"}
		<div id="gUpAuthor">
		  	Por {ajax_input class="gUpAuthor gUpEdit" id="autor" value=$online_user.realName default="Autor da obra" display="inline" mode="edit"}
		</div>
      </div>
      
    </div>
    <br style="line-height:30px;">
    <div id="gUpDescription">
	     {ajax_textarea class="gUpEditDescription" id="descricao" value=$arquivo.descricao default="Descrição da sua obra" display="block"}
    </div>
    
    <br style=" line-height:20px;">
    
    <div id="gUpEditTags">
      {if $feature_freetags eq 'y' && $tiki_p_freetags_tag eq 'y'}
        <span>Tags</span>
	{* O ideal eh que tenha suggest aqui nesse campo *}
	{ajax_input class="freetags" id="tags" value="$taglist"}<br>
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
  </form>
  
</div>

<!-- el-gallery_upload_general.tpl end -->

