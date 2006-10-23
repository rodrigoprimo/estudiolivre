{* para os tooltips *}
{if $arquivo.tipo eq "Video"}
	{if preg_match("/.*\.ogg$/i", $arquivo.arquivo)}
		{assign var=tooltipText value="{tr}Assista a esse vídeo{/tr}"}
	{/if}
{elseif $arquivo.tipo eq "Audio"}
	{if preg_match("/.*\.ogg$/i", $arquivo.arquivo)}
		{assign var=tooltipText value="{tr}Ouça essa música{/tr}"}
	{/if}
{elseif $arquivo.tipo eq "Imagem"}
	{if !preg_match("/.*\.svg$/i", $arquivo.arquivo)}
		{assign var=tooltipText value="{tr}Veja essa imagem{/tr}"}
	{/if}
{/if}

<div class="listItem">
	<div class="listLeft">
		{if $arquivo.thumbnail}
			<img src="repo/{$arquivo.thumbnail|escape:'url'}">
		{else}
			<img src="styles/{$style|replace:".css":""}/img/iThumb{$arquivo.tipo}.png">
		{/if}	
		<img onmouseout="nd();" 
			 onmouseover="tooltip('{$arquivo.ratings} {tr}voto{/tr}{if ($arquivo.ratings>1 || $arquivo.ratings<1) }s{/if}<br>{tr}Avaliação - entre na página do arquivo para votar{/tr}')"
			 alt="{$arquivo.rating} estrelas"
			 src="styles/{$style|replace:".css":""}/img/star{math equation="round(x)" x=$arquivo.rating|default:"blk"}.png"
			 class="listRating">
		<br />
		{tooltip name="list-baixe-arquivo" text="Copie o arquivo (para o seu computador)"}
			<a href="el-download.php?arquivo={$arquivo.arquivoId}&action=download">
				baixar
			</a>
		{/tooltip}	
		{if $tooltipText}
		<br />
			{tooltip name="list-i-play" text=$tooltipText}
				<span class="pointer" alt="" onClick="xajax_streamFile({$arquivo.arquivoId},'{$arquivo.tipo}', getPageSize()[0]);nd();">
					ver
				</span>
			{/tooltip}
		{/if}
		{if $arquivo.user eq $user or $el_p_admin_gallery eq "y"}
			<br />
			{tooltip name="list-apagar-arquivo-acervo" text="Apagar esse arquivo do acervo"}
				<span class="pointer" onClick="deleteFile({$arquivo.arquivoId},{$dontAskDelete},0);nd();">{tr}apagar{/tr}</span>
			{/tooltip}
		{/if}
	</div>
	
	<h2>
		<a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}">
			{$arquivo.titulo}
		</a>
	</h2>
	
	
	<div class="listInfo">
	
		<h4>
			<div class="asRow">
				<span class="lef">
					{tr}autor{/tr}: <em>{$arquivo.autor}</em>
				</span>
				<span class="mid">
					{tr}enviado por{/tr}: <em><a href="el-user.php?view_user={$arquivo.user}">{$arquivo.user}</a></em>
					<br />
					{tr}em{/tr}: <em>{$arquivo.data_publicacao|date_format:"%d/%m/%y"}</em>
				</span>
				<span class="rig">
					{tr}tipo{/tr}: <em>{$arquivo.tipo}</em>
				</span>
			</div>
		</h4>
		
		<h3>
			{if strlen($arquivo.descricao) > 150}
				{$arquivo.descricao|truncate:150:"":true}
				<a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}">
					({tr}ler mais{/tr}...)
				</a>
			{else}
				{$arquivo.descricao}
			{/if}
		</h3>
		
		<h4>
			<div class="asRow">
				<span class="lef">
					{tr}baixado{/tr}: <em>{$arquivo.hits} {if $arquivo.streamHits == 1 }{tr}vez{/tr}{else}{tr}vezes{/tr}{/if}</em>
					{if $tooltipText}
						<br />
						{tr}visto{/tr}: <em>{$arquivo.streamHits} {if $arquivo.streamHits == 1 }{tr}vez{/tr}{else}{tr}vezes{/tr}{/if}</em>
					{/if}
				</span>
				<span class="mid">
					{tr}comentários{/tr}:
						<em>
							{if $arquivo.commentsCount == 0}
								{tooltip name="list-primeiro-comentar" text="Seja o primeiro a comentar sobre esse arquivo"}
								<a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}#comments">
								0
								</a>
								{/tooltip}
							{else}
								{tooltip name="list-ler-comentarios" text="Clique para ler os comentários"}
									<a href="el-gallery_view.php?arquivoId={$arquivo.arquivoId}#comments">
										{$arquivo.commentsCount}
									</a>
								{/tooltip}
							{/if}
						</em>
				</span>		
				<span class="rig">
					{tr}licença{/tr}:
						{tooltip name="list-descricao-licenca" text=$arquivo.descricaoLicenca}
							<a href="{$arquivo.linkHumanReadable}">
								<img src="styles/{$style|replace:".css":""}/img/h_{$arquivo.linkImagem}">
							</a>
						{/tooltip}
				</span>
			</div>
		</h4>
		
		<h4>
			<span>
				tags:
				<em>
					{foreach from=$arquivo.tags.data item=t name=tags}{tooltip text="Clique para ver outros arquivos com a tag <b>"|cat:$t.tag|cat:"</b>"}<a href="tiki-browse_freetags.php?tag={$t.tag}">{$t.tag}</a>{if not $smarty.foreach.tags.last}, {/if}{/tooltip}{foreachelse}
						{tr}Esse arquivo não tem tags{/tr}.
					{/foreach}
				</em>
			</span>
		</h4>
	</div>
</div>