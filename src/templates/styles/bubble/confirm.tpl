{* $Header: /home/rodrigo/devel/arca/estudiolivre/src/templates/styles/bubble/Attic/confirm.tpl,v 1.2 2006-10-12 00:29:24 rhwinter Exp $ *}
<br/>
<br/>
<div class="cbox">
	<div class="cbox-data">
		<form action="{$confirmaction}" method="post">
			{if $ticket}
				<input value="{$ticket}" name="ticket" type="hidden" />
			{/if}
			<input type="submit" name="daconfirm" value="{$confirmation_text}" />
			
			<br/>
			<br/>
			<br/>
			<span class="button2">
				<a href="javascript:history.back()" class="linkbut">
					{tr}Go back{/tr}
				</a>
			</span>
			<br/>
			<br/>
			<span class="button2">
				<a href="{$tikiIndex}" class="linkbut">
					{tr}Return to home page{/tr}
				</a>
			</span>
		</form>
	</div>
</div>
