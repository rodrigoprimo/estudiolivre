<div id="gListItem">

  <div id="gLicenseThumbContainer">
    <div id="gLicense">
     <img src="styles/estudiolivre/iLicense.png">
    </div>
    <div id="gThumb">
      {if sizeof($arquivo.thumbnail)}
        <a href="el-gallery_manage.php?arquivoId={$arquivo.arquivoId}&action=view">
	  <img height="50" src="el-download.php?arquivo={$arquivo.arquivoId}&thumbnail=1">
	</a>
      {/if}
    </div>
  </div>

  <div id="gTagsInformationContainer">
    <div id="gInformation">
      <div id="gNameAuthor">
        <div id="gName">
	 	
	  <a href="el-gallery_manage.php?arquivoId={$arquivo.arquivoId}&action=view">
	    {$arquivo.nomeArquivo}
	  </a>
	 
	</div>
	
	<div id="gAuthor">
	
	por {$arquivo.user|userlink} em {$arquivo.data_publicacao|date_format:"%d/%m/%Y"}
	
	</div>
	
      </div>
      
      <div id="gDownloadRating">
        <div id="gDownloadPlay">

          <div id="gDownload">
	    <a href="#">
	      <img alt="" src="styles/estudiolivre/iDownload.png">
	    </a>
	  </div>

	  <div id="gPlay">
	    <a href="#">
	      <img alt="" src="styles/estudiolivre/iPlay.png">
	    </a>
	  </div>

        </div>
      
        <div id="gRatingComments">
          <div id="gRating">
	    <img alt="{$arquivo.rating} estrelas" src="styles/estudiolivre/star{math equation="round(x)" x=$arquivo.rating|default:"blk"}.png">
	  </div>
	  <div id="gComments">
	    <a href="el-gallery_manage.php?arquivoId={$arquivo.arquivoId}&action=view#comments">{$arquivo.commentsCount} comentário{if $arquivo.commentsCount != 1}s{/if}</a>
	  </div>
        </div>
      </div>
      
    </div>
    
    <div id="gTags">
    {foreach from=$arquivo.tags.data item=t}
      <a href="tiki-browse_freetags.php?tag={$t.tag}">{$t.tag}</a> 
    {foreachelse}
      &nbsp;
    {/foreach}
    </div>
  </div>
  
  <div id="gEditDelete">
    {if $arquivo.user eq $user}
      <a href="el-gallery_manage.php?arquivoId={$arquivo.arquivoId}&action=edit"><img alt="editar" src="styles/estudiolivre/iEdit.png"></a>
      <br>
      <a href="el-gallery_manage.php?arquivoId={$arquivo.arquivoId}&action=delete"><img alt="apagar" src="styles/estudiolivre/iDelete.png"></a>
    {/if}
  </div>
  
   {if $user}
   {section name=rating start=1 loop=6 step=1}
       {if $arquivo.user_rating && $arquivo.user_rating >= $smarty.section.rating.index}
         <img id="rt-{$arquivo.arquivoId}-{$smarty.section.rating.index}" src="styles/estudiolivre/rt_{$arquivo.user_rating}.png" border="0" onClick="acervoVota({$arquivo.arquivoId},{$smarty.section.rating.index})">
       {else}   
         <img id="rt-{$arquivo.arquivoId}-{$smarty.section.rating.index}" src="styles/estudiolivre/rt_blk.png" border="0" onClick="acervoVota({$arquivo.arquivoId},{$smarty.section.rating.index})">
       {/if}
   {/section}<br />
   {/if}
  
</div>


{*

<div class="el-list-branco">
        <div class="el-thumbnail">
      
        </div>
        <div class="el-file-info">
        
       
     {if $arquivo.tipo eq 'Audio'}
        <object type="application/x-shockwave-flash" data="styles/estudiolivre/musicplayer.swf?&song_url=repo/{$arquivo.arquivo}" width="17" height="17"></object>
     {/if}
        <br />
        <span style="vertical-align:top">licença:</span>
	
	&nbsp;<a href="{$arquivo.link_human_readable}">
	
	<img border="0" src="{$arquivo.link_imagem}"/></a>
        </div>
        <div class="el-file-info2">
        {$arquivo.formato}, {$arquivo.tamanho|show_filesize}<br/>
        <br/>
 


      
        </div>
        
  </div> *}
