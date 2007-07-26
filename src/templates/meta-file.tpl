{if $file->mimeType}
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Formato{/tr}:</div> {$file->mimeType}</div>
{/if}

<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Tamanho{/tr}:</div> {$file->size|show_filesize}</div>

<input type="checkbox"{if $arquivo->mainFile === $viewFile} checked{/if} onClick="xajax_setMainFile(this.checked ? 1 : 0, {$viewFile})"/>
arquivo de capa<br/>

{if $file->type neq "Zip"}
	{include file="meta-"|cat:$file->actualClass|lower|cat:".tpl"}
{/if}
