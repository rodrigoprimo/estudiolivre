{css extra=list,el-gallery_list_item}
<div id="live">
	<div class="titlebar head">
		{tr}Canais ao vivo{/tr}
	</div>
	<p>
		<a href="tiki-index.php?page=faq+Ao+Vivo">{tr}Descubra como usar os canais ao vivo do estudiolivre{/tr}</a>.
	</p>
	{foreach from=$sources item=source}
		<div class="listItem">
			<div class="listLeft">
				{tooltip text="<b>Veja</b> esse canal clicando aqui"}
					<a href="{$source->listenurl}">
					{if $source->server_type eq 'audio/mpeg' || ($source->server_type eq 'application/ogg' && $source->subtype eq 'Vorbis')}
			  			{*tr}Canal de Áudio{/tr*}
			  			{assign var=video value=0}
			  			<img src="styles/{$style|replace:".css":""}/img/iThumbAudioPlay.png">
			  		{else}
			  			{assign var=video value=1}
			  			{*tr}Canal de Vídeo{/tr*}
			    		<img src="styles/{$style|replace:".css":""}/img/iThumbVideoPlay.png">
			  		{/if}
			  		<br/>
				</a>
				{/tooltip}			
		  	</div>
		  	
		  	<h2><a href="{$source->listenurl}">{$source->server_name}</a></h2>
		  	<h5><a href="{$source->server_url}">{$source->server_url}</a></h5>
		  	<div class="listInfo">
		  		<h3>
		  			{$source->server_description} <br/>
		  		</h3>
		  		<h4>
				<div class="asRow">
					<span class="lef">
						{tr}Gênero{/tr}: <em>{$source->genre}</em>
					</span>
					<span class="mid">
						{tr}Visitantes{/tr}: <em>{$source->listeners}</em>
						{tr}Máximo de Visitantes{/tr}: <em>{$source->listener_peak}</em><br>
					</span>	
					<span class="rig">
						{tr}BitRate{/tr}: <em>{$source->bitrate|default:$source->ice-bitrate}</em>
					</span>
				</div>
				<br/>
				<div class="asRow">
						{if $video}
							<span class="lef">
								{tr}Size{/tr}: <em>{$source->frame_size}</em>
							</span>
							<span class="mid">
								{tr}Frame rate{/tr}: <em>{$source->frame_rate}</em>
							</span>
						{/if}
				</div>
			</div>
		</div>
	{foreachelse}
		{tr}Nada ao vivo no EL no momento{/tr}...
		<br/>
		{tr}Mas se você estiver procurando alguma coisa para ver, ouvir ou ler, não deixe de apreciar a diversidade do {/tr} <a href="el-gallery_home.php">{tr}acervo{/tr}</a>!!!
	{/foreach}
</div>