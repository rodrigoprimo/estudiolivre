
<script language="JavaScript" src="lib/js/freetags.js"></script>
<script language="JavaScript" src="lib/js/edit_field_ajax.js"></script>
<script language="JavaScript" src="lib/js/file_edit.js"></script>
<script language="JavaScript" src="lib/js/el-rating.js"></script>

<div id="arqCont">
	<div id="aTopCont">
		<div id="aThumbRatingLic">		
			<div id="aRating">
				{tooltip name="view-avaliacao" text="Avaliação atual"}
					<img id="aRatingImg" src="styles/estudiolivre/star{math equation="round(x)" x=$arquivo.rating|default:"blk"}.png">
				{/tooltip}
			</div>
			<div id="aThumbLic">
				<div id="aLic">
					     {tooltip name="arq-descricao-licenca" text=$arquivo.licenca.descricao}
					     <a href="{$arquivo.licenca.linkHumanReadable}"><img src="styles/estudiolivre/{$arquivo.licenca.linkImagem}"></a>
					     {/tooltip}
				</div>
				{if sizeof($arquivo.thumbnail)}
					<img id="aThumb" src="repo/{$arquivo.thumbnail}">
				{else}
					<img id="aThumb" src="styles/estudiolivre/iThumb{$arquivo.tipo}.png">
				{/if}
			</div>
		</div>
		
		<div id="aMainInfo">
			<div id="aNameAuthorDown">
				<div id="aDown">
					<div id="gDownload">
						<span class="gDownloadCount">
							{$arquivo.hits}
						</span>
						{tooltip name="view-baixe-arquivo" text="Baixe esse arquivo"}
						<a href="el-download.php?arquivo={$arquivoId}&action=download">
						  <img alt="" src="styles/estudiolivre/iDownload.png">
						</a>
						{/tooltip}
					</div>
					<div id="gPlay">
						<span class="gStreamCount">
							{$arquivo.streamHits}
						</span>
						{if $arquivo.tipo eq "Video"}
							{assign var=tooltipText value="Assita esse vídeo"}
						{else}
							{if $arquivo.tipo eq "Audio"}
								{assign var=tooltipText value="Ouça essa música"}
							{/if}
						{/if}
						{if $tooltipText}
							{tooltip name="view-iplay-" text=$tooltipText}
								<a href="#">
									<img alt="" src="styles/estudiolivre/iPlay.png">
								</a>
							{/tooltip}
						{/if}
					</div>
				</div>
				<div id="aNameAuthor">
					{if $permission}
						<a id="aDelete" href="el-gallery_delete.php?arquivoId={$arquivo.arquivoId}">{tooltip name="apagar-arquivo-acervo" text="Apagar esse arquivo"}<img src="styles/estudiolivre/iDelete.png"/>{/tooltip}</a>
					{/if}
					<div id="aName">
						{ajax_input permission=$permission class="gUpEdit" id="titulo" value=$arquivo.titulo default="Titulo" display="inline"}
					</div>
					<div id="aAuthorDate">
						por <a href="el-user.php?view_user={$arquivo.autor}">{$arquivo.autor}</a> em <i>{$arquivo.data_publicacao|date_format:"%d/%m/%Y"}</i>
					</div>
				</div>
			</div>
					
			<div id="aActions">
				{if $user}
					{tooltip text="Clique para votar ou para mudar o seu voto"}<span>
					{section name=rating start=1 loop=6 step=1}
				    	{if $arquivo.userRating && $arquivo.userRating >= $smarty.section.rating.index}
			  		    	<img id="aRatingVote-{$smarty.section.rating.index}" src="styles/estudiolivre/iStarOn.png" border="0" onClick="acervoVota({$smarty.section.rating.index})"/>
				    	{else}
				        	<img id="aRatingVote-{$smarty.section.rating.index}" src="styles/estudiolivre/iStarOff.png" border="0" onClick="acervoVota({$smarty.section.rating.index})"/>
					    {/if}
				    {/section}
				    </span>{/tooltip}
			    {/if}
			</div>			
			<div id="aTags">
				{foreach from=$arquivo.tags.data item=t}
			        <a class="freetag" href="tiki-browse_freetags.php?tag={$t.tag}">{$t.tag}</a>,
    			{foreachelse}
      				&nbsp;
    			{/foreach}
			</div>
		</div>
	</div>
	<br style="line-height: 25px"/>
	<div id="aMiddle">
		
		<!-- comentarios -->

		{if $tiki_p_read_comments eq 'y'}
		<div id="aComments">
			<div id="aCommentsTitle" class="sectionTitle">
				<div class="aTitleCont">
					<a href="#comments" onClick="flip('aCommentsItemsCont'); flip('aCommentSend'); return false;">
						<img onclick="this.toggleImage('iArrowGreyRight.png')" src="styles/estudiolivre/iArrowGreyDown.png">
					</a>
					<h1>Comentários ({$comments_cant})</h1>
					<img id="aCommentsRss" src="styles/estudiolivre/iRss.png"/>
				</div>
			</div>
			<div id="aCommentsItemsCont" class="aItemsCont" style="display:block">
				{if $comments_cant > 0}
				{foreach from=$comments_coms item='comment'}
					<div class="uMsgItem">
						<div class="uMsgAvatar">
							<img alt="" title="" src="tiki-show_user_avatar.php?user={$comment.userName}">
						</div>
						<div class="uMsgTxt">
							{if ($tiki_p_remove_comments eq 'y' && $forum_mode ne 'y') || ($tiki_p_admin_forum eq 'y' and $forum_mode eq 'y')}
							<div class="uMsgDel">
								<a href="{$comments_complete_father}comments_threshold={$comments_threshold}&amp;comments_threadId={$comment.threadId}&amp;comments_remove=1&amp;comments_offset={$comments_offset}&amp;comments_sort_mode={$comments_sort_mode}&amp;comments_maxComments={$comments_maxComments}&amp;comments_parentId={$comments_parentId}&amp;comments_style={$comments_style}"><img alt="" title="Deletar Mensagem" src="styles/estudiolivre/iDelete.png"></a>
							</div>
							{/if}
							<div class="uMsgDate">
								{$comment.commentDate|date_format:"%H:%M"}<br />
								{$comment.commentDate|date_format:"%d/%m/%y"}
							</div>
							<a href="el-user.php?view_user={$comment.userName}">{$comment.userName}</a>: {$comment.parsed}
						</div>
					</div>
				{/foreach}
				{/if}
			</div>
			<div id="aCommentSend" style="display:block">
				{if $user and (($tiki_p_forum_post eq 'y' and $forum_mode eq 'y') or ($tiki_p_post_comments eq 'y' and $forum_mode ne 'y'))}
				<div id="uMsgSend">
					<form method="post" action="{$comments_father}" id='editpostform'>
		    			<input type="hidden" name="comments_reply_threadId" value="{$comments_reply_threadId|escape}" />    
					    <input type="hidden" name="comments_grandParentId" value="{$comments_grandParentId|escape}" />    
					    <input type="hidden" name="comments_parentId" value="{$comments_parentId|escape}" />
					    <input type="hidden" name="comments_offset" value="{$comments_offset|escape}" />
					    <input type="hidden" name="comments_threadId" value="{$comments_threadId|escape}" />
					    <input type="hidden" name="comments_threshold" value="{$comments_threshold|escape}" />
					    <input type="hidden" name="comments_sort_mode" value="{$comments_sort_mode|escape}" />
					    {* Traverse request variables that were set to this page adding them as hidden data *}
					    {section name=i loop=$comments_request_data}
						    <input type="hidden" name="{$comments_request_data[i].name|escape}" value="{$comments_request_data[i].value|escape}" />
					    {/section}
						<input type="hidden" name="comments_title" value="foobar" />
						<input type="submit" name="comments_postComment" value="enviar" label="enviar" id="uMsgSendSubmit" />
						<input type="text" id="uMsgSendInput" name="comments_data" value="{$comment_data|escape}"/>
					</form>
					<br /><br /><br />
				</div>
				{/if}
			</div>
		</div>
		{/if}
		<!-- fim dos comentarios -->
		
		<div id="aDescriptionInfo">
			<div id="aDesc">
				<div id="aDescTitle" class="sectionTitle">
					<div class="aTitleCont aTitleContRight">
						<a href="#" onClick="flip('aDescCont');">
							<img onclick="this.toggleImage('iArrowGreyRight.png')" src="styles/estudiolivre/iArrowGreyDown.png">
						</a>					
						<h1>Descrição</h1>
					</div>
				</div>
				<div id="aDescCont" class="aItemsCont" style="display:block">
					{ajax_textarea permission=$permission class="gUpEdit" style="width: 250px; height:125px; border: 1px inset rgb(233, 233, 174);padding: 3px;font-size: 12px; font-family: Arial, Verdana, Helvetica, Lucida, Sans-Serif;background-color: #f1f1f1;margin-bottom: 5px;" id="descricao" value=$arquivo.descricao display="block"}
				</div>
			</div>
			<div id="aInfo">
				<div id="aInfoTitle" class="sectionTitle">
					<div class="aTitleCont aTitleContRight">
						<a href="#" onClick="flip('aInfoCont'); return false;">
							<img onclick="this.toggleImage('iArrowGreyRight.png')" src="styles/estudiolivre/iArrowGreyDown.png">
						</a>					
						<h1>Detalhes do Arquivo</h1>
					</div>
				</div>
				<div id="aInfoCont" class="aItemsCont" style="display:block">
					<div id="gUpMoreOptions">
						<div class="gUpMoreOptionsItem">
							<div class="gUpMoreOptionsName">Detentor dos DA:</div>
							<span class="gUpMoreOptionsInput" style="display:inline"> {$arquivo.donoCopyright}</span>
						</div>
						<div class="gUpMoreOptionsItem">
							<div class="gUpMoreOptionsName">Produtora:</div>
							<span class="gUpMoreOptionsInput" style="display:inline"> {$arquivo.produtora}</span>
						</div>
						<div class="gUpMoreOptionsItem">
							<div class="gUpMoreOptionsName">Contato:</div>
							<span class="gUpMoreOptionsInput" style="display:inline"> {$arquivo.contato}</span>
						</div>				
						{include file="el-gallery_upload_"|cat:$arquivo.tipo|cat:".tpl"}
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<br>
<div id="save-exit" class="aSaveCancel" style="z-index: 10; display: none;">
  <img src="styles/estudiolivre/bSave.png" onClick="xajax_commit_arquivo();document.getElementById('save-exit').style.display='none'" style="cursor: pointer">&nbsp;&nbsp;&nbsp;
  <img src="styles/estudiolivre/bCancelar.png" onClick="cancelEdit();document.getElementById('save-exit').style.display='none'" style="cursor: pointer">
