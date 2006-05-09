<!-- tiki-top_bar.tpl begin -->
<div id="tiki-top">
<img src="styles/estudiolivre/mainTop.png">

<div id="topContainer">
  <div id="logo">
    <a href="/">
      <img src="styles/estudiolivre/logoTop.png">
    </a>
  </div>

  <div id="search">
    <form class="searchForm" method="get" action="tiki-searchresults.php" >
      <input type="hidden" name="where" value="pages">
      <ul class="searchOptions">
        <li class="selected"><a href="#">wiki</a></li>
        <li><a href="#">arquivos</a></li>
        <li class="selected"><a href="#">tags</a></li>
        <li><a href="#">pessoas</a></li>
      </ul>
      <input id="searchField" name="highlight" size="15" type="text" accesskey="s" value="Buscar" onFocus="this.value=''" /><input class="submit" type="image" name="search" src="styles/estudiolivre/bSearch.png">
      <a class="searchMore" href="tiki-searchresults.php">mais opções de busca <span>+</span></a>
    </form>
  </div>
</div>

<div id="topMenu">
  <div id="topMenuGeneral">
    <a href="tiki-index.php?page=O+que+%C3%A9">sobre</a>
    | 
    <a href="tiki-forums.php">fórum</a>
    | 
    <a href="tiki-list_users.php">usuários</a>
    | 
    <a href="tiki-list_faqs.php">faq</a>
    | 
    <a href="tiki-index.php?page=Contato">contato</a>
  </div>
  <ul id="topMenuCubes">

    <li><a href="http://xango.metareciclagem.org/"><img src="styles/estudiolivre/cubeBlue.png"></a></li>
    {if $style eq "estudiolivre_biblio.css"}
      <li><img src="styles/estudiolivre/cubeGrey.png"></li>
    {else}
      <li><a href="el-gallery_home.php"><img src="styles/estudiolivre/cubeGreen.png"></a></li>
    {/if}

    {if $category eq "Áudio"}
      <li><img src="styles/estudiolivre/cubeGrey.png"></li>
    {else}
      <li><a href="tiki-index.php?page=Áudio"><img src="styles/estudiolivre/cubeOrange.png"></a></li>
    {/if}

    {if $category eq "Vídeo"}
      <li><img src="styles/estudiolivre/cubeGrey.png"></li>
    {else}
      <li><a href="tiki-index.php?page=Vídeo"><img src="styles/estudiolivre/cubeRed.png"></a></li>
    {/if}
    
    {if $category eq "Gráfico"}
      <li><img src="styles/estudiolivre/cubeGrey.png"></li>
    {else}
      <li><a href="tiki-index.php?page=Gráfico"><img src="styles/estudiolivre/cubePurple.png"></a></li>
    {/if}
    
  </ul>
</div>
    

{* <div id="tiki-top-cubos" onMouseOver="balancer.start()">
  <a href="tiki-index.php"><img id="logo" src="styles/estudiolivre/logo_EL.png"></a>
  <!--<img id="delme-later" src="styles/estudiolivre/delme-later.gif">-->

  <div id="links-dinamicos">
    <a href="tiki-index.php?page=O+que+é" id="oqeh" style="top: 5px; left: 2px;"><img src="styles/estudiolivre/oqeh.png"></a><br/>
    <a href="tiki-forums.php" id="conversando" style="top: 25px; left: 50px;"><img  src="styles/estudiolivre/conversando.png"></a><br/>
    <a href="tiki-list_users.php" id="pessoas" style="top: 62px; left: 19px;"><img src="styles/estudiolivre/pessoas.png"></a><br/>
    <a href="tiki-list_faqs.php" id="faq" style="top: 110px; left: 19px;"><img src="styles/estudiolivre/perg_freq.png"></a><br/>
  </div>

  <script language="JavaScript" src="lib/elgal/el-menu.js"></script>


  <div id="links">

    <br/>
        <a href="tiki-index.php?page=Gráfico"><img src="styles/estudiolivre/logo_grafi_p.png"></a><br/>
   <a href="tiki-index.php?page=Vídeo"><img src="styles/estudiolivre/logo_video_p.png"></a><br/>
   <a href="tiki-index.php?page=Áudio"><img src="styles/estudiolivre/logo_audio_p.png"></a><br/>
    <a href="el-gallery_home.php"><img src="styles/estudiolivre/logo_acervo_livre_p.png"></a>
    <a href="http://xango.metareciclagem.org"><img src="styles/estudiolivre/logo_metarec_p.png"></a><br/>
  </div>
</div>


<div id="tiki-top-bottom">

 {if $user}
   <div id="gretting">Olá <a class="link" href="tiki-user_preferences.php">{$user}</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="tiki-logout.php">logout&nbsp;&nbsp;<img src="styles/estudiolivre/sair.png" title="sair"></a></div>
 {else}
  <div id="tiki-top-login">
    <form id="login-top" name="loginbox" action="{$login_url}" method="post">

     <label for="login-user"><img src="styles/estudiolivre/nome.png"></label>
     {if $loginuser eq ''}
       <input type="text" name="user" id="login-user" size="20" />
     {else}
       <input type="hidden" name="user" id="login-user" value="{$loginuser}" /><b>{$loginuser}</b>
     {/if}

     <label for="login-pass"><img src="styles/estudiolivre/senha.png"></label>
     <input type="password" name="pass" id="login-pass" size="20" />
     <input class="submit" type="image" name="login" src="styles/estudiolivre/entrar.png" />

   </form>
 
   <div id="login-options">
   
      {if $allowRegister eq 'y'}
        <a href="tiki-register.php"><img src="styles/estudiolivre/cadastrarse.png"></a><br/>
      {/if}
      {if $forgotPass eq 'y'}
        <a href="tiki-remind_password.php"><img src="styles/estudiolivre/perdisenha.png"></a>
      {/if}

    </div>

  </div>   
    
{/if $user}


{if $feature_search eq 'y'}
 <div id="tiki-top-search">
    <form id="search-top" method="get" action="tiki-searchresults.php" >
      <input type="hidden" name="where" value="pages">
      <label for="search-field"><img src="styles/estudiolivre/buscar.png"></label>
      <input id="search-field" name="highlight" size="35" type="text" accesskey="s"/>
      <input class="submit" type="image" name="search" src="styles/estudiolivre/search.png">
    </form>
 </div>
{/if}


</div> *}

</div>

<!-- tiki-top_bar.tpl end -->
