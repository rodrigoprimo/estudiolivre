<!-- el-gallery_pagination.tpl begin -->

{if $total > $maxRecords}
	{if $page-2 > 1}
		{tooltip text="Primeira página"}<a href="#" onClick="xajax_get_files(tipos, 0, {$maxRecords}, '{$sort_mode}')">&laquo;</a>{/tooltip}
	{/if}
	{if $page > 1}
		{tooltip text="Página anterior"}<a href="#" onClick="xajax_get_files(tipos, {$offset-$maxRecords}, {$maxRecords}, '{$sort_mode}')">&lt;</a>{/tooltip}
	{/if}
	{if $page-2 > 0}
		<a href="#" onClick="xajax_get_files(tipos, {$offset-2*$maxRecords}, {$maxRecords}, '{$sort_mode}')">{$page-2}</a>
	{/if}
	{if $page-1 > 0}
		<a href="#" onClick="xajax_get_files(tipos, {$offset-$maxRecords}, {$maxRecords}, '{$sort_mode}')">{$page-1}</a>
	{/if}
	<span class="selected">{$page}</span>
	{if $page+1 <= $lastPage}
		<a href="#" onClick="xajax_get_files(tipos, {$offset+$maxRecords}, {$maxRecords}, '{$sort_mode}')">{$page+1}</a>
	{/if}				
	{if $page+2 <= $lastPage}
		<a href="#" onClick="xajax_get_files(tipos, {$offset+2*$maxRecords}, {$maxRecords}, '{$sort_mode}')">{$page+2}</a>
	{/if}				
	{if $page < $lastPage}
		{tooltip text="Próxima página"}<a href="#" onClick="xajax_get_files(tipos, {$offset+$maxRecords}, {$maxRecords}, '{$sort_mode}')">&gt;</a>{/tooltip}
	{/if}
	{if $page+2 < $lastPage}
		{tooltip text="Última página"}<a href="#" onClick="xajax_get_files(tipos, {$maxRecords*$lastPage-$maxRecords}, {$maxRecords}, '{$sort_mode}')">&raquo;</a>{/tooltip}
	{/if}
{/if}

<!-- el-gallery_pagination.tpl end -->
