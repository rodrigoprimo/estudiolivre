<!-- el-gallery_section.tpl begin -->
{foreach from=$arquivos item=p}
	{if $isIE}
		{include file="ie_el-gallery_list_item.tpl" arquivo=$p}
	{else}
		{include file="el-gallery_list_item.tpl" arquivo=$p}
	{/if}
{/foreach}
<!-- el-gallery_section.tpl end -->
