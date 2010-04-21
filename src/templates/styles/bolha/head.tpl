<!-- head.tpl begin -->
{* --- IMPORTANT: If you edit this (or any other TPL file) file via the Tiki built-in TPL editor (tiki-edit_templates.php), all the javascript will be stripped. This will cause problems. (Ex.: menus stop collapsing/expanding).
You should only modify header.tpl via a text editor through console, or ssh, or FTP edit commands. And only if you know what you are doing ;-)
You are most likely wanting to modify the top of your Tiki site. Please consider using Site Identity feature or modifying tiki-top_bar.tpl which you can do safely via the web-based interface.       --- *}

<head>
  
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	{if $prefs.metatag_keywords ne ''}
		<meta name="keywords" content="{$prefs.metatag_keywords}" />
	{/if}
	{if $prefs.metatag_author ne ''}
		<meta name="author" content="{$prefs.metatag_author}" />
	{/if}
	{if $prefs.metatag_description ne ''}
		<meta name="description" content="{$prefs.metatag_description}" />
	{/if}
	{if $prefs.metatag_geoposition ne ''}
		<meta name="geo.position" content="{$prefs.metatag_geoposition}" />
	{/if}
	{if $prefs.metatag_georegion ne ''}
		<meta name="geo.region" content="{$prefs.metatag_georegion}" />
	{/if}
	{if $prefs.metatag_geoplacename ne ''}
		<meta name="geo.placename" content="{$prefs.metatag_geoplacename}" />
	{/if}
	{if $prefs.metatag_robots ne ''}
		<meta name="robots" content="{$prefs.metatag_robots}" />
	{/if}
	{if $prefs.metatag_revisitafter ne ''}
		<meta name="revisit-after" content="{$prefs.metatag_revisitafter}" />
	{/if}

	<title>
		{if $trail}
			{breadcrumbs type="fulltrail" loc="head" crumbs=$trail}
		{else}
			{$prefs.siteTitle}
			{if $headtitle} : {$headtitle}
			{elseif $page ne ''} : {$page|escape} {* add $description|escape if you want to put the description *}
			{elseif $arttitle ne ''} : {$arttitle}
			{elseif $title ne ''} : {$title}
			{elseif $thread_info.title ne ''} : {$thread_info.title}
			{elseif $post_info.title ne ''} : {$post_info.title}
			{elseif $forum_info.name ne ''} : {$forum_info.name}
			{elseif $categ_info.name ne ''} : {$categ_info.name}
			{elseif $userinfo.login ne ''} : {$userinfo.login}
			{/if}
		{/if}
	</title>
    
	<link rel="StyleSheet"  href="styles/{$prefs.style}" type="text/css" />
	<link rel="StyleSheet"  href="styles/{$prefs.style|replace:".css":""}/css/tooltip.css" type="text/css" />
  
	{* ---- JavaScripts ----*}
		<script language="JavaScript" type="text/javascript" src="lib/ajax/tiki-ajax.js"></script>
		{$xajax_js}
		<script type="text/javascript" src="lib/js/general.js"></script>		
		<script type="text/javascript" src="lib/js/toggleImage.js"></script>
		<script language="JavaScript" type="text/javascript" src="lib/js/tooltip.js"></script>
		<script language="JavaScript" src="lib/elgal/player/cortado.js"></script>
		<script language="JavaScript">var style = '{$prefs.style|replace:".css":""}'</script>
	{* ---- END ---- *}
	
	{if $favicon}
		{if $showTeste}
			<link rel="icon" href="favicon_teste.png" />
		{else}
			<link rel="icon" href="{$favicon}" />
		{/if}
	{/if}  
  
	{* --- Firefox RSS icons --- *}
	  <link rel="alternate" type="application/xml" title="{tr}RSS Acervo Livre{/tr}" href="el-gallery_rss.php?ver={$prefs.rssfeed_default_version}" />
	  {if $prefs.feature_wiki eq 'y' and $prefs.rss_wiki eq 'y'}
		  <link rel="alternate" type="application/xml" title="{tr}RSS Wiki{/tr}" href="tiki-wiki_rss.php?ver={$prefs.rssfeed_default_version}" />
	  {/if}
	  {if $prefs.feature_blogs eq 'y' and $prefs.rss_blogs eq 'y'}
		  <link rel="alternate" type="application/xml" title="{tr}RSS Blogs{/tr}" href="tiki-blogs_rss.php?ver={$prefs.rssfeed_default_version}" />
	  {/if}
	  {if $prefs.feature_articles eq 'y' and $prefs.rss_articles eq 'y'}
		  <link rel="alternate" type="application/xml" title="{tr}RSS Articles{/tr}" href="tiki-articles_rss.php?ver={$prefs.rssfeed_default_version}" />
	  {/if}
	  {if $prefs.feature_galleries eq 'y' and $prefs.rss_image_galleries eq 'y'}
		  <link rel="alternate" type="application/xml" title="{tr}RSS Image Galleries{/tr}" href="tiki-image_galleries_rss.php?ver={$prefs.rssfeed_default_version}" />
	  {/if}
	  {if $prefs.feature_file_galleries eq 'y' and $prefs.rss_file_galleries eq 'y'}
		  <link rel="alternate" type="application/xml" title="{tr}RSS File Galleries{/tr}" href="tiki-file_galleries_rss.php?{$prefs.rssfeed_default_version}" />
	  {/if}
	  {if $prefs.feature_forums eq 'y' and $prefs.rss_forums eq 'y'}
		  <link rel="alternate" type="application/xml" title="{tr}RSS Forums{/tr}" href="tiki-forums_rss.php?ver={$prefs.rssfeed_default_version}" />
	  {/if}
	  {if $prefs.feature_maps eq 'y' and $prefs.rss_mapfiles eq 'y'}
		  <link rel="alternate" type="application/xml" title="{tr}RSS Maps{/tr}" href="tiki-map_rss.php?ver={$prefs.rssfeed_default_version}" />
	  {/if}
	  {if $prefs.feature_directory eq 'y' and $prefs.rss_directories eq 'y'}
		  <link rel="alternate" type="application/xml" title="{tr}RSS Directories{/tr}" href="tiki-directories_rss.php?ver={$prefs.rssfeed_default_version}" />
	  {/if}
	{* ---- END ---- *}
	
</head>
<!-- head.tpl end -->