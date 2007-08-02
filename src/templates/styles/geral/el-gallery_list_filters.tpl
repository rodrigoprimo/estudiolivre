{css extra=el-gallery_pagination}
<!-- List Options Begin -->
<table id="listOptions">
<tr>
<!-- Filters Begin -->
	<td class="left">
		 {tr}filtros:{/tr}<br/>
		{tooltip  text="Alternar visualização de áudios"}
			<span id="Audio" name="filterButton"  alt="audio" style="{if !in_array('Audio', $tipos)}color:#888888{/if}" onClick="toggleFilter(this)">{tr}audio{/tr}</span>
			<img id="Audio" name="filterButton" class="pointer" alt="audio" src="styles/{$style|replace:".css":""}/img/iAudioFilter{if !in_array('Audio', $tipos)}Off{/if}.png" onClick="toggleFilter(this)"/>
		{/tooltip}
		
		{tooltip  text="Alternar visualização de vídeos"}
			<span id="Video" name="filterButton"  alt="video" style="{if !in_array('Video', $tipos)}color:#888888{/if}" onClick="toggleFilter(this)">{tr}video{/tr}</span>
			<img id="Video" name="filterButton" class="pointer" alt="video" src="styles/{$style|replace:".css":""}/img/iVideoFilter{if !in_array('Video', $tipos)}Off{/if}.png" onClick="toggleFilter(this)"/>
		{/tooltip}
		
		{tooltip  text="Alternar visualização de imagens"}
			<span id="Imagem" name="filterButton" alt="imagem" style="{if !in_array('Imagem', $tipos)}color:#888888{/if}" onClick="toggleFilter(this)">{tr}imagem{/tr}</span>
			<img id="Imagem" name="filterButton" class="pointer" alt="imagem" src="styles/{$style|replace:".css":""}/img/iImagemFilter{if !in_array('Imgem', $tipos)}Off{/if}.png" onClick="toggleFilter(this)"/>
		{/tooltip}
		
		{tooltip  text="Alternar visualização de textos"}
			<span id="Texto" name="filterButton"  alt="texto" style="{if !in_array('Texto', $tipos)}color:#888888{/if}" onClick="toggleFilter(this)">{tr}texto{/tr}</span>
			<img id="Texto" name="filterButton" class="pointer" alt="texto" src="styles/{$style|replace:".css":""}/img/iTextoFilter{if !in_array('Texto', $tipos)}Off{/if}.png" onClick="toggleFilter(this)"/>
		{/tooltip}
		
		{tooltip  text="Alternar visualização entre todos/nenhum item"}
			<span id="Tudo" name="filterButton" class="pointer" alt="Tudo" style="{if !in_array('Tudo', $tipos)}color:#888888{/if}" onClick="toggleFilter(this)">{tr}tudo{/tr}</span>
			<img id="Tudo" class="pointer" alt="tudo" src="styles/{$style|replace:".css":""}/img/iTudoFilter{if count($tipos) < 4}Off{/if}.png" onClick="toggleAll()"/>
		{/tooltip}
	
	</td>
<!-- Filters End -->
</tr>
<tr>
	<td><div id="ajax-listNav" class="listNav">{include file="el-gallery_pagination.tpl"}</div></td>
  
    <td id="listOrder" class="right">
      {tooltip name="home-crescente-decrescente" text="Define ordenação crescente ou decrescente"}<img alt="" onClick="toggleSortArrow(this,'{if $sortDirection eq 'Up'}sortArrowDown.png{else}sortArrowUp.png{/if}')" 
      	   src="styles/{$style|replace:".css":""}/img/sortArrow{$sortDirection}.png" />{/tooltip}
      {tooltip name="home-criterio-ordenacao" text="Modifica critério da ordenação"}
	      <select style="decoration:none" onChange="setSortMode(this)">
	        <option value="publishDate" {if $sortMode eq 'publishDate'}selected{/if}>{tr}Date{/tr}</option>
			<option value="rating" {if $sortMode eq 'rating'}selected{/if}>{tr}Estrelas{/tr}</option>
			<option value="downloads" {if $sortMode eq 'downloads'}selected{/if}>{tr}Downloads{/tr}</option>
			<option value="title" {if $sortMode eq 'title'}selected{/if}>{tr}Título{/tr}</option>
			<option value="streams" {if $sortMode eq 'streams'}selected{/if}>{tr}Visualizações{/tr}</option>
	      </select>
      {/tooltip}
    </td>
    
</tr>
</table>

<!-- List Options End -->