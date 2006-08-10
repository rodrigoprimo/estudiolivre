<div id="gListItem">

<table style="width: 530px;"  border="0" cellpadding="0" cellspacing="0">
	<tbody>
		<tr>
			<td colspan="1" rowspan="3" style="width: 22px;">
				{tooltip name="list-descricao-licenca" text=$arquivo.descricaoLicenca}
					<a href="{$arquivo.linkHumanReadable}">
						<img src="styles/estudiolivre/{$arquivo.linkImagem}">
					</a>
				{/tooltip}
			</td>
			<td colspan="1" rowspan="3" style="width: 54px;">
				<a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}">
					{if $arquivo.thumbnail}
						<img height="51px" src="repo/{$arquivo.thumbnail}">
					{else}
						<img height="51px" src="styles/estudiolivre/iThumb{$arquivo.tipo}.png">
					{/if}
				</a>
			</td>
			<td style="width: 246px;">
				{tooltip name="list-clique-pag-arquivo" text="Clique para ir para a página do arquivo"}
					<a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}">
						{$arquivo.titulo}
					</a>
				{/tooltip}
			</td>
			<td colspan="1" rowspan="2" style="width: 22px; ">
				<div id="gDownload">
					<span class="gDownloadCount">{$arquivo.hits}</span>
				    {tooltip name="list-baixe-arquivo" text="Copie o arquivo (para o seu computador)"}
				      <a href="el-download.php?arquivo={$arquivo.arquivoId}&action=download">
		    		    <img alt="" src="styles/estudiolivre/iDownload.png">
			    	  </a>
				    {/tooltip}
				</div>
			</td>
			<td colspan="1" rowspan="2" style="width: 22px;">
				<div id="gPlay">
					{if $arquivo.tipo eq "Video"}
						{assign var=tooltipText value="Assista a esse vídeo"}
					{elseif $arquivo.tipo eq "Audio"}
						{assign var=tooltipText value="Ouça essa música"}
					{elseif $arquivo.tipo eq "Imagem"}
						{assign var=tooltipText value="Veja essa imagem"}
					{/if}
					{if $tooltipText}
						<span class="gStreamCount">{$arquivo.streamHits}</span>
						{tooltip name="list-i-play" text=$tooltipText}
							<img class="pointer" alt="" src="styles/estudiolivre/iPlay.png" onClick="xajax_streamFile({$arquivo.arquivoId}, '{$arquivo.tipo}', getPageSize()[0])">
						{/tooltip}
					{/if}
				</div>
			</td>
			<td style="width: 122px;">
				<div id="gRating">
					{tooltip name="list-avaliacao-votar" text="Avaliação - entre na página do arquivo para votar"}
						<img alt="{$arquivo.rating} estrelas" src="styles/estudiolivre/star{math equation="round(x)" x=$arquivo.rating|default:"blk"}.png">
					{/tooltip}
				</div>
			</td>
			<td style="width: 30px;">
				{if $arquivo.user eq $user or $el_p_admin_gallery eq "y"}
					{tooltip name="list-editar-informacoes-arquivo" text="Editar informações do arquivo"}
						<a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}">
							<img alt="editar" src="styles/estudiolivre/iEdit.png">
						</a>
					{/tooltip}
				{/if}
			</td>
		</tr>
		<tr>
			<td style=" ">
				<b>{tr}por{/tr}:</b> <a href="el-user.php?view_user={$arquivo.user}">{$arquivo.user}</a><br><b>{tr}em{/tr}:</b> {$arquivo.data_publicacao|date_format:"%d/%m/%Y"}
			</td>
			<td style=" ">
				<div id="gComments">
					{if $arquivo.commentsCount == 0}
						{tooltip name="list-primeiro-comentar" text="Seja o primeiro a comentar sobre esse arquivo"}
							<a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}#comments">{tr}nenhum comentário{/tr}</a>
						{/tooltip}
					{else}
						{tooltip name="list-ler-comentarios" text="Clique para ler os comentários"}
							<a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}#comments">
								{$arquivo.commentsCount} {tr}comentário{/tr}{if $arquivo.commentsCount != 1}s{/if}
							</a>
						{/tooltip}
					{/if}
				</div>
			</td>
			<td style=" ">
				{if $arquivo.user eq $user or $el_p_admin_gallery eq "y"}
					{tooltip name="list-apagar-arquivo-acervo" text="Apagar esse arquivo do acervo"}
						<a href="el-gallery_delete.php?arquivoId={$arquivo.arquivoId}">
							<img alt="apagar" src="styles/estudiolivre/iDelete.png">
						</a>
					{/tooltip}
				{/if}
			</td>
		</tr>
		<tr>
			<td colspan="5" rowspan="1" style="width: 122px;">
				<div id="gTags">
					{foreach from=$arquivo.tags.data item=t name=tags}
						{tooltip text="Clique para ver outros arquivos com a tag <b>"|cat:$t.tag|cat:"</b>"}
							<a href="tiki-browse_freetags.php?tag={$t.tag}">{$t.tag}</a>{if not $smarty.foreach.tags.last},{/if}
						{/tooltip}
					{foreachelse}
						{tooltip text="Esse arquivo não tem tags"}<div>&nbsp;</div>{/tooltip}
					{/foreach}
				</div>
			</td>
		</tr>
	</tbody>
</table>

</div>
