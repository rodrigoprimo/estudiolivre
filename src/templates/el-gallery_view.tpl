<!-- el-gallery_view.tpl begin -->
{css extra=el-gallery_metadata,el-user_msg,ajax_inputs}

<script language="JavaScript" src="lib/js/freetags.js"></script>
<script language="JavaScript" src="lib/js/el_array.js"></script>
<script language="JavaScript" src="lib/js/edit_field_ajax.js"></script>
<script language="JavaScript" src="lib/js/uploadThumb.js"></script>
<script language="JavaScript" src="lib/js/el-rating.js"></script>
<script language="JavaScript" src="lib/js/delete_file.js"></script>

<table class="pubT">
	<tr>
	<td class="td1">
	<div id="pubTitulo">
		<img class="fl" src="styles/{$style|replace:".css":""}/img/iUp{$arquivo->type}.png">
		<div id="pubNome">
			{if $permission}
				{tooltip text="Clique para modificar o nome desse arquivo"}{ajax_input permission=$permission id="title" value=$arquivo->title default="Titulo" display="inline"}{/tooltip}
			{else}
				{ajax_input permission=$permission id="title" value=$arquivo->title default="Titulo" display="inline"}
			{/if}
		</div>
	</div>
	<br class="c"/>
	<div id="pubInfo">
		<span class="info">
			<b>{tr}autor{/tr}:</b> {ajax_input permission=$permission id="author" value=$arquivo->author default="Autor da Obra" display="inline"}<br/>
			<b>{tr}por{/tr}:</b> <a href="el-user.php?view_user={$arquivo->user}">{$arquivo->user}</a><br/>
			<b>{tr}em{/tr}:</b> <i>{$arquivo->publishDate|date_format:"%d/%m/%Y"}</i><br/>
		</span>
		{tooltip text=$arquivo->license->description}
			<a href="{$license->humanReadableLink}"><img src="styles/{$style|replace:".css":""}/img/h_{$arquivo->license->imageName}"></a>
		{/tooltip}
		{tooltip text="Copie todos os arquivos (para o seu computador)"}
		<div>
			<a href="el-download.php?arquivo={$arquivoId}&action=downloadAll">
				<img class="fl" alt="download all" src="styles/{$style|replace:".css":""}/img/iDownload.png">
				<span class="info">
					{tr}baixe tudo{/tr}<br/>
					{assign var=numArquivos value=$arquivo->getArraySize('filereferences')}
					{$numArquivos} {tr}arquivo{/tr}{if $numArquivos > 1}s{/if}<br/>
	 				xis mb
				</span>
			</a>
		
		</div>
		{/tooltip}
	</div>
	
	<div id="pubRating">
		{tooltip name="view-avaliacao" text="Avaliação atual"}
			<img id="ajax-aRatingImg" src="styles/{$style|replace:".css":""}/img/star{math equation="round(x)" x=$arquivo->rating|default:"blk"}.png"><br/>		
		{/tooltip}
		<b>{tr}votos{/tr}:</b> <span id="ajax-aVoteTotal">{$arquivo->getArraySize('votes')}</span>
		{if $user}
			<br/>
			{assign var=userVote value=$arquivo->getUserVote()}
			{section name=rating start=1 loop=6 step=1}
				{if not $smarty.section.rating.first}{assign var=plural value="s"}{/if}
				{tooltip text="Clique para mudar o seu voto para <b>"|cat:$smarty.section.rating.index|cat:" estrela"|cat:$plural|cat:"</b>"}
			    	{if $userVote->rating && $userVote->rating >= $smarty.section.rating.index}
		  		    	<img class="pointer" id="aRatingVote-{$smarty.section.rating.index}" src="styles/{$style|replace:".css":""}/img/iStarOn.png" onClick="acervoVota({$smarty.section.rating.index})"/>
			    	{else}
			        	<img class="pointer" id="aRatingVote-{$smarty.section.rating.index}" src="styles/{$style|replace:".css":""}/img/iStarOff.png" onClick="acervoVota({$smarty.section.rating.index})"/>
				    {/if}
			    {/tooltip}
		    {/section}
		    <br/>
		    <b>vote!</b>
		{/if}
		<br/>
		{if $permission}
			{tooltip text="Apagar essa publicação <br/>(e <b>todos</b> seus arquivos!)"}
				<img id="aDelete" class="pointer" onClick="deleteFile({$arquivo->id}, {$dontAskDelete}, 0);" src="styles/{$style|replace:".css":""}/img/iDelete.png"/>
			{/tooltip}
		{/if}
	</div>
	</td>
	<td>

	<div id="pubDesc">
		<span class="hiddenPointer" onclick="flip('aDescCont');toggleImage(document.getElementById('desTArrow'),'iArrowGreyRight.png')" >
			<img id="desTArrow" src="styles/{$style|replace:".css":""}/img/iArrowGreyDown.png">
			<h1>{tr}Descrição{/tr}</h1>
		</span>
	
		<div id="aDescCont" class="aItemsCont" style="display:block">
			{if $permission}
				{tooltip text="Clique aqui para modificar a descri&ccedil;&atilde;o do arquivo"}{ajax_textarea permission=$permission style="width: 250px; height:125px; border: 1px inset rgb(233, 233, 174);padding: 3px;font-size: 12px; font-family: Arial, Verdana, Helvetica, Lucida, Sans-Serif;background-color: #f1f1f1;margin-bottom: 5px;" id="description" value=$arquivo->description display="block" wikiParsed=1}{/tooltip}
			{else}
				{ajax_textarea permission=$permission style="width: 250px; height:125px; border: 1px inset rgb(233, 233, 174);padding: 3px;font-size: 12px; font-family: Arial, Verdana, Helvetica, Lucida, Sans-Serif;background-color: #f1f1f1;margin-bottom: 5px;" id="description" value=$arquivo->description display="block" wikiParsed=1}
			{/if}
		</div>
	</div>
	</td>
	</tr>
