<div class="file">
	{if $file->thumbnail}
		<img class="fl" id="ajax-thumbnail" src="repo/{$file->thumbnail|escape:'url'}" height="100" width="100">
	{else}
		<img class="fl" id="ajax-thumbnail" src="styles/{$style|replace:".css":""}/img/iThumb{$file->type}.png" height="100" width="100">
	{/if}
	<div class="info">
		<b>{$file->fileName}<br/>
		{$file->size|show_filesize}</b><br/>
		<br/>
		<a href="el-gallery_view.php?arquivoId={$arquivoId}&file={$key}">{tr}ver{/tr}</a> ({$file->streams} {tr}visualizações{/tr})<br/>
		<a href="el-download.php?pub={$arquivoId}&file={$key}">{tr}baixar{/tr}</a> ({$file->downloads} {tr}downloads{/tr})<br/>
		<a href="{$file->fullPath()}">{tr}link pro arquivo{/tr}</a><br/>
	</div>
</div>
<br class="c"/>