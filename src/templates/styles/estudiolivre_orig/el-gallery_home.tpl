<!-- el-gallery_home.tpl begin -->

<script language="JavaScript" src="lib/js/el_array.js"></script>
<script language="JavaScript" src="lib/elgal/el_home.js"></script>


<center>
<div style="width:50%;border: 2px dashed red;margin:30px 0 30px 0;padding:0px">
<h2>AVISO!</h2>
Esse estilo (estudiolivre_orig.css) ainda não suporta a visualização do acervo corretamente.
Se quiser modificar o estilo modifique as suas <a href="tiki-user_preferences.php">preferências</a>.
</div>
</center>

<!-- Feature Wiki Begin -->
<div id="gHomeWiki" {if $tiki_p_edit eq 'y'} ondblclick="location.href='tiki-editpage.php?page=destak'"{/if}>
	<span id="gHomeWikiTitle">
		{tooltip name="home-flip-destaques" text="Alternar a visualização dos destaques"}
			<a onclick="javascript:flip('gHomeWikiToggle');return false;" href="#">
				<img onclick="this.toggleImage('iGreenArrowLeft.png');" src="styles/estudiolivre/sortArrowDown.png">
			</a>
		{/tooltip}
	</span>
	<div id="gHomeWikiToggle" style="display:block;">
		{$destak}
	</div>
	
	<div id="gHomeWikiBottom">
		{tooltip text="<i>Feed</i> &nbsp;<b>RSS</b> do acervo.livre"}
			<a href="http://teste.estudiolivre.org/el-gallery_rss.php?ver=2">
				<up style="position:relative; top:-4px;">Assinar RSS do acervo</up> <img src="styles/estudiolivre/iRss.png">
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
	
<!-- el-gallery_home.tpl end -->
