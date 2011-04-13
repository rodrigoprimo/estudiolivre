<!-- body.tpl begin -->

<body{* load tooltip images first *}
	onLoad="preloadImgsNow('{$prefs.style|replace:".css":""}')"
	{html_body_attributes}>
	
	{if $prefs.feature_ajax eq 'y'}
		{$xajax_js}
		{include file='tiki-ajax_header.tpl'}
	{/if}

	{include file="el-lightbox.tpl"}

	<div id="fixedwidth">
		<div id="main">
			{* Tiki main contains all page *}
			{if $isIE}
				<center>
					<div style="text-align:left; width:954px">
			{/if}
			
			<div id="tiki-main">
				{if $prefs.feature_top_bar eq 'y'}
					{include file="tiki-top_bar.tpl"}
				{/if}
				{if $display_msg}
					{remarksbox type="note" title="{tr}Notice{/tr}"}{$display_msg|escape}{/remarksbox}
				{/if}
				<div id="role_main">
					{include file="content.tpl"}
				</div>
			</div>
		
			{if $isIE}
					</div>
				</center>
			{/if}
		
			{if $prefs.feature_bot_bar eq 'y'}
				<div id="footer">
					<div class="footerbgtrap">
						<div class="content"{if $prefs.feature_bidi eq 'y'} dir="rtl"{/if}>
							{*{include file='tiki-bot_bar.tpl'}*}
						</div>
					</div>
				</div>{* -- END of footer -- *}
			{/if}
		</div>
	</div>
	
	{include file='footer.tpl'}
			
	{if $prefs.feature_endbody_code}{*this code must be added just before </body>: needed by google analytics *}
		{eval var=$prefs.feature_endbody_code}
	{/if}
	{interactivetranslation}
</body>

<!-- body.tpl end -->
