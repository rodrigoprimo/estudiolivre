<!-- el-gallery_home.tpl begin -->

<script language="JavaScript" src="lib/js/el_array.js"></script>
<script language="JavaScript" src="lib/elgal/el_home.js"></script>
<script language="JavaScript" src="lib/js/delete_file.js"></script>

{if $smarty.cookies.gHomeWikiToggle eq 'none'}
	{assign var=display value="none"}
	{assign var=imgCurrent value="iGreenArrowLeft"}
	{assign var=imgChange value="sortArrowDown"}	
{else}
	{assign var=display value="block"}
	{assign var=imgCurrent value="sortArrowDown"}
	{assign var=imgChange value="iGreenArrowLeft"}	
{/if}

<!-- Feature Wiki Begin -->
<div id="gHomeWiki" {if $tiki_p_edit eq 'y'} ondblclick="location.href='tiki-editpage.php?page=destak'"{/if}>
	<span id="gHomeWikiTitle">
		{tooltip name="home-flip-destaques" text="Alternar a visualização dos destaques"}
			<img onclick="flip('modulegHomeWikiToggle');toggleImage(this,'{$imgChange}.png');storeState('gHomeWikiToggle')" src="styles/estudiolivre/{$imgCurrent}.png">
		{/tooltip}
	</span>
	<div id="modulegHomeWikiToggle" style="display:{$display};">
		{$destak}
	</div>
	
	<div id="gHomeWikiBottom">
		{tooltip text="<i>Feed</i> &nbsp;<b>RSS</b> do acervo.livre"}
			<a href="http://estudiolivre.org/el-gallery_rss.php?ver=2">
				<up style="position:relative; top:-4px;">{tr}Assinar RSS do acervo{/tr}</up> <img src="styles/estudiolivre/iRss.png">
			</a>
		{/tooltip}
	</div>
</div>
<!-- Feature Wiki End -->
	
	{if $isIE}
		{include file="ie_el-gallery_list_filters.tpl"}
	{else}
		{include file="el-gallery_list_filters.tpl"}
	{/if}

<div id="gListCont">
	{include file="el-gallery_section.tpl"}
</div>
<script language="JavaScript">init('{$find}')</script>

	{* isso não rola por causa do AJAX. mas o nano vai arrumar.*}
	{* include file="el-gallery_list_filters.tpl" *}
	
{include file="el-gallery_confirm_delete.tpl"}

<!-- el-gallery_home.tpl end -->