</table>

<div id="pubTags">
	<b>{tr}tags{/tr}:</b>&nbsp;
	{assign var=fileTags value=$arquivo->tags}
	
	<div class="aTags" id="show-tags">
		{include file="el-gallery_tags.tpl"}
	</div>
	
	{if $permission}
		<input class="aTagsInput" id="input-tags" value="{$arquivo->tagString}" onBlur="xajax_save_field('tags', this.value)" style="display:none;">
		<img id="error-tags" class="gUpErrorImg" style="display: none" src="styles/{$style|replace:".css":""}/img/errorImg.png" onMouseover="tooltip(errorMsg_tags);" onMouseout="nd();"> 
		<script language="JavaScript">  display["tags"] = "block";errorMsg_tags = "";</script>
		&nbsp;{tooltip text="Clique para editar as <b>tags</b> desse arquivo"}<img class="aTagsEdit pointer" src="styles/{$style|replace:".css":""}/img/iTagEdit.png" onClick="editaCampo('tags')">{/tooltip}
	{/if}
</div>
<br><br>
incluir template especifico do arquivo
<br><br>
<div>
</div>

<table class="pubT">
	<tr>
	<td class="td1">
		<span class="hiddenPointer" onclick="flip('pubFilesCont');toggleImage(document.getElementById('filesTArrow'),'iArrowGreyRight.png')" >
			<img id="filesTArrow" src="styles/{$style|replace:".css":""}/img/iArrowGreyDown.png">
			<h1>{tr}Arquivos da Publicação{/tr}</h1>
		</span>
		<br/>
		<div id="pubFilesCont" class="aItemsCont" style="display:block">
			{foreach from=$arquivo->filereferences item=file key=key}
				<div class="file">
					{if $file->thumbnail}
						<img class="fl" id="ajax-thumbnail" src="repo/{$file->thumbnail|escape:'url'}" height="100" width="100">
					{else}
						<img class="fl" id="ajax-thumbnail" src="styles/{$style|replace:".css":""}/img/iThumb{$arquivo->type}.png" height="100" width="100">
					{/if}
					<div class="info">
						<b>{$file->parseDownloadName()}<br/>
						{$file->size|show_filesize}</b><br/>
						<br/>
						<a href="el-gallery_view.php?arquivoId={$arquivoId}&file={$key}">{tr}ver{/tr}</a> ({$file->downloads} {tr}visualizações{/tr})<br/>
						<a href="el-download.php?arquivo={$arquivoId}&file={$key}">{tr}baixar{/tr}</a> ({$file->streams} {tr}downloads{/tr})<br/>
						<a href="repo/{$file->fileName}">{tr}link pro arquivo{/tr}</a><br/>
					</div>
				</div>
			{/foreach}
		</div>
	</td>
	<td>
		<div>
			<span class="hiddenPointer" onclick="flip('aInfoCont');toggleImage(document.getElementById('detTArrow'),'iArrowGreyRight.png')" >
				<img id="detTArrow" src="styles/{$style|replace:".css":""}/img/iArrowGreyDown.png">
				<h1>{tr}Detalhes da Publicação{/tr}</h1>
			</span>
			<br/>
			<div id="aInfoCont" class="aItemsCont" style="display:block">
				{if $permission}
					{if $arquivo->thumbnail}
						<img id="ajax-thumbnail" src="repo/{$arquivo->thumbnail|escape:'url'}" height="100" width="100">
					{else}
						<img id="ajax-thumbnail" src="styles/{$style|replace:".css":""}/img/iThumb{$arquivo->type}.png" height="100" width="100">
					{/if}
					<div id="js-thumbStatus"></div>
					<div id="aThumbForm">
				        {tooltip text="Clique para selecionar outra <b>miniatura</b> para o arquivo"}
				        <form action="el-gallery_upload_thumb.php" method="post" enctype="multipart/form-data" name="thumbForm" target="thumbUpTarget">
						  	<input type="hidden" name="UPLOAD_IDENTIFIER" value="thumb.{$uploadId}">
						  	<input type="hidden" name="arquivoId" value="{$arquivo->id}">
						  	<input type="file" name="thumb" onChange="thumbSelected()" id="aThumbFormButton">
				        </form>
				        {/tooltip}
				    </div>
					<iframe name="thumbUpTarget" style="display:none" onLoad="finishUpThumb();"></iframe>
				{/if}
				<div id="gUpMoreOptions">
					{include file="el-gallery_metadata.tpl"}
					{if $arquivo->type neq "Texto"}
						{include file="el-gallery_metadata_"|cat:$arquivo->type|cat:".tpl"}
					{/if}
				</div>
			</div>
			
			<!-- comentarios -->
			{if $tiki_p_read_comments eq 'y'}
			{assign var=comments value=$arquivo->getArraySize('comments')}
			<div id="aComments">
				<div id="aCommentsTitle" class="sectionTitle">
					<div class="aTitleCont">
						<span class="hiddenPointer" onclick="flip('ajax-aCommentsItemsCont'); flip('aCommentSend');toggleImage(document.getElementById('comTArrow'),'iArrowGreyRight.png')">
							<img id="comTArrow" src="styles/{$style|replace:".css":""}/img/iArrowGreyDown.png">
							<h1>{tr}Comentários{/tr} (<span id="ajax-commentCount">{$comments}</span>)</h1>
						</span>
					</div>
				</div>
				<div id="ajax-aCommentsItemsCont" class="aItemsCont" style="display:block">
					{if $comments > 0}
					{foreach from=$arquivo->comments item='comment'}
						{include file="el-publication_comment.tpl"}
					{/foreach}
					{/if}
				</div>
				<div id="aCommentSend" style="display:block">
					{if $user and (($tiki_p_forum_post eq 'y' and $forum_mode eq 'y') or ($tiki_p_post_comments eq 'y' and $forum_mode ne 'y'))}
					<div id="uMsgSend">
						<input type="submit" value="{tr}enviar{/tr}" label="enviar" id="uMsgSendSubmit" onClick="xajax_comment(document.getElementById('uMsgSendInput').value);" />
						{if !$comments}
							{tooltip text="Seja @ primeir@ a comentar! Digite aqui o seu comentário e clique em <b>enviar</b>"}
								<input type="text" id="uMsgSendInput" name="comment" />
							{/tooltip}
						{else}
							{tooltip text="Digite o seu comentário e clique em <b>enviar</b>"}
								<input type="text" id="uMsgSendInput" name="comment" />
							{/tooltip}
						{/if}
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
		</div>
	</td>
	</tr>
</table>