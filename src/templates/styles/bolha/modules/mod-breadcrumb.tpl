{* $Header: /cvsroot/arca/estudiolivre/src/templates/styles/bolha/modules/mod-breadcrumb.tpl,v 1.1 2006-10-20 21:11:31 rhwinter Exp $ *}
{if $elCrumbs}
	{tikimodule title="{tr}Bread Crumbs{/tr}" name="breadcrumb" flip=$module_params.flip}
	<div class="elcrumbs">
        {section name=ix loop=$breadCrumb}
        	 <a href="{$breadCrumb[ix]|sefurl}">
                    {if ($maxlen > 0 && strlen($breadCrumb[ix]) > $maxlen)}
                    	{$breadCrumb[ix]|truncate:$maxlen:"...":true|escape}
                    {else}
			{$breadCrumb[ix]|escape}
                    {/if}
                </a>
        {/section}
        </div>
	{/tikimodule}
{/if}
