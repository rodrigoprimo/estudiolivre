

<div id="sideContent">
  {if $category eq "Áudio"}
  {********AUDIO*********}
    <a href="tiki-index.php?page=Áudio"><img src="styles/estudiolivre/logoAudio.png"></a>
	<div id="localMenu">
	<ul>
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
	</ul>
	</div>
  {elseif $category eq "Gráfico"}
  {*********GRAFICO********}
    <a href="tiki-index.php?page=Gráfico"><img src="styles/estudiolivre/logoGrafi.png"></a>
	<div id="localMenu">
	<ul>
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
	</ul>
	</div>
  {elseif $category eq "Vídeo"}
  {*********VIDEO********}
    <a href="tiki-index.php?page=Vídeo"><img src="styles/estudiolivre/logoVideo.png"></a>
	<div id="localMenu">
	<ul>
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
	</ul>
	</div>
  {elseif $category eq "gallery"}
  {*********ACERVO********}
    <a href="el-gallery_home.php"><img src="styles/estudiolivre/logoAcervo.png"></a>
	<div id="localMenu">
	<ul>
    {if $current_location eq "el-gallery_upload.php"}      
      	<li class="selectedAcervo">compartilhe sua obra</li>
    {else}
    	{if $user}
        	<li><a href="el-gallery_upload.php">compartilhe sua obra</a></li>
        {else}
      		<div id="precisaLogar" style="display:none;width:200px;padding:5px">
      			Para compartilhar a sua obra no <b>Acervo Livre</b> é necessário se <a href="tiki-register.php">cadastrar</a> no site.<br><br>
      			Se for cadastrado, efetue o login:<br>

					    <form id="uLoginBox" action="tiki-login.php" method="post">
					      <input type="hidden" name="redirect" value="el-gallery_upload.php">
					      <input class="uText" type="text" name="user" id="login-user" size="12" value="usuári@" onFocus="this.value=''"/>
					      <input class="uText" type="text" name="pass" id="login-pass" size="10" value="senha" onFocus="this.value='';this.type='password'"/>
					      <input type="image" name="login" src="styles/estudiolivre/iLogin.png" />      
					      <div id="uLoginOptions">
					        <a href="tiki-remind_password.php">&raquo; recuperar senha</a><br>
					      </div>
					   </form>

			  <br><br>
				Se preferir, <a href="tiki-view_faq.php?faqId=3">leia mais</a> sobre o <b>Acervo Livre</b>.
      		</div>
      		<li onclick="showLightbox('precisaLogar')" style="cursor:pointer"><a>compartilhe sua obra</a></li>
        {/if}   
    {/if}
    
     <li><a href="tiki-view_forum.php?forumId=16">sobre o acervo</a></li>
	</ul>
	</div>
  {/if}


<div id="userMenu">
{if $user}
  
  <div id="topMenuContainer">
    <a href="tiki-logout.php?page={$current_location}">Logout</a>
  </div>

  <div id="userMenuContainer">

	<span id="uMenuName">
		{tooltip text="Navegue para a sua página pessoal para ver seus blogs, arquivos, mensagens e mudar as suas preferências."}<a href="el-user.php?view_user={$user}">{$user}</a>{/tooltip}
	</span>

    <img alt="" id="uOnlineThumb" class="uThumb" src="tiki-show_user_avatar.php?user={$user}"/>
  
    <div id="userNameStatsKarma">

      <br>
      <span id="uStats">
        <img src="styles/estudiolivre/iOnline.png"> online
      </span>
      <br>
      <span id="uKarma">
      	{*
        <img alt="" src="styles/estudiolivre/iKarma.png">
	<img alt="" src="styles/estudiolivre/iKarma.png">
	<img alt="" src="styles/estudiolivre/iKarma.png">
	<img alt="" src="styles/estudiolivre/iKarmaInactive.png">
	<img alt="" src="styles/estudiolivre/iKarmaInactive.png">
	     *}
      </span>
    </div>
    <br style="line-height:10px;">
     <hr>
    
    <div id="moduleLastChanges">
        <img class="pointer" onclick="javascript:flip('moduleLastChangesMore');toggleImage(this,'iArrowGreyDown.png')" src="styles/estudiolivre/iArrowGreyRight.png">
      <a href="tiki-lastchanges.php?days=0">Últimas Alterações</a>
      <div id='moduleLastChangesMore' style="display:none;">
      	{foreach from=$modLastModif item='page'}
			<a href="tiki-index.php?page={$page.pageName}" onMouseover="tooltip('{if $page.comment}{$page.comment|escape:'htmlall'}{else}<i>Modificação não comentada</i>{/if}<br>editado por: <b>{$page.user}</b>')" onMouseout="nd()">{$page.pageName}</a><br/>
     	{/foreach}
      </div>
    </div>
    
    <hr>
    <div id="moduleWhoIsThere">
    {if sizeof($online_users) > 1}
      <img class="pointer" onclick="javascript:flip('moduleWhoIsThereMore');toggleImage(this,'iArrowGreyDown.png')" src="styles/estudiolivre/iArrowGreyRight.png">
      Usuári@s Online
      <div id='moduleWhoIsThereMore' style="display:none;">
		{foreach from=$online_users item='onlineUser'}
		  {if $onlineUser.user neq $user}
		    <a href="el-user.php?view_user={$onlineUser.user}">{$onlineUser.user}</a><br/>
		  {/if}
		{/foreach}
      </div>
    {else}
    	Não há usuári@s online
    {/if}
    </div>
    
    <hr>
    <div id="moduleGallery">
    	Acervo: {tooltip text="Veja os arquivos que você publicou"}<a href="el-user.php?view_user={$user}#gallery">ver</a>{/tooltip} | {tooltip text="Publique <b>sua obra</b> no Estúdio Livre!"}<a href="el-gallery_upload.php">publicar</a>{/tooltip}
    </div>
	
	{if  $tiki_p_admin eq 'y'}
	    <hr>
		<div style="text-align:left">
			<a href="tiki-admin.php">Administrar</a> o TikiWiki
	    </div>
	{/if}
        
  </div>

{else}

  <div id="topMenuContainer">Login
  </div>

  <div id="userMenuContainer">
    <form id="uLoginBox" action="tiki-login.php" method="post">
      {if $isIE}Usuário: {/if}<input class="{if !$isIE}uText{/if}" type="text" name="user" id="login-user" size="12" {if $isIE}style="width:60%"{/if} value="usuári@" onFocus="if(this.value=='usuári@')this.value=''"/>
      {if $isIE}Senha: {/if}<input class="{if !$isIE}uText{/if}" type="{if $isIE}password{else}text{/if}" name="pass" id="login-pass" size="10"	{if $isIE}style="width:70%"{/if} value="{if !$isIE}senha{/if}" onFocus="if(this.value=='senha')this.value='';this.type='password'"/>
      {tooltip text="Clique aqui ou aperte <i>Enter</i> para efetuar o login"}<input type="image" name="login" src="styles/estudiolivre/iLogin.png" />{/tooltip}
      
      <div id="uLoginOptions">
        <a href="tiki-remind_password.php">&raquo; recuperar senha</a><br>
        <a href="tiki-register.php">&raquo; cadastrar-se</a>
      </div>
      
      
   </form>
  </div>

{/if}
</div>

</div>