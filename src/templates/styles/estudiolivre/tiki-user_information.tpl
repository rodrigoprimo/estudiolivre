<!-- tiki-user_information.tpl begin -->

<div id="userPage">
  <div id="uGeneralInfo">
    <div id="uName">
      username
    </div>
    
    <div id="uContactKarmaAccount">
      <div id="uContact" class="uContactInfoCont">
        <span class="uContactItem">Nome do Usuário</span>
		<br />
        <span class="uContactItem">email@email.com</span>
		<br />
        <span class="uContactItem"><a href="#">www.paginadocara.com</a></span>
		<br />
        <span class="uContactItem">Localizado em: São Paulo</span>
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
		  <img id="uThumbImg" src="tiki-show_user_avatar.php?user={$user}" alt="" title="">
		</div>
      </div>

      <div id="uAccountInfo" class="uContactInfoCont">
        <span class="uContactItem">Membro desde 02/10/2000</span>
        <br />
        <span class="uContactItem"><a href="#">Contribuições Recentes</a></span>

        <br />
        <span class="uContactItem"><a href="#">(X) Amigos</a></span>

        <br />
        <span class="uContactItem"><a href="#">Minha Licença Padrão (X)</a></span>
      </div>  
    </div>
    <div id="uGallery" class="uMainContainer">
      <div id="uGalleryTitle" class="uMainTitle">
        <h1>Gakeria pessoal</h1><h2> - feed</h2>
      </div>
      <div id="uGalleryItems" class="uMainItemContainer">
		[include lista acervo]
      </div>
    </div>
    <div id="uBlog" class="uMainContainer">
      <div id="uBlogTitle" class="uMainTitle">
        <h1>Blog</h1><h2> - feed</h2>
      </div>
      <div id="uBlogItems" class="uMainItemContainer">
        <div class="uBlogItem">
          <div id="uBlogItemTitle">
            <h1>Titulo Post</h1> - 29 do Tanto de 18etanto
          </div>
          <div id="uBlogItemText">
            Meu blog eh muito legal e eu gosto muito de postar nele e eu no sei escrever e eu
            nunca coloco virgula nem ponto nem nada <a href="#" title="Ler mais...">(...)</a>
          </div>
          <div id="uBlogItemBottom">
            <a href="#">ler mais</a> | <a href="#">permalink</a> | <a href="#">(X) comentaram</a>
          </div>
        </div>
        <div class="uBlogItem">
          <div id="uBlogItemTitle">
            <h1> Titulo Post2 </h1> - 27 do Tanto de 18etanto
          </div>
          <div id="uBlogItemText">
            No nonoo onono no no onononon ono nono nonoon ononono nono nonon onono 
            nunca coloco virgula nem ponto nem nada <a href="#" title="Ler mais...">(...)</a>
          </div>
          <div id="uBlogItemBottom">
            <a href="#">ler mais</a> | <a href="#">permalink</a> | <a href="#">(Y) comentaram</a>
          </div>
        </div>  
      </div>
    </div>
    <div id="uMsgs" class="uMainContainer">
      <div id="uMsgsTitle" class="uMainTitle">
        <h1>Recados</h1><h2> - feed</h2>
      </div>
      <div id="uMsgItems" class="uMainItemContainer">
        
        {* Item 1 *}
        <div class="uMsgItem">
          <div class="uMsgAvatar">
            <img alt="" title="" src="tiki-show_user_avatar.php?user=criscabello">
          </div>
          <div class="uMsgTxt">
			<div class="uMsgDel">
              <a href="#"><img alt="" title="Deletar Mensagem" src="styles/estudiolivre/iDelete.png"></a>
            </div>
            <div class="uMsgDate">
              16:25<br />
              26/10/05
            </div>
            <a href="#">cris</a>: deposita aquela grana que eu te emprestei no mes passado. ta foda. nao to conseguindo alimentar a patroa. os moleque tao chiando e o cachorro jah virou sopa. na real, se liga véio...
          </div>
        </div>
        <hr>
        {* Item 2 *}        
        <div class="uMsgItem">
          <div class="uMsgAvatar">
            <img alt="" title="" src="tiki-show_user_avatar.php?user=nano">
          </div>
          <div class="uMsgTxt">
	        <div class="uMsgDel">
	          <a href="#"><img alt="" title="Deletar Mensagem" src="styles/estudiolivre/iDelete.png"></a>
	        </div>
	        <div class="uMsgDate">
              16:25<br />
              26/10/05
	        </div>
			<a href="#">nano</a>: Ainda não recebi os bagulho. Tô no aguardo. Ipsum Lispsuim Vocs.
          </div>
        </div>  
        <hr>
          {* Item 3 *}
        <div class="uMsgItem">
          <div class="uMsgAvatar">
            <img alt="" title="" src="tiki-show_user_avatar.php?user=nano">
          </div>
          <div class="uMsgTxt">
	        <div class="uMsgDate">
              16:25<br />
              26/10/05
	        </div>
			<a href="#">nano</a>: Manda aquelas merdas...
          </div>
        </div>
        <hr>
        <div id="uMsgSend">
          
          <input type="submit" name="" value="enviar" label="enviar" id="uMsgSendSubmit">
          <input type="text" id="uMsgSendInput">
        </div>
        
      </div>
    </div>
    <div id="uWiki" class="uMainContainer">
    	<div id="uWikiTitle" class="uMainTitle"><h1>Wiki do cara</h1>
    	</div>
    	<div id="uWikiMid">
    	Texto do wiki do cara
        </div>
    </div>
  </div>
</div>



<!-- tiki-user_information.tpl end -->