</div>

{if $arquivo.editCache && $permission && $arquivo.user eq $user}
<div id="lightFileAltered" style="display:none; width: 400px;">
	Atenção: este arquivo foi modificado e as alterações não foram salvas!<br/>
	<span onClick="cancelEdit(); hideLightbox();" style="cursor: pointer">Cancelar</span>&nbsp;&nbsp;&nbsp;
	<span onClick="restoreEdit({$arquivo.arquivoId}); hideLightbox();" style="cursor: pointer">Restaurar</span>
</div>
<script language="Javascript">
	showLightbox('lightFileAltered');
</script>
{/if}

{include file="el-player.tpl"}

{*

<hr>
treco bizarro:<br>


  {include file="el-gallery_view_"|cat:$arquivo.tipo|cat:".tpl"}

<hr>



<div id="el-arquivo">


  <br/>
  <span style="vertical-align:top"><a id="titulo" href="el-download.php?arquivo={$arquivoId}&action=download">{$arquivo.titulo}</a>


  <!-- Isso num vai rolar nesse release --> 
  {if $arquivo.tipo eq 'Audio'}
    <object type="application/x-shockwave-flash" data="styles/estudiolivre/musicplayer.swf?&song_url=repo/{$arquivo.arquivo}" width="17" height="17"></object>
  {else}
    <a href="el-download.php?arquivo={$arquivoId}"><img src="styles/estudiolivre/entrar.png" border=0 title="stream"></a>
  {/if}
  </span>&nbsp;&nbsp;&nbsp;<a href="{$arquivo.licenca.link_human_readable}"><img src="{$arquivo.licenca.link_imagem}" border=0></a>
  <br/><br/>
  <img id="rtimg-{$arquivo.arquivoId}" src="styles/estudiolivre/rt_{math equation="round(x)" x=$arquivo.rating|default:"blk"}.png" width="16" height="16"><span id="rt-{$arquivo.arquivoId}">{$arquivo.rating}</span><br/>





<hr>

{if $tiki_p_read_comments eq 'y' || $comments_cant > 0}
	<div id="page-bar">
		<div class="button2">
			<a href="#comments" onclick="javascript:flip('comzone{if $comments_show eq 'y'}open{/if}');" class="linkbut">
				{if $comments_cant == 0}
					{tr}add comment{/tr}
				{elseif $comments_cant == 1}
					<span class="highlight">{tr}1 comment{/tr}</span>
				{else}
					<span class="highlight">{$comments_cant} {tr}comments{/tr}</span>
				{/if}
			</a>
		</div>
	</div>
	{include file=comments.tpl}
{/if}

  
  <br/>

  <img src="http://creativecommons.org/images/public/somerights20.pt.png"><br/><br/><br/>

  {if $permission}
  <form method="post" action="el-gallery_manage.php" style="display:inline">
    <input type="hidden" name="arquivoId" value="{$arquivoId}" />
    <input type="hidden" name="action" value="edit" />
    <input type="submit" value="{tr}editar{/tr}" />
  </form>
  <form method="post" action="el-gallery_manage.php" style="display:inline">
    <input type="hidden" name="arquivoId" value="{$p.arquivoId}" />
    <input type="hidden" name="action" value="delete" />
    <input type="submit" value="{tr}excluir{/tr}" />
  </form><br/><br/>
  {/if}

  <a href="el-gallery_list_files.php">voltar pra lista</a><br/><br/><br/>

</div>

*}