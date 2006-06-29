<!-- tiki-top_bar.tpl begin -->
<div id="tiki-top">
  <div id="topContainer">
  	{* Logo TESTE *}
  	 <a href="http://dev.estudiolivre.org/tiki-view_tracker.php?status=o&trackerId=13&offset=0&sort_mode=created_desc">
  	  {tooltip text="Clique aqui e <b>relate os bugs</b> encontrados! Ajude-nos a <b>melhorar</b> o EstúdioLivre!!!"}<img src="styles/estudiolivre/faixaTeste.{if $isIE}gif{else}png{/if}" style="position:absolute; top:-25px; left:0px; z-index:5"/>{/tooltip}
  	 </a>
  	<div id="logo">
      <a href="/">
        {tooltip name="navegue-home" text="Ir para a Página Inicial"}
          <img src="styles/estudiolivre/logoTop.png">
        {/tooltip}
      </a>
    </div>
  
    <script language="JavaScript" src="lib/js/busca.js"></script>

  <div id="search" onLoad="marcaBusca(getCookie('busca'));">
    <form id='form-busca' name="searchForm" class="searchForm" method="get" action="tiki-searchresults.php" onSubmit="busca('{$category}', this.highlight.value); return false;">
      <input type="hidden" name="where" value="pages">
      <ul class="searchOptions">
        <li id="busca-wiki" class="">{tooltip name="buscar-somente" text="Buscar somente nas páginas <b>wiki</b>"}<a onclick="marcaBusca('wiki')">wiki</a>{/tooltip}</li>
        <li id="busca-gallery" class="">{tooltip name="buscar-acervo" text="Buscar no <b>acervo</b> do EstúdioLivre"}<a onclick="marcaBusca('gallery')">acervo</a>{/tooltip}</li>
        <li id="busca-usuarios" class="">{tooltip text="Buscar <b>usuári@s</b> do EstúdioLivre"}<a onclick="marcaBusca('usuarios')">usu&aacute;rio</a>{/tooltip}</li>
		<li id="busca-tags" class="">{tooltip text="Buscar conteúdos com uma <b>tag</b>"}<a onclick="marcaBusca('tags')">tag</a>{/tooltip}</li>
		<li id="busca-blogs" class="">{tooltip text="Buscar <b>blogs</b> do EstúdioLivre"}<a onclick="marcaBusca('blogs')">blog</a>{/tooltip}</li>
     {* <li id="busca-forum" class="">{tooltip name="buscar-forum" text="Buscar nos <b>fóruns</b> do EstúdioLivre"}<a onclick="marcaBusca('forum')">f&oacute;rum</a>{/tooltip}</li>
      *}
      </ul>
      <input id="searchField" name="highlight" size="15" type="text" accesskey="s" value="Buscar" onFocus="limpaBusca(this);"/><input class="submit" type="image" name="search" src="styles/estudiolivre/bSearch.png"/>
{*      <a class="searchMore" href="tiki-searchresults.php">mais opções de busca <span>+</span></a> *}
    </form>
  </div>
</div>
<script language="JavaScript">marcaBusca(selectedBusca);</script>

<div id="topMenu">
  <div id="topMenuGeneral">
    {tooltip name="saiba-estudiolivre" text="Saiba <b>o que é</b> o EstúdioLivre"}<a href="tiki-index.php?page=sobre">sobre</a>{/tooltip}
    | 
  	{tooltip name="forum-discussoes" text="Fóruns de <b>discussões</b> - tire suas dúvidas aqui"}<a href="tiki-forums.php">fóruns</a>{/tooltip}
    | 
    {tooltip name="lista-comunidade" text="Veja a lista de <b>pessoas</b> que fazem parte da comunidade"}<a href="tiki-list_users.php">usuári@s</a>{/tooltip}
    | 
    {tooltip text="Veja os <b>blogs</b> dos usuári@s do EstúdioLivre"}<a href="tiki-list_blogs.php">blogs</a>{/tooltip}
    | 
    {tooltip name="perguntas-frequentes" text="<b>Perguntas</b> mais freqüêntes"}<a href="tiki-index.php?page=faq">faq</a>{/tooltip}
    | 
    {tooltip name="entre-contato" text="Entre em contato - descubra os <b>canais de comunicação</b> com a comunidade"}<a href="tiki-index.php?page=contato">contato</a>{/tooltip}
    
  </div>
 {* <div id="topMenuLoading">
	  <img src="styles/estudiolivre/iProgress.gif">
  </div> *}
    
	<div id="topMenuCubesContainer">
	  <ul id="topMenuCubes">
		{*
	      <li><div class="hiddenDescript" id="metareciclagem">metareciclagem</div><a href="http://xango.metareciclagem.org/"><img src="styles/estudiolivre/cubeBlue.png"></a></li>
	      *}
		
		{* Cores das Categorias *}
		
		{assign var=gallery value="Green"}
		{assign var=audio value="Orange"}
		{assign var=video value="Red"}
		{assign var=grafico value="Purple"}
		
		
	    {if $category eq "gallery"}{assign var=gallery value="Grey"}{/if}
	    <li>
	      <div class="hiddenDescript" id="acervolivre">acervo.livre</div>
	        <a href="el-gallery_home.php" {if $isIE}title="ACERVO.LIVRE"{/if}>
	          <img src="styles/estudiolivre/cube{$gallery}{if $isIE}IE{/if}.png">
	        </a>
	    </li>
	
	    {if $category eq "Áudio"}{assign var=audio value="Grey"}{/if}
	    <li>
	      <div class="hiddenDescript" id="audiolab">áudio||lab</div>
	        <a href="tiki-index.php?page=Áudio" {if $isIE}title="AUDIO||LAB"{/if}>
	          <img src="styles/estudiolivre/cube{$audio}{if $isIE}IE{/if}.png">
	        </a>
	    </li>
	
	    {if $category eq "Vídeo"}{assign var=video value="Grey"}{/if}
	    <li>
	      <div class="hiddenDescript" id="videolab">vídeo||lab</div>
	        <a href="tiki-index.php?page=Vídeo" {if $isIE}title="VIDEO||LAB"{/if}>
	          <img src="styles/estudiolivre/cube{$video}{if $isIE}IE{/if}.png">
	        </a>
	    </li>
	    
	    {if $category eq "Gráfico"}{assign var=grafico value="Grey"}{/if}
	    <li>
	    <div class="hiddenDescript" id="grafilab">grafi||lab</div>
	        <a href="tiki-index.php?page=Gráfico" {if $isIE}title="GRAFI||LAB"{/if}>
	          <img {if $isIE} {/if} src="styles/estudiolivre/cube{$grafico}{if $isIE}IE{/if}.png">
	        </a>
	    </li>
	  </ul>
	  
	</div>
</div>
</div>

<!-- tiki-top_bar.tpl end -->
