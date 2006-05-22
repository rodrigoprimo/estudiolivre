{debug}<!-- tiki-user_information.tpl begin -->

<div id="userPage">
  <div id="uGeneralInfo">
    <div id="uName">
      {$userinfo.login}
    </div>
    
    <div id="uContactKarmaAccount">
      <div id="uContact" class="uContactInfoCont">
        <span class="uContactItem">{$realName}</span>
		<br />
        <span class="uContactItem" title="{$userinfo.email}">{$userinfo.email|truncate:22:" (...)"}</span>
		<br />
        <span class="uContactItem"><a href="{$homePage}">{$homePage|truncate:22:" (...)"}</a></span>
		<br />
        <span class="uContactItem">Localizado em: {$country}</span>
      </div>

      <div id="uKarmaThumb" class="uContactInfoCont">
		<div id="uKarma">
		  <img class="uKarmaImg" src="styles/estudiolivre/iKarma.png">
		  <img class="uKarmaImg" class="uKarmaImg" src="styles/estudiolivre/iKarma.png">
		  <img class="uKarmaImg" src="styles/estudiolivre/iKarmaInactive.png">
		  <img class="uKarmaImg" src="styles/estudiolivre/iKarmaInactive.png">
		  <img class="uKarmaImg" src="styles/estudiolivre/iKarmaInactive.png">
		</div>
		<div id="uThumb">
		  <img id="uThumbImg" src="tiki-show_user_avatar.php?user={$userinfo.login}" alt="" title="">
		</div>
      </div>

      <div id="uAccountInfo" class="uContactInfoCont">
        <span class="uContactItem">Membro desde {$userinfo.registrationDate|date_format:"%d/%m/%Y"}</span>
        <br />
        <span class="uContactItem"><a href="tiki-lastchanges.php?find={$userinfo.login}&sort_mode=lastModif_desc&days=0">Contribuições Recentes</a></span>

        <br />
        <span class="uContactItem"><a href="#">(X) Amigos</a></span>

        <br />
        <span class="uContactItem"><a href="#">Minha Licença Padrão (X)</a></span>
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
		[include lista acervo]
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
          <a href="#">Blog</a>
        </h1>
      </div>
      <div id="uBlogItems" class="uMainItemContainer" style="display:block">
        {foreach from=$userPosts.data item='post'}
        <div class="uBlogItem">
          <div id="uBlogItemTitle">
            <h1>{$post.title}</h1> - {$post.created|date_format:"%d/%m/%Y"}
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
        
        {foreach from=$userMessages.data item='msg'}
        <div class="uMsgItem">
          <div class="uMsgAvatar">
            <img alt="" title="" src="tiki-show_user_avatar.php?user={$msg.user_from}">
          </div>
          <div class="uMsgTxt">
			<div class="uMsgDel">
              <a href="#"><img alt="" title="Deletar Mensagem" src="styles/estudiolivre/iDelete.png"></a>
            </div>
            <div class="uMsgDate">
              {$msg.date|date_format:"%H:%M"}<br />
              {$msg.date|date_format:"%d/%m/%Y"}
            </div>
            <a href="#">{$msg.user_from}</a>: {$msg.body}
          </div>
        </div>
        <hr>
        {/foreach}

        <div id="uMsgSend">         
          <input type="submit" name="" value="enviar" label="enviar" id="uMsgSendSubmit">
          <input type="text" id="uMsgSendInput">
        </div>
        
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
    		  <a href="#" title="Wiki de ???">Wiki do cara</a>
    		</h1>
    	</div>
    	<div id="uWikiMid" style="display:block">
    	Texto do wiki do cara
        </div>
    </div>
  </div>
</div>



<!-- tiki-user_information.tpl end -->
