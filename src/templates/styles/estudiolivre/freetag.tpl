<!-- begin freetag.tpl -->
{if $feature_freetags eq 'y'}
	<script language="JavaScript">
		{literal}
		  function addTag(tag) {
		      var currentTags = document.getElementById('tagBox');
    
		      if (currentTags.value != '') {
			  	currentTags.value += ', ';
		      }
		      
		      currentTags.value += tag.innerHTML;
		      tag.style.display = 'none';
		  }
		{/literal}
	</script>
	<div id="freetager">
	{tr}Tags{/tr}
		{if $feature_help eq 'y'}
			{*
			<div class="simplebox">{tr}Put tags separated by spaces. For tags with more than one word, use no spaces and put words together.{/tr}</div>
			*}
		{/if}
	    <input type="text" id="tagBox" name="freetag_string" value="{$taglist|escape}" size="60" /><br />
		{foreach from=$tag_suggestion item=t}
			<span onclick="addTag(this)" class="pointer">{$t}</span> 
		{/foreach}
	</div>
{/if}
<!--end freetag.tpl-->
{* $feature_freetags eq 'y' *}
