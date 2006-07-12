{foreach from=$tag_suggestion item=t name=tag_suggest}
	<span class="pointer" onclick="addTag(this)">{$t}</span>{if not $smarty.foreach.tag_suggest.last}<span id="{$t}-v">,</span>{/if}
{/foreach}