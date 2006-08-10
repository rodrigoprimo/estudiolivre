<div id="gListItem">

  <div id="gLicenseThumbContainer">
    <div id="gLicense">
     {tooltip name="list-descricao-licenca" text=$arquivo.descricaoLicenca}<a href="{$arquivo.linkHumanReadable}"><img src="styles/estudiolivre/{$arquivo.linkImagem}"></a>{/tooltip}
    </div>
    <div id="gThumb">
	  <a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}">
      {if $arquivo.thumbnail}
		  <img height="51" src="repo/{$arquivo.thumbnail}">
	  {else}
		  <img height="51" src="styles/estudiolivre/iThumb{$arquivo.tipo}.png">
      {/if}
      </a>
    </div>
  </div>

  <div id="gTagsInformationContainer">
    <div id="gInformation">
      <div id="gNameAuthor">
        <div id="gName">
	 	
	    {tooltip name="list-clique-pag-arquivo" text="Clique para ir para a página do arquivo"}
	      <a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}">
	        {$arquivo.titulo}
	      </a>
	    {/tooltip}
	    
	    </div>
	
	<div id="gAuthor">
	
	{tr}por{/tr}: <a href="el-user.php?view_user={$arquivo.user}">{$arquivo.user}</a> {tr}em{/tr}: {$arquivo.data_publicacao|date_format:"%d/%m/%Y"}
	
	</div>
	
      </div>
      
      <div id="gDownloadRating">
        <div id="gDownloadPlay">
          <div id="gDownload">
	  		<span class="gDownloadCount">{$arquivo.hits}</span>
		    {tooltip name="list-baixe-arquivo" text="Copie o arquivo (para o seu computador)"}
		      <a href="el-download.php?arquivo={$arquivo.arquivoId}&action=download">
		        <img alt="" src="styles/estudiolivre/iDownload.png">
		      </a>
		    {/tooltip}
		  </div>

		  <div id="gPlay">
		  	{if $arquivo.tipo eq "Video"}
		  		{if preg_match("/.*\.ogg$/i", $arquivo.arquivo)}
			    	{assign var=tooltipText value="{tr}Assista a esse vídeo{/tr}"}
			    {/if}
		    {elseif $arquivo.tipo eq "Audio"}
		    	{if preg_match("/.*\.ogg$/i", $arquivo.arquivo)}
			    	{assign var=tooltipText value="{tr}Ouça essa música{/tr}"}
			    {/if}
		    {elseif $arquivo.tipo eq "Imagem"}
		    	{if !preg_match("/.*\.svg$/i", $arquivo.arquivo)}
			    	{assign var=tooltipText value="{tr}Veja essa imagem{/tr}"}
			    {/if}
		    {/if}
		    {if $tooltipText}
		    	<span class="gStreamCount">{$arquivo.streamHits}</span>
		    	{tooltip name="list-i-play" text=$tooltipText}
			    	<img class="pointer" alt="" src="styles/estudiolivre/iPlay.png" onClick="xajax_streamFile({$arquivo.arquivoId}, '{$arquivo.tipo}', getPageSize()[0])">
			    {/tooltip}
		    {else}
   		    	<div style="width:19px">&nbsp;</div>
		    {/if}
		    
		  </div>
        </div>
      
        <div id="gRatingComments">
          <div id="gRating">
	    {tooltip name="list-avaliacao-votar" text="Avaliação - entre na página do arquivo para votar"}<img alt="{$arquivo.rating} estrelas" src="styles/estudiolivre/star{math equation="round(x)" x=$arquivo.rating|default:"blk"}.png">{/tooltip}
	  </div>
	  <div id="gComments">
	    {if $arquivo.commentsCount == 0}
	    	{tooltip name="list-primeiro-comentar" text="Seja o primeiro a comentar sobre esse arquivo"}<a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}#comments">0 {tr}comentários{/tr}</a>{/tooltip}
	    {else}
	    	{tooltip name="list-ler-comentarios" text="Clique para ler os comentários"}<a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}#comments">{$arquivo.commentsCount} {tr}comentário{/tr}{if $arquivo.commentsCount != 1}s{/if}</a>{/tooltip}
	    {/if}
	  </div>
        </div>
      </div>
      
    </div>
    
    <div id="gTags">
    {foreach from=$arquivo.tags.data item=t name=tags}
      {tooltip text="Clique para ver outros arquivos com a tag <b>"|cat:$t.tag|cat:"</b>"}<a href="tiki-browse_freetags.php?tag={$t.tag}">{$t.tag}</a>{if not $smarty.foreach.tags.last},{/if}{/tooltip}
    {foreachelse}
      {tooltip text="Esse arquivo não tem tags"}<div>&nbsp;</div>{/tooltip}
    {/foreach}
   </div>
  </div>
  
  <div id="gEditDelete">
    {if $arquivo.user eq $user or $el_p_admin_gallery eq "y"}
      {tooltip name="list-editar-informacoes-arquivo" text="Editar informações do arquivo"}<a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}"><img src="styles/estudiolivre/iEdit.png"></a>{/tooltip}
      <br>
      {tooltip name="list-apagar-arquivo-acervo" text="Apagar esse arquivo do acervo"}<img class="pointer" onClick="deleteFile({$arquivo.arquivoId}, {$dontAskDelete}, 0);" src="styles/estudiolivre/iDelete.png">{/tooltip}
    {/if}
  </div>  
</div>
