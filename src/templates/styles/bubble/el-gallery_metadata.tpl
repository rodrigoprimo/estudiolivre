{if $arquivo.donoCopyright || (!$arquivo.donoCopyright && $permission)}
	<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Detentor(a) dos DA{/tr}:</div> {ajax_input permission=$permission value=$arquivo.donoCopyright id="donoCopyright" default="" display="inline"}</div>
{/if}
{if $arquivo.produtora || (!$arquivo.produtora && $permission)}
	<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Produtora{/tr}:</div> {ajax_input permission=$permission value=$arquivo.produtora id="produtora" default="" display="inline"}</div>
{/if}
{if $arquivo.contato || (!$arquivo.contato && $permission)}
	<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Contato{/tr}:</div> {ajax_input permission=$permission value=$arquivo.contato id="contato" default="" display="inline"}</div>
{/if}
