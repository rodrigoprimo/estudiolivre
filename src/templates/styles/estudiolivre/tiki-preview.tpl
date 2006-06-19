<!-- templates/tiki-preview.tpl start -->
<div id="wikiPreviewCont">
	<span id="label" class="wikiPreview">
		<img class="pointer" onclick="javascript:flip('previewCont');javascript:flip('labelLine');this.toggleImage('iArrowGreyRight.png');" src="styles/estudiolivre/iArrowGreyDown.png">
		{tr}Preview{/tr} da página <b>{$page}</b>
	</span>

	<div id="previewCont" style="display:block">
		<div  id="wikitext" class="wikiPreview">
			{$parsed}
		</div>
		<form  enctype="multipart/form-data" method="post" action="tiki-editpage.php" id="previewpageform">
			<span id="attention" class="wikiPreview">
				{tr}Note: Remember that this is only a preview, and has not yet been saved!{/tr}
				<div id="attentionSave">
					{if $page|lower neq 'sandbox'}
						<input type="submit" class="wikiaction" name="save" value="{tr}save{/tr}" />
						{if $tiki_p_minor eq 'y'}
							<input type="checkbox" name="isminor" value="on" />{tr}Minor{/tr}
						{/if}
						<br />
						<input type="submit" class="wikiaction" name="cancel_edit" value="{tr}cancel edit{/tr}" />
					{/if}
				</div>
			</span>
		<br />
	</div>
		</form>
	{if $has_footnote}
		<div  class="wikitext">{$parsed_footnote}</div>
	{/if}
<div id="labelLine" style="border-bottom: 1px solid grey; display:none;width: 100%; height: 1px;"></div>
</div>
<!-- templates/tiki-preview.tpl end -->
