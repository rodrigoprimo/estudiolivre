<!-- el-gallery_pagination.tpl begin -->
{if $total > $maxRecords}
	{if $currentPage-2 > 1}
		{tooltip name="pagination-primeira-pagina" text="Primeira página"}<a class="pointer" onClick="xajax_get_files(tipos, 0, {$maxRecords}, '{$sort_mode}', '{$userName}', '{$find}')">&laquo;</a>{/tooltip}
	{/if}
	{if $currentPage > 1}
		{tooltip text="Página anterior"}<a class="pointer" onClick="xajax_get_files(tipos, {$offset-$maxRecords}, {$maxRecords}, '{$sort_mode}', '{$userName}', '{$find}')">&lt;</a>{/tooltip}
	{/if}
	{if $currentPage-2 > 0}
		<a class="pointer" onClick="xajax_get_files(tipos, {$offset-2*$maxRecords}, {$maxRecords}, '{$sort_mode}', '{$userName}', '{$find}')">{$currentPage-2}</a>
	{/if}
	{if $currentPage-1 > 0}
		<a class="pointer" onClick="xajax_get_files(tipos, {$offset-$maxRecords}, {$maxRecords}, '{$sort_mode}', '{$userName}', '{$find}')">{$currentPage-1}</a>
	{/if}
	<span class="selected">{$currentPage}</span>
	{if $currentPage+1 <= $lastPage}
		<a class="pointer" onClick="xajax_get_files(tipos, {$offset+$maxRecords}, {$maxRecords}, '{$sort_mode}', '{$userName}', '{$find}')">{$currentPage+1}</a>
	{/if}				
	{if $currentPage+2 <= $lastPage}
		<a class="pointer" onClick="xajax_get_files(tipos, {$offset+2*$maxRecords}, {$maxRecords}, '{$sort_mode}', '{$userName}', '{$find}')">{$currentPage+2}</a>
	{/if}				
	{if $currentPage < $lastPage}
		{tooltip text="Próxima página"}<a class="pointer" onClick="xajax_get_files(tipos, {$offset+$maxRecords}, {$maxRecords}, '{$sort_mode}', '{$userName}', '{$find}')">&gt;</a>{/tooltip}
	{/if}
	{if $currentPage+2 < $lastPage}
		{tooltip text="Última página"}<a class="pointer" onClick="xajax_get_files(tipos, {$maxRecords*$lastPage-$maxRecords}, {$maxRecords}, '{$sort_mode}', '{$userName}', '{$find}')">&raquo;</a>{/tooltip}
	{/if}
{/if}
<!-- el-gallery_pagination.tpl end -->
