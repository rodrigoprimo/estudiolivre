<div id="arqCont">
	<div id="aTopCont">
		<div id="aThumbRatingLic">		
			<div id="aRating">
				{tooltip name="view-avaliacao" text="Avaliação"}
					<img alt="{$arquivo.rating} estrelas" src="styles/estudiolivre/star{math equation="round(x)" x=$arquivo.rating|default:"blk"}.png">
				{/tooltip}
			</div>
			<div id="aThumb">
				<div id="aLic">
					<img src="styles/estudiolivre/iLicSamplingPlus.png">
				</div>
				{if sizeof($arquivo.thumbnail)}
					<img src="el-download.php?arquivo={$arquivo.arquivoId}&thumbnail=1" border=0>
				{else}
					<img height="100" src="styles/estudiolivre/iThumb{$arquivo.tipo}.png">
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
							<a href="#">
								<img alt="" src="styles/estudiolivre/iDownload.png">
							</a>
						{/tooltip}
					</div>
					<div id="gPlay">
						<span class="gStreamCount">
							00
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
					<div id="aName">
						<a id="titulo" href="el-download.php?arquivo={$arquivoId}&action=download">{$arquivo.titulo}</a>
						{if $user eq $arquivo.user}
							<form method="post" action="el-gallery_manage.php" style="display:inline">
								<input type="hidden" name="arquivoId" value="{$p.arquivoId}" />
								<input type="hidden" name="action" value="delete" />
								<input type="submit" value="{tr}excluir{/tr}" />
							</form>
						{/if}
					</div>
			
					<div id="aAuthorDate">
						por <a href="#">{$arquivo.autor}</a> em <i>{$arquivo.data_publicacao|date_format:"%d/%m/%Y"}</i>
					</div>
				</div>
			</div>
			<div id="aActions">
				<span > <img alt="{$arquivo.rating} estrelas" src="styles/estudiolivre/star{math equation="round(x)" x=$arquivo.rating|default:"blk"}.png"> </span>
			</div>			
			<div id="aTags">
				{foreach from=$freetags.data item=taginfo}
	  				<a class="freetag" href="tiki-freetag_list_objects.php?tag={$taginfo.tag}">{$taginfo.tag}</a> 
				{/foreach} tags, tags, tags, tags, tags (...)
			</div>
		</div>
	</div>
	<br />
	<div id="aMiddle">
		<div id="aComments">
			<div id="aCommentsTitle" class="uMainTitle">
				<a href="#" onClick="javascript:flip('aCommentsItemsCont'); return false;">
					<img onclick="this.toggleImage('iArrowGreyRight.png')" src="styles/estudiolivre/iArrowGreyDown.png">
				</a>
				<h1>Comentarios (9)</h1>
			</div>
			<div id="aCommentsItemsCont" class="aItemsCont" style="display:block">
				{*foreach from=$userMessages.data item='msg'*}
					<div class="uMsgItem">
						<div class="uMsgAvatar">
							<img alt="" title="" src="tiki-show_user_avatar.php?user=criscabello">
						</div>
						<div class="uMsgTxt">
							<div class="uMsgDel">
								<a href="#"><img alt="" title="Deletar Mensagem" src="styles/estudiolivre/iDelete.png"></a>
							</div>
							<div class="uMsgDate">
								11:30{$msg.date|date_format:"%H:%M"}<br />
								28/05/06{$msg.date|date_format:"%d/%m/%Y"}
							</div>
							<a href="el-user.php?view_user=uira">uira</a>: caralho, q musica massa...
						</div>
					</div>
					<hr>
				{*/foreach*}
				{* <div class="aCommentItem">
						<div class="aCommentAvatar">
							Foto
						</div>
						<div class="aCommentTxt">
							uira: vai tomar no cú, porra!
						</div>
						<div class="aCommentDate">
							11:25<br>
							25/05/2005
						</div>
						<div class="aCommentEditDel">
							editar | Deletar
						</div>
					</div> *}
			</div>
			<div id="aCommentSend">
				<div id="uMsgSend">         
					<input type="submit" name="" value="enviar" label="enviar" id="uMsgSendSubmit">
					<input type="text" id="uMsgSendInput">
					<br /><br /><br />
				</div>
			</div>
		</div>
		
		<div id="aDescriptionInfo">
			<div id="aDesc">
				<div id="aDescTitle" class="uMainTitle">
					<a href="#" onClick="javascript:flip('aDescCont'); return false;">
						<img onclick="this.toggleImage('iArrowGreyRight.png')" src="styles/estudiolivre/iArrowGreyDown.png">
					</a>					
					<h1>Descrição</h1>
				</div>
				<div id="aDescCont" class="aItemsCont" style="display:block">
					Caralho, esse arquivo eh muito doido. Baixa aí procê vê. 
					Caralho, esse arquivo eh muito doido. Baixa aí procê vê.
					Caralho, esse arquivo eh muito doido. Baixa aí procê vê.
					Caralho, esse arquivo eh muito doido. Baixa aí procê vê.
					Caralho, esse arquivo eh muito doido. Baixa aí procê vê.
					Caralho, esse arquivo eh muito doido. Baixa aí procê vê.
					Caralho, esse arquivo eh muito doido. Baixa aí procê vê.
				</div>
			</div>
			<br />
			<div id="aInfo">
				<div id="aInfoTitle" class="uMainTitle">
					<a href="#" onClick="javascript:flip('aInfoCont'); return false;">
						<img onclick="this.toggleImage('iArrowGreyRight.png')" src="styles/estudiolivre/iArrowGreyDown.png">
					</a>					
					<h1>Detalhes do Arquivo</h1>
				</div>
				<div id="aInfoCont" class="aItemsCont" style="display:block">
					<span class="campo">Detentor dos DA:</span> {$arquivo.donoCopyright}<br/>
					<span class="campo">Produtora:</span> {$arquivo.produtora}<br/>
					<span class="campo">Contato:</span> {$arquivo.contato}<br/>
				</div>
			</div>
		</div>
	</div>
</div>









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

  {if $user eq $arquivo.user}
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