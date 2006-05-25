<!-- tiki-top_bar.tpl begin -->
<div id="tiki-top">
<img src="styles/estudiolivre/mainTop.png">

<div id="topContainer">
  <div id="logo">
    <a href="/">
      {tooltip text="Navegue para a home do EstúdioLivre"}<img src="styles/estudiolivre/logoTop.png">{/tooltip}
    </a>
  </div>
  
  <script language="JavaScript" src="lib/elgal/busca.js"></script>

  <div id="search">
    <form id='form-busca' class="searchForm" method="get" action="tiki-searchresults.php" >
      <input type="hidden" name="where" value="pages">
      <ul class="searchOptions">
        <li id="busca-wiki" class="">{tooltip text="Buscar somente nas páginas <b>wiki</b>"}<a onclick="marcaBusca('wiki')">wiki</a>{/tooltip}</li>
        <li id="busca-acervo" class="">{tooltip text="Buscar no <b>acervo</b> do EstúdioLivre"}<a onclick="marcaBusca('acervo')">acervo</a>{/tooltip}</li>
        <li id="busca-forum" class="">{tooltip text="Buscar nos <b>fóruns</b> do EstúdioLivre"}<a onclick="marcaBusca('forum')">f&oacute;rum</a>{/tooltip}</li>
      </ul>
      <input id="searchField" name="highlight" size="15" type="text" accesskey="s" value="Buscar" onFocus="this.value=''" /><input class="submit" type="image" name="search" src="styles/estudiolivre/bSearch.png">
{*      <a class="searchMore" href="tiki-searchresults.php">mais opções de busca <span>+</span></a> *}
    </form>
  </div>
</div>
<script language="JavaScript">marcaBusca(selectedBusca);</script>

<div id="topMenu">
  <div id="topMenuGeneral">
    {tooltip text="Saiba o que é o EstúdioLivre"}<a href="tiki-index.php?page=O+que+%C3%A9">sobre</a>{/tooltip}
    | 
  	{tooltip text="Fórum de discussões - tire suas dúvidas aqui"}<a href="tiki-forums.php">fórum</a>{/tooltip}
    | 
    {tooltip text="Veja a lista de pessoas que fazem parte da comunidade"}<a href="tiki-list_users.php">usuários</a>{/tooltip}
    | 
    {tooltip text="Perguntas mais freqüêntes"}<a href="tiki-list_faqs.php">faq</a>{/tooltip}
    | 
    {tooltip text="Entre em contato - descubra os canais de comunicação com a comunidade"}<a href="tiki-index.php?page=Contato">contato</a>{/tooltip}
  </div>
  <div id="topMenuCubesContainer"><ul id="topMenuCubes">

      <li><div class="hiddenDescript" id="metareciclagem">metareciclagem</div><a href="http://xango.metareciclagem.org/"><img src="styles/estudiolivre/cubeBlue.png"></a></li>
    {if $style eq "estudiolivre_biblio.css"}
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
