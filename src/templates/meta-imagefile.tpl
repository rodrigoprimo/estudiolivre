{if $file->width || (!$file->width && $permission) }
	<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Largura{/tr}:</div> {ajax_input permission=$permission value=$file->width id="width" display="inline" file=$viewFile} {tr}px{/tr}</div>
{/if}
{if $file->height || (!$file->height && $permission) }
	<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Altura{/tr}:</div> {ajax_input permission=$permission value=$file->height id="height" display="inline" file=$viewFile} {tr}px{/tr}</div>
{/if}
{if $file->dpi || (!$file->dpi && $permission) }
	<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}DPI{/tr}:</div> {ajax_input permission=$permission value=$file->dpi id="dpi" display="inline" file=$viewFile}</div>
{/if}
