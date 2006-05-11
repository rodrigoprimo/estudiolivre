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
    <br />
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
    <br />
    <div id="uMsgs" class="uMainContainer">
      <div id="uMsgsTitle" class="uMainTitle">
        <h1>Recados</h1><h2> - feed</h2>
      </div>
      <div id="uMsgItems" class="uMainItemContainer">
        <div class="uMsgItem">
          <div class="uMsgAvatar">
            <img alt="" title="" src="tiki-show_user_avatar.php?user=criscabello">
          </div>
          
          <div class="uMsgTxt">
            <a href="#">cris</a>: deposita aquela grana...
          </div>
          
          <div class="uMsgDate">
            16:25 - 26 de outubro de 2005
          </div>
          <div class="uMsgDel">
            Delete
          </div>
        </div>
        <div class="uMsgItem">
          <div class="uMsgAvatar">
            <img alt="" title="" src="tiki-show_user_avatar.php?user=nano">
          </div>
          
          <div class="uMsgTxt">
            <a href="#">nano</a>: Manda aquelas merdas...
          </div>
          
          <div class="uMsgDate">
            15:25 - 26 de outubro de 2005
          </div>
          <div class="uMsgDel">
            Delete
          </div>
        </div>
      </div>
    </div>
    <br />
    <div id="uWiki" class="uMainContainer">
    	<div id="uWikiTitle" class="uMainTitle"><h1>Wiki do cara</h1>
    	</div>
    	<div id="uWikiMid">
    	Texto do wiki do cara
        </div>
    </div>
  </div>

{*=============================================

<h1><a class="pagetitle" href="tiki-user_information.php?view_user={$userwatch}">{tr}User Information{/tr}</a></h1>
<hr>
{tr}User{/tr}: {$userinfo.login}{if $tiki_p_admin eq 'y'} <a class="link" href="tiki-user_preferences.php?view_user={$userinfo.login}"><IMG SRC="img/icons/config.gif" title="{tr}Change user preferences{/tr}" border="0" /> </a>  {/if}
<hr>
{if $feature_score eq 'y'}
  {tr}Score{/tr}: {$userinfo.score|star}{$userinfo.score}
{/if}
<hr>
  {tr}Last login{/tr}: {$userinfo.lastLogin|tiki_short_datetime}
<hr>
{if $email_isPublic neq 'n'}  
  {tr}Email{/tr}: {$userinfo.email}
{/if}
<hr>
  {tr}Country{/tr}: <img alt="flag" src="img/flags/{$country}.gif" /> {tr}{$country}{/tr}
<hr>
  {if $change_theme ne 'n'}
    {tr}Theme{/tr}: {$user_style}
  {/if}
<hr>
  {if $change_language eq 'y'}
    {tr}Language{/tr}: {$user_language}
  {/if}
<hr>

<hr>
*}
  {* Custom fields *}
  {*
  {section name=ir loop=$customfields}
    {tr}{$customfields[ir].prefName}{/tr}: {$customfields[ir].value}
  {/section}
<hr>
{tr}Avatar{/tr}: {$avatar}
<hr>
  {tr}Homepage{/tr}: {if $homePage ne ""}<a href="{$homePage}" class="link" title="{tr}Users HomePage{/tr}">{$homePage}</a>{/if}
<hr>
{if $feature_wiki eq 'y' && $feature_wiki_userpage eq 'y'}
  {tr}Personal Wiki Page{/tr}:
  
  {if $userPage_exists}
    <a class="link" href="tiki-index.php?page={$feature_wiki_userpage_prefix|escape:'url'}{$userinfo.login|escape:'url'}">{$feature_wiki_userpage_prefix}{$userinfo.login}</a>
  {elseif $user == $userinfo.login}
    {$feature_wiki_userpage_prefix}{$userinfo.login}<a class="link" href="tiki-editpage.php?page={$feature_wiki_userpage_prefix|escape:'url'}{$userinfo.login|escape:'url'}" title="{tr}Create page{/tr}">?</a>
  {else}
    &nbsp;
  {/if}

{/if}
<hr>
  {tr}Displayed time zone{/tr}: {$display_timezone}
<hr>
{if $feature_friends eq 'y' && $user ne $userwatch && $user}
  {if $friend}
    &nbsp;
    <img src="img/icons/ico_friend.gif" width="7" height="10" /> {tr}This user is your friend{/tr}
  {else}
    &nbsp;
    <img src="img/icons/ico_not_friend.png" /> <a class="link" href="tiki-friends.php?request_friendship={$userinfo.login}">{tr}Request friendship from this user{/tr}</a>
  {/if}
{/if}

<hr>

<hr>

<hr>

<hr>
*}
</div>



{*

<div class="cbox">
  <div class="cbox-title">{tr}User Information{/tr}</div>
    <div class="cbox-data">
      <div class="simplebox">
  
    tabela via!

      </div>
    </div>
  </div>
{if $user and $feature_messages eq 'y' and $tiki_p_messages eq 'y' and $allowMsgs eq 'y'}
  {if $sent}
    {$message}
  {/if}
  <div class="cbox-title">{tr}Send me a message{/tr}</div>
    <div class="cbox-data">
      <div class="simplebox">
        <form method="post" action="tiki-user_information.php" name="f">
          <input type="hidden" name="to" value="{$userwatch|escape}" />
          <input type="hidden" name="view_user" value="{$userwatch|escape}" />
          <br>
          {tr}Priority{/tr}:<br>
		    <select name="priority">
		      <option value="1" {if $priority eq 1}selected="selected"{/if}>1 -{tr}Lowest{/tr}-</option>
		      <option value="2" {if $priority eq 2}selected="selected"{/if}>2 -{tr}Low{/tr}-</option>
		      <option value="3" {if $priority eq 3}selected="selected"{/if}>3 -{tr}Normal{/tr}-</option>
		      <option value="4" {if $priority eq 4}selected="selected"{/if}>4 -{tr}High{/tr}-</option>
		      <option value="5" {if $priority eq 5}selected="selected"{/if}>5 -{tr}Very High{/tr}-</option>
		    </select>
			<input type="submit" name="send" value="{tr}send{/tr}" />
			{tr}Subject{/tr}:
			  <input type="text" name="subject" value="" maxlength="255" style="width:100%;"/>
              <textarea rows="20" cols="80" name="body"></textarea>
        </form>
      </div>
    </div>
  </div>
{/if}


*}

<!-- tiki-user_information.tpl end -->
