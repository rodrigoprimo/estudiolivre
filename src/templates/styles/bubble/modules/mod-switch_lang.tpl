{css}
{* $Header: /home/rodrigo/devel/arca/estudiolivre/src/templates/styles/bubble/modules/Attic/mod-switch_lang.tpl,v 1.1 2006-10-11 02:05:14 rhwinter Exp $ *}
{*: {/tr}`$language`*}

{tikimodule title="{tr}Language{/tr}" name="switch_lang" flip=$module_params.flip decorations=$module_params.decorations}
{if $change_language ne 'n' or $user eq ''}
<div class="modCenterContent">
    {section name=ix loop=$languages}
    	{if count($available_languages) == 0 || in_array($languages[ix].value, $available_languages)}
		    {if $language neq $languages[ix].value}
				<a href="tiki-switch_lang.php?language={$languages[ix].value|escape}">{$languages[ix].name}</a><br/>
			{/if}
		{/if}
	{/section}
</div>	
{else}
{tr}Permission denied{/tr}
{/if}
{/tikimodule}
