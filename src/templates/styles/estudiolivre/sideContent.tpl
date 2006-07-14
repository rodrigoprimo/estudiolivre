

<div id="sideContent">
  {if $category eq "Áudio"}
  {********AUDIO*********}
    <a href="tiki-index.php?page=Áudio"><img src="styles/estudiolivre/logoAudio.png"></a>
	<div id="localMenu">
	<ul>
    {if $page eq "Softwares de Edição de Áudio"}
       <li class="selectedAudio">{tr}softwares{/tr}</li>
    {else}
       <li><a href="tiki-index.php?page=Softwares de Áudio">softwares</li>
    {/if}

    {if $page eq "Equipamentos para Produção Multimídia"}
       <li class="selectedAudio">{tr}equipamentos{/tr}</li>
    {else}
       <li><a href="tiki-index.php?page=Equipamentos+para+Produ%C3%A7%C3%A3o+Multim%C3%ADdia">{tr}equipamentos{/tr}</a></li>
    {/if}

    {if $page eq "Produzindo Audio"}
       <li class="selectedAudio">{tr}produzindo{/tr}</li>
    {else}
       <li><a href="tiki-index.php?page=Produzindo+Audio">{tr}produzindo{/tr}</a></li>
    {/if}
    
    {if $page eq "Links de Áudio"}
       <li class="selectedAudio">links</li>
    {else}
        <li><a href="tiki-index.php?page=Links+de+%C3%81udio">{tr}links{/tr}</a></li>
    {/if}
	</ul>
	</div>
  {elseif $category eq "Gráfico"}
  {*********GRAFICO********}
    <a href="tiki-index.php?page=Gráfico"><img src="styles/estudiolivre/logoGrafi.png"></a>
	<div id="localMenu">
	<ul>
    {if $page eq "Softwares de Gráfico"}
       <li class="selectedGraf">{tr}softwares{/tr}</li>
    {else}
       <li><a href="tiki-index.php?page=Softwares de Gráfico">softwares</a></li>
    {/if}
    
    {if $page eq "Equipamentos para Produção Multimídia"}
       <li class="selectedGraf">{tr}equipamentos{/tr}</li>
    {else}
       <li><a href="tiki-index.php?page=Equipamentos+para+Produ%C3%A7%C3%A3o+Multim%C3%ADdia">{tr}equipamentos{/tr}</a></li>
    {/if}

    {if $page eq "Produzindo Gráfico"}
       <li class="selectedGraf">{tr}produzindo{/tr}</li>
    {else}
       <li><a href="tiki-index.php?page=Produzindo+Gráfico">{tr}produzindo{/tr}</a></li>
    {/if}

    {if $page eq "Links de Gráfico"}
       <li class="selectedGraf">{tr}links{/tr}</li>
    {else}
       <li><a href="tiki-index.php?page=Links de Gráfico">{tr}links{/tr}</a></li>
    {/if}
	</ul>
	</div>
  {elseif $category eq "Vídeo"}
  {*********VIDEO********}
    <a href="tiki-index.php?page=Vídeo"><img src="styles/estudiolivre/logoVideo.png"></a>
	<div id="localMenu">
	<ul>
    {if $page eq "Softwares de Vídeo"}
       <li class="selectedVideo">{tr}softwares{/tr}</li>
    {else}
       <li><a href="tiki-index.php?page=Softwares de Vídeo">{tr}softwares{/tr}</a></li>
    {/if}

    {if $page eq "Equipamentos para Produção Multimídia"}
       <li class="selectedVideo">{tr}equipamentos{/tr}</li>
    {else}
       <li><a href="tiki-index.php?page=Equipamentos+para+Produ%C3%A7%C3%A3o+Multim%C3%ADdia">{tr}equipamentos{/tr}</a></li>
    {/if}
    
    {if $page eq "Produzindo Vídeo"}
       <li class="selectedVideo">{tr}produzindo{/tr}</li>
    {else}
       <li><a href="tiki-index.php?page=Produzindo+Vídeo">{tr}produzindo{/tr}</a></li>
    {/if}

    {if $page eq "Links de Vídeo"}
       <li class="selectedVideo">{tr}links{/tr}</li>
    {else}
       <li><a href="tiki-index.php?page=Links de Vídeo">{tr}links{/tr}</a></li>
    {/if}
	</ul>
	</div>
  {elseif $category eq "gallery"}
  {*********ACERVO********}
    <a href="el-gallery_home.php"><img src="styles/estudiolivre/logoAcervo.png"></a>
	<div id="localMenu">
	<ul>
    {if $current_location eq "el-gallery_upload.php"}      
      	<li class="selectedAcervo">{tr}compartilhe sua obra{/tr}</li>
    {else}
    	{if $user}
        	<li><a href="el-gallery_upload.php">{tr}compartilhe sua obra{/tr}</a></li>
        {else}
      		<div id="precisaLogar" style="display:none;width:200px;padding:5px">
      			{tr}Para compartilhar a sua obra no <b>Acervo Livre</b> é necessário se <a href="tiki-register.php">cadastrar</a> no site.{/tr}<br><br>
      			{tr}Se for cadastrado, efetue o login{/tr}:<br>

					    <form id="uLoginBox" action="tiki-login.php" method="post">
					      <input type="hidden" name="redirect" value="el-gallery_upload.php">
					      <input class="uText" type="text" name="user" id="login-user" size="12" value="{tr}user{/tr}" onFocus="this.value=''"/>
					      <input class="uText" type="text" name="pass" id="login-pass" size="10" value="{tr}senha{/tr}" onFocus="this.value='';this.type='password'"/>
					      <input type="image" name="login" src="styles/estudiolivre/iLogin.png" />      
					      <div id="uLoginOptions">
					        <a href="tiki-remind_password.php">&raquo; {tr}recuperar{/tr} {tr}senha{/tr}</a><br>
					      </div>
					   </form>

			  <br><br>
				{tr}Se preferir{/tr}, <a href="tiki-view_faq.php?faqId=3">{tr}leia mais{/tr}</a> {tr}sobre o <b>Acervo Livre</b>{/tr}.
      		</div>
      		<li onclick="showLightbox('precisaLogar')" style="cursor:pointer"><a>{tr}compartilhe sua obra{/tr}</a></li>
        {/if}   
    {/if}
    
     <li><a href="tiki-index.php?page=faq">{tr}sobre o{/tr} {tr}acervo{/tr}</a></li>
	</ul>
	</div>
  {/if}


