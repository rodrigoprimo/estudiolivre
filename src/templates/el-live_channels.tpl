<span id="ajax-live{$channel.mountPoint}">
	{if $permission}
		{tooltip text="Editar as propriedades desse canal"}<img src="styles/{$style|replace:".css":""}/img/iWikiEdit.png" class="pointer" onClick="document.getElementById('ajax-livePoint').value='{$channel.mountPoint}';document.getElementById('ajax-livePass').value='{$channel.password}';showLightbox('elIce')">{/tooltip}
		| 
		{tooltip text="Remover canal"}<img src="styles/{$style|replace:".css":""}/img/iWikiRemove.png" class="pointer" onClick="xajax_delete_mount_point('{$channel.mountPoint}')">{/tooltip}
	{/if}
	{$channel.mountPoint}
	<br/>
</span>