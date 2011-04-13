{if empty($offset)}
	{assign var=offset value=0}
{/if}

{math equation="ceil(x / y)" x=$cant y=$maxRecords assign=cant_pages}
{math equation="1 + (x / y)" x=$offset y=$maxRecords assign=actual_page}

{assign var=prev_offset value=`$offset-10`}

{if ($cant > ($offset + $maxRecords))}
	{assign var=next_offset value=`$offset+$maxRecords`}
{else}
	{assign var=next_offset value=-1}
{/if}

<div id="freeTagsPagination">
  	{if $prev_offset >= 0}
    	[<a class="prevnext" href="tiki-browse_freetags.php?find={$find}&amp;tag={$tag}&amp;type={$type}&amp;offset={$prev_offset}">{tr}prev{/tr}</a>]&nbsp;
    {/if}
    
    {tr}Page{/tr}: {$actual_page}/{$cant_pages}
    
    {if $next_offset >= 0}
    	&nbsp;[<a class="prevnext" href="tiki-browse_freetags.php?find={$find}&amp;tag={$tag}&amp;type={$type}&amp;offset={$next_offset}">{tr}next{/tr}</a>]
    {/if}
    
    {if $prefs.direct_pagination eq 'y'}
    	<br />
    	{section loop=$cant_pages name=foo}
    		{assign var=selector_offset value=$smarty.section.foo.index|times:$prefs.maxRecords}
    		<a class="prevnext" href="tiki-browse_freetags.php?find={$find}&amp;tag={$tag}&amp;type={$type}&amp;offset={$selector_offset}">
				{$smarty.section.foo.index_next}
			</a>&nbsp;
		{/section}
	{/if}
</div>