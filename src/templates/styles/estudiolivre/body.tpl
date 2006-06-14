<!-- body.tpl begin -->
<body style="border:1px solid blue" {if $user_dbl eq 'y' and $dblclickedit eq 'y' and $tiki_p_edit eq 'y'}ondblclick="location.href='tiki-editpage.php?page={$page|escape:"url"}';"{/if} {if $show_comzone eq 'y'}onload="javascript:flip('comzone');"{/if}{if $section} class="tiki_{$section}"{/if}>

  {include file="el-lightbox.tpl"}

  {if $minical_reminders>100}
    <iframe width='0' height='0' frameborder="0" src="tiki-minical_reminders.php"></iframe>
  {/if}

  {if $feature_community_mouseover}
    {popup_init src="lib/overlib.js"}
  {/if}
  
	{* Tiki main contains all page *}
	
		<!--[if lte IE 6]>
			<center>
			<div style="text-align:left; width:760px; border:1px solid red">
		<![endif]-->
	
		<div id="tiki-main">
	    	{if $feature_top_bar eq 'y'}
		        {include file="tiki-top_bar.tpl"}
		    {/if}
		    {include file="content.tpl"}
		    {include file="footer.tpl"}
		</div>
		
		<!--[if lte IE 6]>
			</div>
			<center>
		<![endif]-->
</body>

<!-- body.tpl end -->
