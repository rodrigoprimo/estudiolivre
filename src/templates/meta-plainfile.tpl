{if $file->typeOfFile || (!$file->typeOfFile && $permission) }
	<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Tipo de arquivo{/tr}:</div> {ajax_input permission=$permission value=$file->typeOfFile id="typeOfFile" display="inline"}</div>
{/if}
