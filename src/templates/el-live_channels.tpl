<span id="ajax-live{$channel.mountPoint}">
	{if $permission}
		<img src="styles/{$style|replace:".css":""}/img/iWikiEdit.png" class="pointer" onClick="document.getElementById('ajax-livePoint').value='{$channel.mountPoint}';document.getElementById('ajax-livePass').value='{$channel.password}';showLightbox('elIce')">
		| 
		<img src="styles/{$style|replace:".css":""}/img/iWikiRemove.png" class="pointer" onClick="xajax_delete_mount_point('{$channel.mountPoint}')">
	{/if}
	{$channel.mountPoint}
	<br/>
</span>