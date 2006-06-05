<div id="gListItem">

  <div id="gLicenseThumbContainer">
    <div id="gLicense">
     {tooltip name="list-descricao-licenca" text=$arquivo.descricaoLicenca}<a href="{$arquivo.linkHumanReadable}"><img src="styles/estudiolivre/{$arquivo.linkImagem}"></a>{/tooltip}
    </div>
    <div id="gThumb">
	  <a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}">
      {if sizeof($arquivo.thumbnail)}
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
	 	
	  {tooltip name="list-clique-pag-arquivo" text="Clique para ir para a página do arquivo"}<a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}">
	    {$arquivo.nomeArquivo}
	  </a>{/tooltip}
	 
	</div>
	
	<div id="gAuthor">
	
	por {$arquivo.user|userlink} em {$arquivo.data_publicacao|date_format:"%d/%m/%Y"}
	
	</div>
	
      </div>
      
      <div id="gDownloadRating">
        <div id="gDownloadPlay">
          <div id="gDownload">
	  		<span class="gDownloadCount">{$arquivo.hits}</span>
		    {tooltip name="list-baixe-arquivo" text="Baixe esse arquivo"}<a href="#">
		      <img alt="" src="styles/estudiolivre/iDownload.png">
		    </a>{/tooltip}
		  </div>

		  <div id="gPlay">
		  	<span class="gStreamCount">--</span>
		    {if $arquivo.tipo eq "Video"}
		    	{assign var=tooltipText value="Assita esse vídeo"}
		    {else}
		    	{if $arquivo.tipo eq "Audio"}
		    		{assign var=tooltipText value="Ouça essa música"}
		    	{/if}
		    {/if}
		    {if $tooltipText}
		    	{tooltip name="list-i-play" text=$tooltipText}
				    <a href="#">
				      <img alt="" src="styles/estudiolivre/iPlay.png">
				    </a>
			    {/tooltip}
		    {/if}
		  </div>
        </div>
      
        <div id="gRatingComments">
          <div id="gRating">
	    {tooltip name="list-avaliacao-votar" text="Avaliação - entre na página do arquivo para votar"}<img alt="{$arquivo.rating} estrelas" src="styles/estudiolivre/star{math equation="round(x)" x=$arquivo.rating|default:"blk"}.png">{/tooltip}
	  </div>
	  <div id="gComments">
	    {if $arquivo.commentsCount == 0}
	    	{tooltip name="list-primeiro-comentar" text="Seja o primeiro a comentar sobre esse arquivo"}<a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}#comments">nenhum comentário</a>{/tooltip}
	    {else}
	    	{tooltip name="list-ler-comentarios" text="Clique para ler os comentários"}<a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}#comments">{$arquivo.commentsCount} comentário{if $arquivo.commentsCount != 1}s{/if}</a>{/tooltip}
	    {/if}
	  </div>
        </div>
      </div>
      
    </div>
    
    {tooltip name="list-tags-arquivo" text="Tags desse arquivo"}<div id="gTags">
    {foreach from=$arquivo.tags.data item=t}
      <a href="tiki-browse_freetags.php?tag={$t.tag}">{$t.tag}</a>,
    {foreachelse}
      &nbsp;
    {/foreach}
    </div>{/tooltip}
  </div>
  
  <div id="gEditDelete">
    {if $arquivo.user eq $user}
      {tooltip name="list-editar-informacoes-arquivo" text="Editar informações do arquivo"}<a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}"><img alt="editar" src="styles/estudiolivre/iEdit.png"></a>{/tooltip}
      <br>
      {tooltip name="list-apagar-arquivo-acervo" text="Apagar esse arquivo do acervo"}<a href="el-gallery_delete.php?arquivoId={$arquivo.arquivoId}"><img alt="apagar" src="styles/estudiolivre/iDelete.png"></a>{/tooltip}
    {/if}
  </div>
  
   {* if $user}
   {section name=rating start=1 loop=6 step=1}
       {if $arquivo.user_rating && $arquivo.user_rating >= $smarty.section.rating.index}
         <img id="rt-{$arquivo.arquivoId}-{$smarty.section.rating.index}" src="styles/estudiolivre/rt_{$arquivo.user_rating}.png" border="0" onClick="acervoVota({$arquivo.arquivoId},{$smarty.section.rating.index})">
       {else}   
         <img id="rt-{$arquivo.arquivoId}-{$smarty.section.rating.index}" src="styles/estudiolivre/rt_blk.png" border="0" onClick="acervoVota({$arquivo.arquivoId},{$smarty.section.rating.index})">
       {/if}
   {/section}<br />
   {/if *}
  
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
