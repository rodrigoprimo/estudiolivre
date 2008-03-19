<div id="ajax-file{$key}" class="file{if isset($viewFile) && ($key == $viewFile)} viewing{/if}">
	{if $file->thumbnail}
		<img class="fl" id="ajax-thumbnail" src="{$file->baseDir}{$file->thumbnail|escape:'url'}" height="100" width="100">
	{else}
		<img class="fl" id="ajax-thumbnail" src="styles/{$style|replace:".css":""}/img/iThumb{$file->type}.png" height="100" width="100">
	{/if}
	<div class="info">
		<b>{$file->fileName|truncate:20:"(...)"}<br/>
		{$file->size|show_filesize}</b>
		{if $permission}
			{tooltip text="Apagar este arquivo!"}
				<img class="pointer" onClick="xajax_deleteFileReference({$key});" src="styles/{$style|replace:".css":""}/img/iDelete.png"/>
			{/tooltip}
		{/if}
		<br/>
		<br/>
		{if $file->isViewable()}
			<a href="el-gallery_view.php?arquivoId={$arquivoId}&file={$key}">{tr}ver{/tr}</a> ({$file->streams} {tr}visualizações{/tr})<br/>
		{/if}
		{if $file->commandLine && $permission}
			<span class="pointer" onClick="xajax_expandFile({$file->id})"><b>expandir</b></span><br/>
		{/if}
		<a href="el-download.php?pub={$arquivoId}&file={$key}">{tr}baixar{/tr}</a> ({$file->downloads} {tr}downloads{/tr})<br/>
		<a href="{$file->fullPath()}">{tr}link pro arquivo{/tr}</a><br/>
	</div>
</div>
<br class="c"/>