{if $arquivo.tamanhoImagemX || (!$arquivo.tamanhoImagemX && $permission) }
	<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">Largura:</div> {ajax_input permission=$permission value=$arquivo.tamanhoImagemX id="tamanhoImagemX" display="inline"} px</div>
{/if}
{if $arquivo.tamanhoImagemY || (!$arquivo.tamanhoImagemY && $permission) }
	<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">Altura:</div> {ajax_input permission=$permission value=$arquivo.tamanhoImagemY id="tamanhoImagemY" display="inline"} px</div>
{/if}
{if $arquivo.dpi || (!$arquivo.dpi && $permission) }
	<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">DPI:</div> {ajax_input permission=$permission value=$arquivo.dpi id="dpi" display="inline"}</div>
{/if}
