<div class="searchResultItem">
	{if $feature_search_fulltext eq 'y'}{if $result.relevance <= 0}{assign var=tiptext value="Busca Simples"}{else}{assign var=tiptext value="Relevância: "|cat:$result.relevance}{/if}{/if}
	{tooltip text=$tiptext|cat:" - Hits: "|cat:$result.hits}
	<a href="{$result.href}&amp;highlight={$words}" class="searchResultItemLink">
		{$result.pageName|strip_tags}
	</a>
	{/tooltip}
	{if $result.type > ''}
		<span class="searchType">
			({$result.type})
		</span>
	{/if}				
	<br />
	<div class="searchdesc">
		{$result.data|strip_tags}
	</div>
	{*<div class="searchdate">
		{tr}Last modification date{/tr}: {$result.lastModif|tiki_long_datetime}
	</div>*}
	<br />
</div>