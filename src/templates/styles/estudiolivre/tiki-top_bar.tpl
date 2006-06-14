<!-- tiki-top_bar.tpl begin -->
<div id="tiki-top">
<img src="styles/estudiolivre/mainTop.png">

<div id="topContainer">
  <div id="logo">
    <a href="/">
      {tooltip name="navegue-home" text="Navegue para a home do EstúdioLivre"}<img src="styles/estudiolivre/logoTop.png">{/tooltip}
    </a>
  </div>
  
  <script language="JavaScript" src="lib/js/busca.js"></script>

  <div id="search" onLoad="marcaBusca(getCookie('busca'));">
    <form id='form-busca' class="searchForm" method="get" action="tiki-searchresults.php" {if $category eq 'gallery'}onSubmit="xajax_get_files(tipos, 0, 5, sortMode+sortDirection, '', this.highlight.value); findValue = this.highlight.value; return false;"{/if}>
      <input type="hidden" name="where" value="pages">
      <ul class="searchOptions">
        <li id="busca-wiki" class="">{tooltip name="buscar-somente" text="Buscar somente nas páginas <b>wiki</b>"}<a onclick="marcaBusca('wiki')">wiki</a>{/tooltip}</li>
        <li id="busca-acervo" class="">{tooltip name="buscar-acervo" text="Buscar no <b>acervo</b> do EstúdioLivre"}<a onclick="marcaBusca('acervo')">acervo</a>{/tooltip}</li>
        <li id="busca-forum" class="">{tooltip name="buscar-forum" text="Buscar nos <b>fóruns</b> do EstúdioLivre"}<a onclick="marcaBusca('forum')">f&oacute;rum</a>{/tooltip}</li>
      </ul>
      <input id="searchField" name="highlight" size="15" type="text" accesskey="s" value="Buscar" onFocus="this.value=''"/><input class="submit" type="image" name="search" src="styles/estudiolivre/bSearch.png"/>
{*      <a class="searchMore" href="tiki-searchresults.php">mais opções de busca <span>+</span></a> *}
    </form>
  </div>
</div>
<script language="JavaScript">marcaBusca(selectedBusca);</script>

<div id="topMenu">
  <div id="topMenuGeneral">
    {tooltip name="saiba-estudiolivre" text="Saiba <b>o que é</b> o EstúdioLivre"}<a href="tiki-index.php?page=O+que+%C3%A9">sobre</a>{/tooltip}
    | 
  	{tooltip name="forum-discussoes" text="Fórum de <b>discussões</b> - tire suas dúvidas aqui"}<a href="tiki-forums.php">fórum</a>{/tooltip}
    | 
    {tooltip name="lista-comunidade" text="Veja a lista de <b>pessoas</b> que fazem parte da comunidade"}<a href="tiki-list_users.php">usuários</a>{/tooltip}
    | 
    {tooltip text="Veja os <b>blogs</b> dos usuários do EstúdioLivre"}<a href="tiki-list_blogs.php">blogs</a>{/tooltip}
    | 
    {tooltip name="perguntas-frequentes" text="<b>Perguntas</b> mais freqüêntes"}<a href="tiki-list_faqs.php">faq</a>{/tooltip}
    | 
    {tooltip name="entre-contato" text="Entre em contato - descubra os <b>canais de comunicação</b> com a comunidade"}<a href="tiki-index.php?page=Contato">contato</a>{/tooltip}
  </div>
  <div id="topMenuCubesContainer"><ul id="topMenuCubes">

      <li><div class="hiddenDescript" id="metareciclagem">metareciclagem</div><a href="http://xango.metareciclagem.org/"><img src="styles/estudiolivre/cubeBlue.png"></a></li>
    {if $category eq "gallery"}
      <li><img src="styles/estudiolivre/cubeGrey.png"></li>
    {else}
      <li><div class="hiddenDescript" id="acervolivre">acervo.livre</div><a href="el-gallery_home.php"><img src="styles/estudiolivre/cubeGreen.png"></a></li>
    {/if}

    {if $category eq "Áudio"}
      <li><img src="styles/estudiolivre/cubeGrey.png"></li>
    {else}
      <li><div class="hiddenDescript" id="audiolab">áudio||lab</div><a href="tiki-index.php?page=Áudio"><img src="styles/estudiolivre/cubeOrange.png"></a></li>
    {/if}

    {if $category eq "Vídeo"}
      <li><img src="styles/estudiolivre/cubeGrey.png"></li>
    {else}
      <li><div class="hiddenDescript" id="videolab">vídeo||lab</div><a href="tiki-index.php?page=Vídeo"><img src="styles/estudiolivre/cubeRed.png"></a></li>
    {/if}
    
    {if $category eq "Gráfico"}
      <li><img src="styles/estudiolivre/cubeGrey.png"></li>
    {else}
      <li><div class="hiddenDescript" id="grafilab">grafi||lab</div><a href="tiki-index.php?page=Gráfico"><img src="styles/estudiolivre/cubePurple.png"></a></li>
    {/if}
    
  </ul></div>
</div>
</div>

<!-- tiki-top_bar.tpl end -->
