{foreach from=$tag_suggestion item=t}
	<span class="pointer" onclick="addTag(this)">{$t}</span>
{/foreach}