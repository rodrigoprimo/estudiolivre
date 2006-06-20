<!-- begin freetag.tpl --!>
{if $feature_freetags eq 'y'}
	<script language="JavaScript">
		{literal}
		  function addTag(tag) {
		    el = document.getElementById('tagBox');
		    el.value += ' ' + tag;
		  }
		{/literal}
	</script>
	<div id="freetager">
	{tr}Tags{/tr}
		{if $feature_help eq 'y'}
			<!--div class="simplebox">{tr}Put tags separated by spaces. For tags with more than one word, use no spaces and put words together.{/tr}</div--!>
		{/if}
	    <input type="text" id="tagBox" name="freetag_string" value="{$taglist|escape}" size="60" /><br />
		{foreach from=$tag_suggestion item=t}
			<a href="javascript:addTag('{$t}')">{$t}</a> 
		{/foreach}
	</div>
{/if}
<!--end freetag.tpl--!>
{* $feature_freetags eq 'y' *}
