<!-- el-gallery_home.tpl begin -->

<script language="JavaScript" src="lib/js/el_array.js"></script>
<script language="JavaScript" src="lib/elgal/el_home.js"></script>

<!-- Feature Wiki Begin -->
<div id="gHomeWiki" {if $tiki_p_edit eq 'y'} ondblclick="location.href='tiki-editpage.php?page=destak'"{/if}>
	<span id="gHomeWikiTitle">Destaques
		{tooltip name="home-flip-destaques" text="Alternar a visualização dos destaques"}<a onclick="javascript:flip('gHomeWikiToggle');return false;" href="#">
			<img onclick="this.toggleImage('iGreenArrowLeft.png');" src="styles/estudiolivre/sortArrowDown.png">
		</a>{/tooltip}
	</span>
	<div id="gHomeWikiToggle" style="display:block">
		{$destak}
	</div>
</div>
<!-- Feature Wiki End -->
	
	{include file="el-gallery_list_filters.tpl"}

<div id="gListCont">
	{include file="el-gallery_section.tpl"}
</div>
<script language="JavaScript">init('{$find}')</script>

	{* isso não rola por causa do AJAX. mas o nano vai arrumar.*}
	{* include file="el-gallery_list_filters.tpl" *}
	
<!-- el-gallery_home.tpl end -->
