<div class="userMenu">
	{if $module_flip eq 'y'}
		flipenabled...
	{/if}
	{*
	<a title="{tr}Unassign this module{/tr}" href="{$current_location|escape}{$mpchar|escape}mc_unassign={$module_name|escape}" onclick="return confirmTheLink(this,'{tr}Are you sure you want to unassign this module?{/tr}')"><img border="0" alt="[{tr}remove{/tr}]" src="img/icons2/delete.gif" /></a>
	*}
	<div class="topMenuContainer">
		{$module_name}
	</div>
	
	<div class="userMenuContent">
		{$module_content}
	</div>
</div>