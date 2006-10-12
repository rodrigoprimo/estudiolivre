{css}
<!-- List Options Begin -->
<div id="listOptions">

<!-- Filters Begin -->
	<div id="listFilters">

		<ul class="listFiltersButtons">
			
			<img id="listFilterImg0" alt="" src="styles/{$style|replace:".css":""}/img/bLeftInac.png" />
			{tooltip name="home-fitrar-audio" text="Filtrar arquivos de áudio"}
				<li id="listFilterBut0" class="buttonInactive" onClick="toggleFilter(this, 0, 'Audio')">
					<a>{tr}áudio{/tr}</a>
				</li>
			{/tooltip}
			
			<img id="listFilterImg1" alt="" src="styles/{$style|replace:".css":""}/img/bInac2Inac.png" style="display:none"/>
			{tooltip name="home-filtrar-imagens" text="Filtrar imagens"}
				<li id="listFilterBut1" class="buttonInactive" onClick="toggleFilter(this, 1, 'Imagem')">
					<a>{tr}gráfico{/tr}</a>
				</li>
			{/tooltip}

			<img id="listFilterImg2" alt="" src="styles/{$style|replace:".css":""}/img/bInac2Inac.png" style="display:none"/>
			{tooltip name="home-filtrar-videos" text="Filtrar arquivos de vídeo"}
				<li id="listFilterBut2" class="buttonInactive" onClick="toggleFilter(this, 2, 'Video')">
					<a>{tr}vídeo{/tr}</a>
				</li>
			{/tooltip}

			<img id="listFilterImg3" alt="" src="styles/{$style|replace:".css":""}/img/bInac2Inac.png" style="display:none"/>
			{tooltip name="home-filtrar-textos" text="Filtrar textos"}
				<li id="listFilterBut3" style="border-right:0px solid gray;" class="buttonInactive buttonInactiveRight" onClick="toggleFilter(this, 3, 'Texto')">
					<a>{tr}texto{/tr}</a>
				</li>
			{/tooltip}

			<img id="listFilterImg4" alt="" src="styles/{$style|replace:".css":""}/img/bRightInac.png" />

		</ul>
	</div>
<!-- Filters End -->

  
  <div id="rightContainerTop">
    <div id="listOrder">
      {tooltip name="home-crescente-decrescente" text="Define ordenação crescente ou decrescente"}<img alt="" onClick="toggleSortArrow(this,'{if $sortDirection eq 'Up'}sortArrowDown.png{else}sortArrowUp.png{/if}')" 
      	   src="styles/{$style|replace:".css":""}/img/sortArrow{$sortDirection}.png" />{/tooltip}
      {tooltip name="home-criterio-ordenacao" text="Modifica critério da ordenação"}<select style="decoration:none" onChange="setSortMode(this)">
        <option value="data_publicacao" {if $sortMode eq 'data_publicacao'}selected{/if}>{tr}Date{/tr}</option>
		<option value="rating" {if $sortMode eq 'rating'}selected{/if}>{tr}Estrelas{/tr}</option>
		<option value="hits" {if $sortMode eq 'hits'}selected{/if}>{tr}Downloads{/tr}</option>
		<option value="titulo" {if $sortMode eq 'titulo'}selected{/if}>{tr}Título{/tr}</option>
		<option value="streamHits" {if $sortMode eq 'streamHits'}selected{/if}>{tr}Visualizações{/tr}</option>
      </select>{/tooltip}
    </div>
    <div  id="listNav">
    	{include file="el-gallery_pagination.tpl"}
    </div>
  </div>
</div>

<!-- List Options End -->