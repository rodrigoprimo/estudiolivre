<div id="sideContent">
  {if $category eq "Áudio"}
    <img src="styles/estudiolivre/logoAudio.png">
  {elseif $category eq "Gráfico"}
    <img src="styles/estudiolivre/logoGrafi.png">
  {elseif $category eq "Vídeo"}
    <img src="styles/estudiolivre/logoVideo.png">
  {elseif $style eq "estudiolivre_biblio.css"}
    <img src="styles/estudiolivre/logoAcervo.png">
  {/if}

<div id="localMenu">
<ul>
  {********AUDIO*********}
  {if $category eq "Áudio"}
    {if $page eq "Softwares de Edição de Áudio"}
       <li class="selectedAudio">softwares</li>
    {else}
       <li><a href="tiki-index.php?page=Softwares de Áudio">softwares</li>
    {/if}

    {if $page eq "Equipamentos para Produção Multimídia"}
       <li class="selectedAudio">equipamentos</li>
    {else}
       <li><a href="tiki-index.php?page=Equipamentos+para+Produ%C3%A7%C3%A3o+Multim%C3%ADdia">equipamentos</a></li>
    {/if}

    {if $page eq "Produzindo Áudio"}
       <li class="selectedAudio">produzindo</li>
    {else}
       <li><a href="tiki-index.php?page=Produzindo+%C3%81udio">produzindo</a></li>
    {/if}
    
    {if $page eq "Links de Áudio"}
       <li class="selectedAudio">links</li>
    {else}
        <li><a href="tiki-index.php?page=Links+de+%C3%81udio">links</a></li>
    {/if}

  {*********GRAFICO********}
  {elseif $category eq "Gráfico"}
    {if $page eq "Softwares de Gráfico"}
       <li class="selectedGraf">softwares</li>
    {else}
       <li><a href="tiki-index.php?page=Softwares de Gráfico">softwares</a></li>
    {/if}
    
    {if $page eq "Equipamentos para Produção Multimídia"}
       <li class="selectedGraf">equipamentos</li>
    {else}
       <li><a href="tiki-index.php?page=Equipamentos+para+Produ%C3%A7%C3%A3o+Multim%C3%ADdia">equipamentos</a></li>
    {/if}

    {if $page eq "Produzindo Gráfico"}
       <li class="selectedGraf">produzindo</li>
    {else}
       <li><a href="tiki-index.php?page=Produzindo Gráfico">produzindo</a></li>
    {/if}

    {if $page eq "Links de Gráfico"}
       <li class="selectedGraf">links</li>
    {else}
       <li><a href="tiki-index.php?page=Links de Gráfico">links</a></li>
    {/if}


  {*********VIDEO********}
  {elseif $category eq "Vídeo"}
    {if $page eq "Softwares de Vídeo"}
       <li class="selectedVideo">softwares</li>
    {else}
       <li><a href="tiki-index.php?page=Softwares de Vídeo">softwares</a></li>
    {/if}

    {if $page eq "Equipamentos para Produção Multimídia"}
       <li class="selectedVideo">equipamentos</li>
    {else}
       <li><a href="tiki-index.php?page=Equipamentos+para+Produ%C3%A7%C3%A3o+Multim%C3%ADdia">equipamentos</a></li>
    {/if}
    
    {if $page eq "Produzindo Vídeo"}
       <li class="selectedVideo">produzindo</li>
    {else}
       <li><a href="tiki-index.php?page=Produzindo Vídeo">produzindo</a></li>
    {/if}

    {if $page eq "Links de Vídeo"}
       <li class="selectedVideo">links</li>
    {else}
       <li><a href="tiki-index.php?page=Links de Vídeo">links</a></li>
    {/if}
    

  {*********ACERVO********}
  {elseif $style eq "estudiolivre_biblio.css"}
    {if $current_location eq "el-gallery_home.php"}
      <li class="selectedAcervo">home</li>
    {else}
      <li><a href="el-gallery_home">home</a></li>
    {/if}

    {if $current_location eq "el-gallery_upload.php"}
      <li class="selectedAcervo">compartilhe</li>
    {else}
         <li><a href="el-gallery_upload.php">compartilhe</a></li>
    {/if}

  {/if}
</ul>
</div>


<div id="userMenu">
{if $user}
  
  <div id="topMenuContainer">
    <a href="tiki-logout.php">Logout</a>
  </div>
  
  <div id="userMenuContainer">
  
  <img alt="" class="uThumb" src="tiki-show_user_avatar.php?user={$user}" >{*$avatar*}
  
    <div id="userNameStatsKarma">

      <span id="uName">
       <a href="tiki-user_information.php?view_user={$user}">{$user}</a>
      </span>
      <br>
      <span id="uStats">
        <img src="styles/estudiolivre/iOnline.png"> meu status
      </span>
      <br>
      <span id="uKarma">
        <img alt="" src="styles/estudiolivre/iKarma.png">
	<img alt="" src="styles/estudiolivre/iKarma.png">
	<img alt="" src="styles/estudiolivre/iKarma.png">
	<img alt="" src="styles/estudiolivre/iKarmaInactive.png">
	<img alt="" src="styles/estudiolivre/iKarmaInactive.png">
      </span>
    </div>
    <br style="line-height:7px;">
     <hr>
    
    <div id="moduleLastChanges">
      Ultimas Alterações <a href="#">[+]</a>
    </div>
    
    <hr>
    
    <div id="moduleLastChanges">
      Amigos <a href="#">[+]</a>
    </div>
    
  </div>

{else}

  <div id="topMenuContainer">Login
  </div>

  <div id="userMenuContainer">
    <form id="uLoginBox" action="tiki-login.php" method="post">
      <input class="uText" type="text" name="user" id="login-user" size="12" value="usuá¡rio" onFocus="this.value=''"/>
      <input class="uText" type="text" name="pass" id="login-pass" size="10" value="senha" onFocus="this.value='';this.type='password'"/>
      <input type="image" name="login" src="styles/estudiolivre/iLogin.png" />
      
      <div id="uLoginOptions">
        <a href="tiki-remind_password.php">&raquo; recuperar senha</a><br>
        <a href="tiki-register.php">&raquo; cadastrar-se</a>
      </div>
      
      
   </form>
  </div>

{/if}
</div>

</div>
