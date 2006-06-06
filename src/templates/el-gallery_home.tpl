<!-- el-gallery_home.tpl begin -->

<script language="JavaScript" src="lib/elgal/el_home.js"></script>

<!-- Feature Wiki Begin -->
<div id="gHomeWiki" {if $tiki_p_edit eq 'y'} ondblclick="location.href='tiki-editpage.php?page=destak'"{/if}>
	<span id="gHomeWikiTitle">Destaques
		{tooltip name="home-flip-destaques" text="Alternar a visualização dos destaques"}<a onclick="javascript:flip('gHomeWikiToggle');return false;" href="#">
			<img onclick="this.toggleImage('iGreenArrowLeft.png');" src="styles/estudiolivre/sortArrowDown.png">
		</a>{/tooltip}
	</span>
	<div id="gHomeWikiToggle" style="display:block">
		{$destak}
	</div>
</div>
<!-- Feature Wiki End -->
<!-- List Options Begin -->
<div id="listOptions">

  <!-- Filters Begin -->
  <div id="listFilters">
  
    <ul id="listFiltersButtons">
    
      <img id="listFilterImg0" alt="" src="styles/estudiolivre/bLeftInac.png" />
      {tooltip name="home-fitrar-audio" text="Filtrar arquivos de áudio"}<li id="listFilterBut0" class="buttonInactive" onClick="toggleFilter(this, 0, 'Audio')">
	  áudio
      </li>{/tooltip}
      
      <img id="listFilterImg1" alt="" src="styles/estudiolivre/bInac2Inac.png" />
      {tooltip name="home-filtrar-imagens" text="Filtrar imagens"}<li id="listFilterBut1" class="buttonInactive" onClick="toggleFilter(this, 1, 'Imagem')">
	  gráfico
      </li>{/tooltip}
      
      <img id="listFilterImg2" alt="" src="styles/estudiolivre/bInac2Inac.png" />
      {tooltip name="home-filtrar-videos" text="Filtrar arquivos de vídeo"}<li id="listFilterBut2" class="buttonInactive" onClick="toggleFilter(this, 2, 'Video')">
	  vídeo
      </li>{/tooltip}
      
      <img id="listFilterImg3" alt="" src="styles/estudiolivre/bInac2Inac.png" />
      {tooltip name="home-filtrar-textos" text="Filtrar textos"}<li id="listFilterBut3" class="buttonInactive" onClick="toggleFilter(this, 3, 'Texto')">
	  texto
      </li>{/tooltip}
      
      <img id="listFilterImg4" alt="" src="styles/estudiolivre/bRightInac.png" />
      
    </ul>
  
  </div>
  <!-- Filters End -->
  
  <div id="rightContainerTop">
    <div id="listOrder">
      {tooltip name="home-crescente-decrescente" text="Define ordenação crescente ou decrescente"}<img alt="" onClick="toggleSortArrow(this,'{if $sortDirection eq 'Up'}sortArrowDown.png{else}sortArrowUp.png{/if}')" 
      	   src="styles/estudiolivre/sortArrow{$sortDirection}.png" />{/tooltip}
      {tooltip name="home-criterio-ordenacao" text="Modifica critério da ordenação"}<select style="decoration:none" onChange="setSortMode(this)">
        <option value="data_publicacao" {if $sortMode eq 'data_publicacao'}selected{/if}>Data</option>
		<option value="rating" {if $sortMode eq 'rating'}selected{/if}>Estrelas</option>
		<option value="hits" {if $sortMode eq 'hits'}selected{/if}>Downloads</option>
		<option value="titulo" {if $sortMode eq 'titulo'}selected{/if}>Título</option>
      </select>{/tooltip}
    </div>
    <div  id="listNav">
    	{include file="el-gallery_pagination.tpl"}
    </div>
  </div>
</div>
<!-- List Options End -->
<div id="gListCont">
	{include file="el-gallery_section.tpl"}
</div>

<script language="JavaScript">init('{$find}')</script>

{include file="el-player.tpl"}

<!-- el-gallery_home.tpl end -->
