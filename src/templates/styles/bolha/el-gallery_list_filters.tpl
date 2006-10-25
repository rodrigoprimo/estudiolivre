{css}
<!-- List Options Begin -->
<table id="listOptions">
<tr>
<!-- Filters Begin -->
	<td class="left">
		
		{tooltip  text="Visualizar áudios"}
			<img id="Audio" name="filterButton" class="pointer" alt="audio" src="styles/{$style|replace:".css":""}/img/iAudioFilter{if !in_array('Audio', $tipos)}Off{/if}.png" onClick="toggleFilter(this)"/>
		{/tooltip}
		
		{tooltip  text="Visualizar videos"}
			<img id="Video" name="filterButton" class="pointer" alt="video" src="styles/{$style|replace:".css":""}/img/iVideoFilter{if !in_array('Video', $tipos)}Off{/if}.png" onClick="toggleFilter(this)"/>
		{/tooltip}
		
		{tooltip  text="Visualizar imagems"}
			<img id="Imagem" name="filterButton" class="pointer" alt="imagem" src="styles/{$style|replace:".css":""}/img/iImagemFilter{if !in_array('Imagem', $tipos)}Off{/if}.png" onClick="toggleFilter(this)"/>
		{/tooltip}
		
		{tooltip  text="Visualizar textos"}
			<img id="Texto" name="filterButton" class="pointer" alt="texto" src="styles/{$style|replace:".css":""}/img/iTextoFilter{if !in_array('Texto', $tipos)}Off{/if}.png" onClick="toggleFilter(this)"/>
		{/tooltip}
		
		{tooltip  text="Visualizar todos os ítens"}
			<img id="Tudo" class="pointer" alt="tudo" src="styles/{$style|replace:".css":""}/img/iTudoFilter{if count($tipos) < 4}Off{/if}.png" onClick="toggleAll()"/>
		{/tooltip}
	
	</td>
<!-- Filters End -->

	<td><div  id="listNav">{include file="el-gallery_pagination.tpl"}</div></td>
  
    <td id="listOrder" class="right">
      {tooltip name="home-crescente-decrescente" text="Define ordenação crescente ou decrescente"}<img alt="" onClick="toggleSortArrow(this,'{if $sortDirection eq 'Up'}sortArrowDown.png{else}sortArrowUp.png{/if}')" 
      	   src="styles/{$style|replace:".css":""}/img/sortArrow{$sortDirection}.png" />{/tooltip}
      {tooltip name="home-criterio-ordenacao" text="Modifica critério da ordenação"}
	      <select style="decoration:none" onChange="setSortMode(this)">
	        <option value="data_publicacao" {if $sortMode eq 'data_publicacao'}selected{/if}>{tr}Date{/tr}</option>
			<option value="rating" {if $sortMode eq 'rating'}selected{/if}>{tr}Estrelas{/tr}</option>
			<option value="hits" {if $sortMode eq 'hits'}selected{/if}>{tr}Downloads{/tr}</option>
			<option value="titulo" {if $sortMode eq 'titulo'}selected{/if}>{tr}Título{/tr}</option>
			<option value="streamHits" {if $sortMode eq 'streamHits'}selected{/if}>{tr}Visualizações{/tr}</option>
	      </select>
      {/tooltip}
    </td>
    
</tr>
</table>

<!-- List Options End -->