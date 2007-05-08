{css extra=el-gallery_metadata,el-user_msg,ajax_inputs}
<!-- el-gallery_view.rpl begin -->

<script language="JavaScript" src="lib/js/freetags.js"></script>
<script language="JavaScript" src="lib/js/el_array.js"></script>
<script language="JavaScript" src="lib/js/edit_field_ajax.js"></script>
<script language="JavaScript" src="lib/js/file_edit.js"></script>
<script language="JavaScript" src="lib/js/el-rating.js"></script>
<script language="JavaScript" src="lib/js/delete_file.js"></script>

<div id="arqCont">
	<div id="aTopCont">
		<div id="aThumbRatingLic">
			<div id="aRating">
				{tooltip name="view-avaliacao" text="Avaliação atual"}
					<img id="ajax-aRatingImg" src="styles/{$style|replace:".css":""}/img/star{math equation="round(x)" x=$arquivo->rating|default:"blk"}.png">
				{/tooltip}
			</div>
			<div id="aThumbLic">
				<div id="aLic">
					     {tooltip name="arq-descricao-licenca" text=$arquivo->license->description}
					     <a href="{$license->humanReadableLink}"><img src="styles/{$style|replace:".css":""}/img/{$arquivo->license->imageName}"></a>
					     {/tooltip}
				</div>

				{if $arquivo->thumbnail}
					<img id="ajax-thumbnail" src="repo/{$arquivo->thumbnail|escape:'url'}" height="100" width="100">
				{else}
					<img id="ajax-thumbnail" src="styles/{$style|replace:".css":""}/img/iThumb{$arquivo->type}.png" height="100" width="100">
				{/if}
				<div id="gUserThumbStatus"></div>
				{if $permission}
					<div id="aThumbForm">
				        {tooltip text="Clique para selecionar outra <b>miniatura</b> para o arquivo"}
				        <form action="el-gallery_upload_thumb.php?UPLOAD_IDENTIFIER=thumb.{$uploadId}" method="post" enctype="multipart/form-data" name="thumbForm" target="thumbUpTarget">
						  	<input type="hidden" name="UPLOAD_IDENTIFIER" value="thumb.{$uploadId}">
						  	<input type="hidden" name="arquivoId" value="{$arquivo->id}">
						  	<input type="file" name="thumb" onChange="changeThumbStatus()" id="aThumbFormButton">
				        </form>
				        {/tooltip}
				    </div>
					<iframe name="thumbUpTarget" style="display:none" onLoad="finishUpThumb();"></iframe>
				{/if}
			</div>
		</div>
		
		{assign var=file value=$arquivo->filereferences[0]}
		<div id="aMainInfo">
			<div id="aNameAuthorDown">
				<div id="aDown">
					<div id="gDownload">
						<span class="gDownloadCount">
							{$file->downloads}
						</span>
						{tooltip name="view-baixe-arquivo" text="Copie o arquivo (para o seu computador)"}
						<a href="el-download.php?arquivo={$arquivoId}&action=download">
						  <img alt="" src="styles/{$style|replace:".css":""}/img/iDownload.png">
						</a>
						{/tooltip}
					</div>
					<div id="gPlay">
						{if $arquivo->type eq "Video"}
							{if preg_match("/.*\.ogg$/i", $file->fileName)}
			    				{assign var='tooltipText' value="Assista a esse vídeo"}
						    {/if}
						    {*PRA QUANDO ROLAR COLOCAR TUTORIAIS em SWF
						    if preg_match("/.*\.swf$/i", $file->fileName)}
						    	{assign var='tooltipText' value="Veja esse swf"}
						    {/if
						    *}
						{elseif $arquivo->type eq "Audio"}
							{if preg_match("/.*\.ogg$/i", $file->fileName)}
						    	{assign var='tooltipText' value="Ouça essa música"}
						    {/if}
						{elseif $arquivo->type eq "Imagem"}
							{if !preg_match("/.*\.svg$/i", $file->fileName)}
						    	{assign var=tooltipText value="{tr}Veja essa imagem{/tr}"}
						    {/if}
						{/if}
						{if $tooltipText}
							<span class="gStreamCount">
								{$file->streams}
							</span>
							{tooltip name="view-iplay-" text=$tooltipText}
								<img class="pointer" alt="" src="styles/{$style|replace:".css":""}/img/iPlay.png" onClick="xajax_streamFile({$arquivo->id}, '{$arquivo->type}', getPageSize()[0])">
							{/tooltip}
						{/if}
					</div>
				</div>
				<div id="aNameAuthor">
					{if $permission}
						{tooltip name="apagar-arquivo-acervo" text="Apagar esse arquivo"}<img id="aDelete" class="pointer" onClick="deleteFile({$arquivo->id}, {$dontAskDelete}, 0);" src="styles/{$style|replace:".css":""}/img/iDelete.png"/>{/tooltip}
					{/if}
					<div id="aName">
						{if $permission}
							{tooltip text="Clique para modificar o nome desse arquivo"}{ajax_input permission=$permission id="title" value=$arquivo->title default="Titulo" display="inline"}{/tooltip}
						{else}
							{ajax_input permission=$permission id="title" value=$arquivo->title default="Titulo" display="inline"}
						{/if}
					</div>
					<div id="aAuthorDate">
						<b>{tr}autor{/tr}:</b> {ajax_input permission=$permission id="author" value=$arquivo->author default="Autor da Obra" display="inline"} <b>{tr}enviado por{/tr}:</b> <a href="el-user.php?view_user={$arquivo->user}">{$arquivo->user}</a><br><b>{tr}em{/tr}:</b> <i>{$arquivo->publishDate|date_format:"%d/%m/%Y"}</i>
					</div>
				</div>
			</div>
					
			<div id="aActions">
				{if $user}
					<div>
					{assign var=userVote value=$arquivo->getUserVote()}
					{section name=rating start=1 loop=6 step=1}
						{if not $smarty.section.rating.first}{assign var=plural value="s"}{/if}
						{tooltip name="arquivo_vote" text="Clique para mudar o seu voto para <b>"|cat:$smarty.section.rating.index|cat:" estrela"|cat:$plural|cat:"</b>"}
					    	{if $userVote->rating && $userVote->rating >= $smarty.section.rating.index}
				  		    	<img class="pointer" id="aRatingVote-{$smarty.section.rating.index}" src="styles/{$style|replace:".css":""}/img/iStarOn.png" onClick="acervoVota({$smarty.section.rating.index})"/>
					    	{else}
					        	<img class="pointer" id="aRatingVote-{$smarty.section.rating.index}" src="styles/{$style|replace:".css":""}/img/iStarOff.png" onClick="acervoVota({$smarty.section.rating.index})"/>
						    {/if}
					    {/tooltip}
				    {/section}
				    </div>
			    {/if}
			    <center>
	  				{tr}Total de votos desse arquivo{/tr}: <span id="ajax-aVoteTotal">{$arquivo->getArraySize('votes')}</span>
  				</center>
			</div>
		</div>
	</div>
	{assign var=fileTags value=$arquivo->tags}
	{if $permission}
		{tooltip text="Clique para editar as <b>tags</b> desse arquivo"}<img class="aTagsEdit pointer" src="styles/{$style|replace:".css":""}/img/iTagEdit.png" onClick="editaCampo('tags')">{/tooltip}
	{/if}
	<div class="aTags" id="show-tags">
		{include file="el-gallery_tags.tpl"}
	</div>
	
	{if $permission}
		<input class="aTagsInput" id="input-tags" value="{$arquivo->tagString}" onBlur="xajax_editTags(this.value)" style="display:none;">
		<img id="error-tags" class="gUpErrorImg" style="display: none" src="styles/{$style|replace:".css":""}/img/errorImg.png" onMouseover="tooltip(errorMsg_tags);" onMouseout="nd();"> 
		<script language="JavaScript">  display["tags"] = "block";errorMsg_tags = "";</script>
	{/if}
	<br style="line-height: 25px"/>
	<div id="aMiddle">
		
		<!-- comentarios -->

		{if $tiki_p_read_comments eq 'y'}
		{assign var=comments value=$arquivo->getArraySize('comments')}
		<div id="aComments">
			<div id="aCommentsTitle" class="sectionTitle">
				<div class="aTitleCont">
					<span class="hiddenPointer" onclick="flip('aCommentsItemsCont'); flip('aCommentSend');toggleImage(document.getElementById('comTArrow'),'iArrowGreyRight.png')">
						<img id="comTArrow" src="styles/{$style|replace:".css":""}/img/iArrowGreyDown.png">
						<h1>{tr}Comentários{/tr} ({$comments})</h1>
					</span>
					<!--img id="aCommentsRss" src="styles/{$style|replace:".css":""}/img/iRss.png"/-->
				</div>
			</div>
			<div id="aCommentsItemsCont" class="aItemsCont" style="display:block">
				{if $comments > 0}
				{foreach from=$arquivo->comments item='comment'}
					<div class="uMsgItem">
						<div class="uMsgAvatar">
							<img src="tiki-show_user_avatar.php?user={$comment->user}">
						</div>
						<div class="uMsgTxt">
							{if ($tiki_p_remove_comments eq 'y' && $forum_mode ne 'y') || ($tiki_p_admin_forum eq 'y' and $forum_mode eq 'y') || ($user eq $comment->user)}
							<div class="uMsgDel">
								<a href="{$comments_complete_father}comments_threshold={$comments_threshold}&amp;comments_threadId={$comment.threadId}&amp;comments_remove=1&amp;comments_offset={$comments_offset}&amp;comments_sort_mode={$comments_sort_mode}&amp;comments_maxComments={$comments_maxComments}&amp;comments_parentId={$comments_parentId}&amp;comments_style={$comments_style}"><img alt="" title="Deletar Mensagem" src="styles/{$style|replace:".css":""}/img/iDelete.png"></a>
							</div>
							{/if}
							<div class="uMsgDate">
								{$comment->date|date_format:"%H:%M"}<br />
								{$comment->date|date_format:"%d/%m/%y"}
							</div>
							<a href="el-user.php?view_user={$comment->user}">{$comment->user}</a>: {$comment->comment}
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
						<input type="submit" name="comments_postComment" value="{tr}enviar{/tr}" label="enviar" id="uMsgSendSubmit" />
						{if !$comments_cant}
							{tooltip text="Seja @ primeir@ a comentar! Digite aqui o seu comentário e clique em <b>enviar</b>"}
								<input type="text" id="uMsgSendInput" name="comments_data" value="{$comment_data|escape}"/>
							{/tooltip}
						{else}
							{tooltip text="Digite o seu comentário e clique em <b>enviar</b>"}
								<input type="text" id="uMsgSendInput" name="comments_data" value="{$comment_data|escape}"/>
							{/tooltip}
						{/if}
					</form>
					<br /><br /><br />
				</div>
				{/if}
				{if !$user}
					{tr}Faça o login para comentar!{/tr}
				{/if}
			</div>
		</div>
		{/if}
		<!-- fim dos comentarios -->
		
		<div id="aDescriptionInfo">
			<div id="aDesc">
				<div id="aDescTitle" class="sectionTitle">
					<div class="aTitleCont aTitleContRight">
						<span class="hiddenPointer" onclick="flip('aDescCont');toggleImage(document.getElementById('desTArrow'),'iArrowGreyRight.png')" >
							<img id="desTArrow" src="styles/{$style|replace:".css":""}/img/iArrowGreyDown.png">
							<h1>{tr}Descrição{/tr}</h1>
						</span>
					</div>
				</div>
				<div id="aDescCont" class="aItemsCont" style="display:block">
					{if $permission}
						{tooltip text="Clique aqui para modificar a descri&ccedil;&atilde;o do arquivo"}{ajax_textarea permission=$permission style="width: 250px; height:125px; border: 1px inset rgb(233, 233, 174);padding: 3px;font-size: 12px; font-family: Arial, Verdana, Helvetica, Lucida, Sans-Serif;background-color: #f1f1f1;margin-bottom: 5px;" id="description" value=$arquivo->description display="block" wikiParsed=1}{/tooltip}
					{else}
						{ajax_textarea permission=$permission style="width: 250px; height:125px; border: 1px inset rgb(233, 233, 174);padding: 3px;font-size: 12px; font-family: Arial, Verdana, Helvetica, Lucida, Sans-Serif;background-color: #f1f1f1;margin-bottom: 5px;" id="description" value=$arquivo->description display="block" wikiParsed=1}
					{/if}
				</div>
			</div>
			<div id="aInfo">
				<div id="aInfoTitle" class="sectionTitle">
					<div class="aTitleCont aTitleContRight">
						<span class="hiddenPointer" onclick="flip('aInfoCont');toggleImage(document.getElementById('detTArrow'),'iArrowGreyRight.png')" >
							<img id="detTArrow" src="styles/{$style|replace:".css":""}/img/iArrowGreyDown.png">
							<h1>{tr}Detalhes do Arquivo{/tr}</h1>
						</span>
					</div>
				</div>
				<div id="aInfoCont" class="aItemsCont" style="display:block">
					<div id="gUpMoreOptions">
						<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Formato{/tr}:</div> {$arquivo->type} - {$file->mimeType|show_extension}</div>
						<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Tamanho{/tr}:</div> {$file->size|show_filesize}</div>
						{include file="el-gallery_metadata.tpl"}
						{if $arquivo->type neq "Texto"}
							{include file="el-gallery_metadata_"|cat:$arquivo->type|cat:".tpl"}
						{/if}
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

{*if $permission && $arquivo.user eq $user}
<div id="lightFileAltered" style="display:none; width: 400px;">
	{tr}Atenção: este arquivo foi modificado e as alterações não foram salvas!{/tr}<br/>
	<span onClick="cancelEdit(); hideLightbox();" style="cursor: pointer">{tr}Cancelar{/tr}</span>&nbsp;&nbsp;&nbsp;
	<span onClick="restoreEdit({$arquivo.arquivoId}); hideLightbox();" style="cursor: pointer">{tr}Restaurar{/tr}</span>
</div>
<script language="Javascript">
	showLightbox('lightFileAltered');
</script>
{/if*}

{include file="el-gallery_confirm_delete.tpl"}

<!-- el-gallery_view.rpl end -->
