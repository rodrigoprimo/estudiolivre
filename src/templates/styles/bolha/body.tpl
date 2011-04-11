<!-- body.tpl begin -->

<body{* load tooltip images first *}
	onLoad="preloadImgsNow('{$prefs.style|replace:".css":""}')">
	
	{if $prefs.feature_ajax eq 'y'}
		{include file='tiki-ajax_header.tpl'}
	{/if}

	{include file="el-lightbox.tpl"}

	{if $prefs.feature_community_mouseover}
		{popup_init src="lib/js/overlib_mini.js"}
	{/if}
	
	{* Tiki main contains all page *}
	{if $isIE}
		<center>
			<div style="text-align:left; width:954px">
	{/if}
	
	<div id="tiki-main">
		{if $prefs.feature_top_bar eq 'y'}
			{include file="tiki-top_bar.tpl"}
		{/if}
		{include file="content.tpl"}
	</div>

	{if $isIE}
		</div>
			<center>
	{/if}

	<!-- Put JS at the end -->
	{if $headerlib}
		{$headerlib->output_js_config()}
		{$headerlib->output_js_files()}
		{$headerlib->output_js()}
	{/if}

</body>

<!-- body.tpl end -->
