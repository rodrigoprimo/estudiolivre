<!-- tiki-user_information.tpl begin -->

<script language="JavaScript" src="lib/js/user_edit.js"></script>
<script language="JavaScript" src="lib/js/edit_field_ajax.js"></script>

<div id="userPage">
  <div id="uGeneralInfo">
    <div id="uName">
      {$userinfo.login} {if $user eq $userinfo.login}{tooltip text="Modifique as suas preferências"}<a href="tiki-user_preferences.php"><img src="img/mytiki/prefs.gif" height="15"></a>{/tooltip}{/if}
    </div>
    
    <div id="uContactKarmaAccount">
      <div id="uContact" class="uContactInfoCont">
        {ajax_input permission=$permission id="realName" class="uContactItem" value=$realName default="Nome completo" display="block"}
		<br />
        {ajax_input permission=$permission id="email" class="uContactItem" value=$userinfo.email default="E-mail" display="block" truncate='25'}
		<br />
        {ajax_input permission=$permission id="homePage" class="uContactItem" value=$homePage default="Homepage" display="block" truncate='25'}
		<br />
        Localizado em: {ajax_input permission=$permission id="country" class="uContactItem" value=$country default="País" display="inline"}
      </div>

      <div id="uKarmaThumb" class="uContactInfoCont center">
		<div id="uKarma">
		  <img class="uKarmaImg" src="styles/estudiolivre/iKarma.png">
		  <img class="uKarmaImg" class="uKarmaImg" src="styles/estudiolivre/iKarma.png">
		  <img class="uKarmaImg" src="styles/estudiolivre/iKarmaInactive.png">
		  <img class="uKarmaImg" src="styles/estudiolivre/iKarmaInactive.png">
		  <img class="uKarmaImg" src="styles/estudiolivre/iKarmaInactive.png">
		</div>

	    <div id="gUserThumb">
		  <img id="uThumbImg" alt="" src="tiki-show_user_avatar.php?user={$userinfo.login}"/>
		  <div id="gUserThumbStatus"></div>
		</div>

		{if $permission}
		<div id="gUserThumbFormContainer">
	      <div id="gUserThumbForm">
	        <iframe name="thumbUpTarget" style="display:none" onLoad="finishUpThumb();"></iframe>
	        <form action="el-user_thumb.php?UPLOAD_IDENTIFIER=thumb.{$uploadId}" method="post" enctype="multipart/form-data" name="thumbForm" target="thumbUpTarget">
		      <input type="hidden" name="UPLOAD_IDENTIFIER" value="thumb.{$uploadId}"/>
		      <input type="hidden" name="arquivoId" value=""/>
		      <input type="file" name="thumb" onChange="changeThumbStatus()" class="gUserThumbFormButton"/>
	        </form>
	      </div>
	    </div>
	    {/if}

	  </div>

      <div id="uAccountInfo" class="uContactInfoCont right">
        <span class="uContactItem"><a href="#">(X) Amigos</a></span>
        <br />
        {* TODO falar a descricao da licenca no tooltip *}
        <span class="uContactItem">
        	<span class="uContactItem">
        	{if $permission}<a href="#" onClick="lalala fazer a parada escoher licença">{/if}
	        	{if $licenca}
		        	{tooltip name="MinhaLicencaPadrao" text="Minha Licença Padrão"}<img src="styles/estudiolivre/h_{$licenca.linkImagem}"/>{/tooltip}
		        {elseif $permission}
		        	Escolher Licença Padrão
	    	    {else}
	        		(Usuário sem Licença Padrão)
	        	{/if}
        	{if $permission}</a>{/if}
        	</span>
        </span>
        <br />
        <span class="uContactItem"><a href="tiki-lastchanges.php?find={$userinfo.login}&sort_mode=lastModif_desc&days=0">Contribuições Recentes</a></span>
        <br />
        <span class="uContactItem uLittle">Membro desde {$userinfo.registrationDate|date_format:"%d/%m/%Y"}</span>
      </div>  
    </div>
    <div id="uGallery" class="uMainContainer">
      <div id="uGalleryTitle" class="uMainTitle">
        <a class="uRssCont" href="#"><img src="styles/estudiolivre/iRss.png"></a>
        <a href="#" onClick="javascript:flip('uGalleryItems'); return false;">
          <img onclick="this.toggleImage('iArrowGreyRight.png')" src="styles/estudiolivre/iArrowGreyDown.png">
        </a>
        &nbsp;
        <h1>
          <a href="#">Galeria pessoal</a>
        </h1>
      </div>
      <div id="uGalleryItems" class="uMainItemContainer" style="display:block">
      	<div id="listNav" class="ulistNav">{include file="el-gallery_pagination.tpl"}</div>
		<div id="gListCont">{include file="el-gallery_section.tpl"}</div>
      </div>
    </div>
    <div id="uBlog" class="uMainContainer">
      <div id="uBlogTitle" class="uMainTitle">
        <a class="uRssCont" href="#"><img src="styles/estudiolivre/iRss.png"></a>
        <a href="#" onClick="javascript:flip('uBlogItems'); return false;">
        	<img onclick="this.toggleImage('iArrowGreyRight.png')" src="styles/estudiolivre/iArrowGreyDown.png">
        </a>
        &nbsp;
        <h1>
          <a href="#">Blogs</a>
        </h1>
      </div>
      <div id="uBlogItems" class="uMainItemContainer" style="display:block">
        {foreach from=$userPosts.data item='post'}
        <div class="uBlogItem">
          <div id="uBlogItemTitle">
            <h1>{$post.title|truncate:40}</h1> - {$post.created|date_format:"%d/%m/%Y"}
          </div>
          <div id="uBlogItemText">
            {$post.data|truncate:150} <a href="#" title="Ler mais...">(...)</a>
          </div>
          <div id="uBlogItemBottom">
            <a href="tiki-view_blog_post.php?blogId={$post.blogId}&postId={$post.postId}">ler mais</a> | 
            <a href="tiki-view_blog_post.php?blogId={$post.blogId}&postId={$post.postId}">permalink</a> | 
            <a href="tiki-view_blog_post.php?blogId={$post.blogId}&postId={$post.postId}&show_comments=1#comments">({$post.commentsCount}) comentaram</a>
          </div>
        </div>
        {/foreach}
      </div>
    </div>
    <div id="uMsgs" class="uMainContainer">
      <div id="uMsgsTitle" class="uMainTitle">
        <a class="uRssCont" href="#"><img src="styles/estudiolivre/iRss.png"></a>
        <a href="#" onClick="javascript:flip('uMsgItems'); return false;">
          <img onclick="this.toggleImage('iArrowGreyRight.png')" src="styles/estudiolivre/iArrowGreyDown.png">
        </a>
        &nbsp;
        <h1><a href="#">Recados</a></h1>
      </div>
      <div id="uMsgItems" class="uMainItemContainer" style="display:block">
      	{include file="el-user_msg.tpl"}
      </div>
    </div>
    <div id="uWiki" class="uMainContainer">
    	<div id="uWikiTitle" class="uMainTitle">
    		<a class="uRssCont" href="#"><img src="styles/estudiolivre/iRss.png"></a>
    		<a href="#" onClick="javascript:flip('uWikiMid'); return false;">
              <img onclick="this.toggleImage('iArrowGreyRight.png')" src="styles/estudiolivre/iArrowGreyDown.png">
        	</a>
        	&nbsp;
    		<h1>
    		  <a href="#" title="Wiki de {$userinfo.login}">Wiki</a>
    		</h1>
    	</div>
    	<div id="uWikiMid" style="display:block">
    	{include file=tiki-show_page.tpl parsed=$userWiki}
        </div>
    </div>
  </div>
</div>

{include file="el-player.tpl"}

<!-- tiki-user_information.tpl end -->
