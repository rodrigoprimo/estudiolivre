{* $Header: /home/rodrigo/devel/arca/estudiolivre/src/templates/styles/bubble/modules/Attic/mod-breadcrumb.tpl,v 1.1 2006-10-12 00:29:28 rhwinter Exp $ *}
{if $elCrumbs}
	{tikimodule title="{tr}Bread Crumbs{/tr}" name="breadcrumb" flip=$module_params.flip}
		{elcrumbs crumbs=$elCrumbs}
	{/tikimodule}
{/if}
