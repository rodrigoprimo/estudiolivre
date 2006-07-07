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
		<!--form  enctype="multipart/form-data" method="post" action="tiki-editpage.php" id="previewpageform">
			<input type="hidden" name="page" value="{$page|escape}" / -->
			<span id="attention" class="wikiPreview">
				{tr}Note: Remember that this is only a preview, and has not yet been saved!{/tr}
				<div id="attentionSave">
					{tooltip text="<b>Comente</b> suscintamente as modificações feitas na edição"}
						<input class="wikitext" type="text" name="comment" value="{$commentdata|escape}" />
					{/tooltip}
					{if $page|lower neq 'sandbox'}
						{if $tiki_p_minor eq 'y'}
							{tooltip text="Selecione se essa modificação foi <b>pequena</b> (ela não vai aparecer na página das ultimas alterações do site)"}
								<input type="checkbox" name="isminor" value="on"/>
							{/tooltip}
						{/if}
						<br>
						<input class="image" name="save" src="styles/estudiolivre/bSave.png" type="image" value="{tr}save{/tr}" /> &nbsp;&nbsp;
						<input class="image" name="cancel_edit" src="styles/estudiolivre/bCancelar.png" type="image" value="{tr}cancel edit{/tr}" />
					{/if}
				</div>
			</span>
		<br />
	</div>
		<!--/form-->
	{if $has_footnote}
		<div  class="wikitext">{$parsed_footnote}</div>
	{/if}
	<div id="labelLine" style="border-bottom: 2px solid grey; display:none;width: 100%; height: 2px;"></div>
</div>
<!-- templates/tiki-preview.tpl end -->
