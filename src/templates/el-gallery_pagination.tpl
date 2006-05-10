<!-- el-gallery_pagination.tpl begin -->

{if $total > $maxRecords}
	{if $page-2 > 1}
		<a href="#" onClick="xajax_get_files(tipos, 0, {$maxRecords}, '{$sort_mode}', '{$find}')">&laquo;</a>
	{/if}
	{if $page > 1}
		<a href="#" onClick="xajax_get_files(tipos, {$offset-$maxRecords}, {$maxRecords}, '{$sort_mode}', '{$find}')">&lt;</a>
	{/if}
	{if $page-2 > 0}
		<a href="#" onClick="xajax_get_files(tipos, {$offset-2*$maxRecords}, {$maxRecords}, '{$sort_mode}', '{$find}')">{$page-2}</a>
	{/if}
	{if $page-1 > 0}
		<a href="#" onClick="xajax_get_files(tipos, {$offset-$maxRecords}, {$maxRecords}, '{$sort_mode}', '{$find}')">{$page-1}</a>
	{/if}
	<span class="selected">{$page}</span>
	{if $page+1 <= $lastPage}
		<a href="#" onClick="xajax_get_files(tipos, {$offset+$maxRecords}, {$maxRecords}, '{$sort_mode}', '{$find}')">{$page+1}</a>
	{/if}				
	{if $page+2 <= $lastPage}
		<a href="#" onClick="xajax_get_files(tipos, {$offset+2*$maxRecords}, {$maxRecords}, '{$sort_mode}', '{$find}')">{$page+2}</a>
	{/if}				
	{if $page < $lastPage}
		<a href="#" onClick="xajax_get_files(tipos, {$offset+$maxRecords}, {$maxRecords}, '{$sort_mode}', '{$find}')">&gt;</a>
	{/if}
	{if $page+2 < $lastPage}
		<a href="#" onClick="xajax_get_files(tipos, {$maxRecords*$lastPage-$maxRecords}, {$maxRecords}, '{$sort_mode}', '{$find}')">&raquo;</a>
	{/if}
{/if}

<!-- el-gallery_pagination.tpl end -->
