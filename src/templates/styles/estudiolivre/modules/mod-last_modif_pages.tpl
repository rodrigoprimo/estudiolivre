{tikimodule title="{tr}Últimas Alterações{/tr}" name='last_modif_pages' flip=$module_params.flip}
	      	{foreach from=$modLastModif item='page'}
				<a href="tiki-index.php?page={$page.pageName}" onMouseover="tooltip('{if $page.comment}{$page.comment|escape:'quotes'}{else}<i>{tr}Modificação não comentada{/tr}</i>{/if}<br>{tr}editado por{/tr}: <b>{$page.user}</b>')" onMouseout="nd()">{$page.pageName}</a><br/>
	     	{/foreach}
	     	<div class="modViewAll"><a href="tiki-lastchanges.php?days=0">{tr}ver mais{/tr}</a></div>
{/tikimodule}