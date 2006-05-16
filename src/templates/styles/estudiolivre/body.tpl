<!-- body.tpl begin -->

<body {if $user_dbl eq 'y' and $dblclickedit eq 'y' and $tiki_p_edit eq 'y'}ondblclick="location.href='tiki-editpage.php?page={$page|escape:"url"}';"{/if} {if $show_comzone eq 'y'}onload="javascript:flip('comzone');"{/if}{if $section} class="tiki_{$section}"{/if}>

  {if $minical_reminders>100}
    <iframe width='0' height='0' frameborder="0" src="tiki-minical_reminders.php"></iframe>
  {/if}

  {if $feature_community_mouseover}
    {popup_init src="lib/overlib.js"}
  {/if}
  
	{* Tiki main contains all page *}
	<!-- SELO: isso é só pro teste.estudiolivre-->
	<div style="width:760px;margin:0px auto;">
	<img src="styles/estudiolivre/faixaTeste.png" style="position:relative; left:0px;z-index:200"/>
	<div style="position:absolute;top:5px">
	<!-- fim do selo -->
		<div id="tiki-main">
	    	{if $feature_top_bar eq 'y'}
		        {include file="tiki-top_bar.tpl"}
		    {/if}
		    {include file="content.tpl"}
		    {include file="footer.tpl"}
		</div>
	</div>
	</div>
</body>

<!-- body.tpl end -->
