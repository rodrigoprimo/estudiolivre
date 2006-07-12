{if $arquivo.tamanhoImagemX || (!$arquivo.tamanhoImagemX && $permission) }
	<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Largura{/tr}:</div> {ajax_input permission=$permission value=$arquivo.tamanhoImagemX id="tamanhoImagemX" display="inline"} {tr}px{/tr}</div>
{/if}
{if $arquivo.tamanhoImagemY || (!$arquivo.tamanhoImagemY && $permission) }
	<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Altura{/tr}:</div> {ajax_input permission=$permission value=$arquivo.tamanhoImagemY id="tamanhoImagemY" display="inline"} {tr}px{/tr}</div>
{/if}
{if $arquivo.dpi || (!$arquivo.dpi && $permission) }
	<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}DPI{/tr}:</div> {ajax_input permission=$permission value=$arquivo.dpi id="dpi" display="inline"}</div>
{/if}
