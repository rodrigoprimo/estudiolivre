<span id="ajax-live{$channel.mountPoint}">
	{$channel.mountPoint}
	{if $permission}
		<a href="#" onClick="document.getElementById('ajax-livePoint').value='{$channel.mountPoint}';document.getElementById('ajax-livePass').value='{$channel.password}';showLightbox('elIce')">editar</a>
		<a href="#" onClick="xajax_delete_mount_point('{$channel.mountPoint}')">apagar</a>
	{/if}<br/>
</span>