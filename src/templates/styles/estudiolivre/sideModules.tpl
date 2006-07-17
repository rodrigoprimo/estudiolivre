	{if $user}
	<div class="userMenu">  
	
	  <div class="topMenuContainer">
	    <a href="tiki-logout.php?page={$current_location}">{tr}Logout{/tr}</a>
	  </div>
	
	  <div class="userMenuContent">
	
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
	</div>
	
	{else}
	

	
	{/if}
	
	{foreach from=$right_modules item=module}
		{$module.data}
	{/foreach}