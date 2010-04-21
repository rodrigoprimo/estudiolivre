{if $prefs.change_theme ne 'n' or $user eq ''}
	{*assign var=stn value=$prefs.styleName|replace:".css":""*}
	{tikimodule title="{tr}Change{/tr} {tr}Style{/tr}" name="switch_theme" flip=$module_params.flip decorations=$module_params.decorations}
		{section name=ix loop=$prefs.styleslist}
			{if count($prefs.available_styles) == 0 || in_array($prefs.styleslist[ix], $prefs.available_styles)}
				{if $prefs.style neq $prefs.styleslist[ix]}
			        <a onmouseout="nd();" onmouseover="tooltip('<img src=\'styles/{$prefs.style|replace:".css":""}/img/{$prefs.styleslist[ix]|replace:".css":""}Icon.png\'/>')" href="tiki-switch_theme.php?theme={$prefs.styleslist[ix]|escape}">{$prefs.styleslist[ix]|replace:".css":""}</a>
		        {else}
		        	{$prefs.styleslist[ix]|replace:".css":""} ({tr}current{/tr})
			    {/if}
			    <br/>
			{/if}
		{/section}
	{/tikimodule}
{/if}