<div id="userMenu">
{if $user}
  
  <div id="topMenuContainer">
    <a href="tiki-logout.php?page={$current_location}">{tr}Logout{/tr}</a>
  </div>

  <div id="userMenuContainer">

	<span id="uMenuName">
		{tooltip text="Navegue para a sua página pessoal para ver seus blogs, arquivos, mensagens e mudar as suas preferências."}<a href="el-user.php?view_user={$user}">{$user}</a>{/tooltip}
	</span>

    <img alt="" id="uOnlineThumb" class="uThumb" src="tiki-show_user_avatar.php?user={$user}"/>
  
    <div id="userNameStatsKarma">

      <br>
      <span id="uStats">
        <img src="styles/estudiolivre/iOnline.png"> {tr}online{/tr}
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
       <span class="hiddenPointer" onclick="javascript:flip('moduleLastChangesMore');toggleImage(document.getElementById('chaTArrow'),'iArrowGreyDown.png')">
        <img id="chaTArrow"  src="styles/estudiolivre/iArrowGreyRight.png">
      	{tr}Últimas Alterações{/tr}
      </span>
      <div id='moduleLastChangesMore' style="display:none;">
      	{foreach from=$modLastModif item='page'}
			<a href="tiki-index.php?page={$page.pageName}" onMouseover="tooltip('{if $page.comment}{$page.comment|escape:'quotes'}{else}<i>{tr}Modificação não comentada{/tr}</i>{/if}<br>{tr}editado por{/tr}: <b>{$page.user}</b>')" onMouseout="nd()">{$page.pageName}</a><br/>
     	{/foreach}
     	<div id="moduleLastChangesViewAll"><a href="tiki-lastchanges.php?days=0">{tr}ver mais{/tr}</a></div>
      </div>
    </div>
    
    <hr>
    <div id="moduleWhoIsThere">
    {if sizeof($online_users) > 1}
      <span class="hiddenPointer" onclick="javascript:flip('moduleWhoIsThereMore');toggleImage(document.getElementById('whoTArrow'),'iArrowGreyDown.png')">
    	  <img id="whoTArrow" src="styles/estudiolivre/iArrowGreyRight.png">
	      {tr}Usuári@s Online{/tr}
      </span>
      <div id='moduleWhoIsThereMore' style="display:none;">
		{foreach from=$online_users item='onlineUser'}
		  {if $onlineUser.user neq $user}
		    <a href="el-user.php?view_user={$onlineUser.user}">{$onlineUser.user}</a><br/>
		  {/if}
		{/foreach}
      </div>
    {else}
    	{tr}Não há usuári@s online{/tr}
    {/if}
    </div>
    
    <hr>
    <div id="moduleGallery">
    	{tr}Acervo{/tr}: {tooltip text="Veja os arquivos que você publicou"}<a href="el-user.php?view_user={$user}#gallery">{tr}ver{/tr}</a>{/tooltip} | {tooltip text="Publique <b>sua obra</b> no Estúdio Livre!"}<a href="el-gallery_upload.php">{tr}publicar{/tr}</a>{/tooltip}
    </div>
	
	{if  $tiki_p_admin eq 'y'}
	    <hr>
		<div style="text-align:left">
			{tr}<a href="tiki-admin.php">Administrar</a> o TikiWiki{/tr}
	    </div>
	{/if}
        
  </div>

{else}

  <div id="topMenuContainer">{tr}Login{/tr}
  </div>

  <div id="userMenuContainer">
    <form id="uLoginBox" action="tiki-login.php" method="post">
      {if $isIE}{tr}Usuário{/tr}: {/if}<input class="{if !$isIE}uText{/if}" type="text" name="user" id="login-user" size="12" {if $isIE}style="width:60%"{/if} value="{tr}user{/tr}" onFocus="if(this.value=='{tr}usuári@{/tr}')this.value=''"/>
      {if $isIE}{tr}Senha{/tr}: {/if}<input class="{if !$isIE}uText{/if}" type="{if $isIE}password{else}text{/if}" name="pass" id="login-pass" size="10"	{if $isIE}style="width:70%"{/if} value="{if !$isIE}{tr}senha{/tr}{/if}" onFocus="if(this.value=='{tr}senha{/tr}')this.value='';this.type='password'"/>
      {tooltip text="Clique aqui ou aperte <i>Enter</i> para efetuar o login"}<input type="image" name="login" src="styles/estudiolivre/iLogin.png" />{/tooltip}
      
      <div id="uLoginOptions">
        <a href="tiki-remind_password.php">&raquo; {tr}recuperar senha{/tr}</a><br>
        <a href="tiki-register.php">&raquo; {tr}cadastrar-se{/tr}</a>
      </div>
      
      
   </form>
  </div>

{/if}
</div>

</div>