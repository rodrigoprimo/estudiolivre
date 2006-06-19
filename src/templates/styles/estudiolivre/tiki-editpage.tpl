{* $Header: /home/rodrigo/devel/arca/estudiolivre/src/templates/styles/estudiolivre/tiki-editpage.tpl,v 1.3 2006-06-19 06:25:33 rhwinter Exp $ *}

{popup_init src="lib/overlib.js"}

{* Check to see if there is an editing conflict *}
{if $editpageconflict == 'y'}
	<script language='Javascript' type='text/javascript'>
	<!-- //Hide Script
		alert("{tr}This page is being edited by{/tr} {$semUser}. {tr}Proceed at your own peril{/tr}.")
	//End Hide Script -->
	</script>
{/if}

{if $preview}
	<div id="wikiPreviewCont">
		{include file="tiki-preview.tpl"}

	</div>

{/if}

<h1>Edição da página <u>{$page|escape}{if $pageAlias ne ''}&nbsp;({$pageAlias|escape}){/if}</u></h1>

{if $page|lower eq 'sandbox'}
	<div class="wikitext">
	{tr}The SandBox is a page where you can practice your editing skills, use the preview feature to preview the appearance of the page, no versions are stored for this page.{/tr}
	</div>
{/if}



<form  enctype="multipart/form-data" method="post" action="tiki-editpage.php" id='editpageform'>

{if $page_ref_id}
	<input type="hidden" name="page_ref_id" value="{$page_ref_id}" />
{/if}

{if $current_page_id}
	<input type="hidden" name="current_page_id" value="{$current_page_id}" />
{/if}

{if $add_child}
	<input type="hidden" name="add_child" value="true" />
{/if}
{if $can_wysiwyg}
	{if !$wysiwyg}
		<span class="button2"><a class="linkbut" href="?page={$page}&&wysiwyg=y">{tr}Use wysiwyg editor{/tr}</a></span>
	{else}
		<span class="button2"><a class="linkbut" href="?page={$page}&&wysiwyg=n">{tr}Use normal editor{/tr}</a></span>
	{/if}
{/if}

{if $categIds}
	{section name=o loop=$categIds}
		<input type="hidden" name="cat_categories[]" value="{$categIds[o]}" />
	{/section}
	<input type="hidden" name="categId" value="{$categIdstr}" />
	<input type="hidden" name="cat_categorize" value="on" />
{else}
<br/>
	{if $tiki_p_view_categories eq 'y'}
		{include file=categorize.tpl}
	{/if}
{/if}

{include file=structures.tpl}

{if $feature_wiki_templates eq 'y' and $tiki_p_use_content_templates eq 'y' and !$templateId}
	{tr}Apply template{/tr}:
	<select name="templateId" onchange="javascript:document.getElementById('editpageform').submit();">
	<option value="0">{tr}none{/tr}</option>
	{section name=ix loop=$templates}
		<option value="{$templates[ix].templateId|escape}" {if $templateId eq $templates[ix].templateId}selected="selected"{/if}>{tr}{$templates[ix].name}{/tr}</option>
	{/section}
	</select>
{/if}

{if $feature_wiki_ratings eq 'y' and $tiki_p_wiki_admin_ratings eq 'y'}
	{tr}Use rating{/tr}:
	<br/>
	{if $poll_rated.info}
		<a href="tiki-admin_poll_options.php?pollId={$poll_rated.info.pollId}">{$poll_rated.info.title}</a>
		<span class="button2"><a class="linkbut" href="tiki-editpage.php?page={$page|escape:"url"}&amp;removepoll={$poll_rated.info.pollId}">{tr}disable{/tr}</a>
		<input type="hidden" name="poll_template" value="{$poll_rated.info.pollId}" />
		{if $tiki_p_admin_poll eq 'y'}
			<span class="button2"><a class="linkbut" href="tiki-admin_polls.php">{tr}admin polls{/tr}</a></span>
		{/if}
	{else}
		{if count($polls_templates)}
			{tr}type{/tr}
			<select name="poll_template">
			<option value="0">{tr}none{/tr}</option>
			{section name=ix loop=$polls_templates}
				<option value="{$polls_templates[ix].pollId|escape}"{if $polls_templates[ix].pollId eq $poll_template} selected="selected"{/if}>{tr}{$polls_templates[ix].title}{/tr}</option>
			{/section}
			</select>
			{tr}title{/tr}
			<input type="text" name="poll_title" value="{$poll_title|escape}" size="22" />
		{else}
			{tr}There is no available poll template.{/tr}
			{if $tiki_p_admin_polls ne 'y'}
				{tr}You should ask an admin to create them.{/tr}
			{/if}
		{/if}
		{if count($listpolls)}
			or use 
			<select name="olpoll">
			<option value="">... {tr}an existing poll{/tr}</option>
			{section name=ix loop=$listpolls}
				<option value="{$listpolls[ix].pollId|escape}">{tr}{$listpolls[ix].title|default:"<i>... no title ...</i>"}{/tr} ({$listpolls[ix].votes} {tr}votes{/tr})</option>
			{/section}
			</select>
		{/if}
	{/if}
{/if}

{if $feature_multilingual eq 'y'}
	{tr}Language{/tr}:
	<br/>
	<select name="lang">
	<option value="">Escolha o idioma dessa página...</option>
	{section name=ix loop=$languages}
		<option value="{$languages[ix].value|escape}"{if $lang eq $languages[ix].value} selected="selected"{/if}>{$languages[ix].name}</option>
	{/section}
	</select>
	{*<tr class="formcolor"><td>{tr}Is a translation of this page:{/tr}</td><td><input style="width:95%;" type="text" name="translation" value="{$translation|escape}" /></td></tr>*}
{/if}

{*os smileys são un FEATURE!!!!!! era só desabilitar!....*}
{*if $feature_smileys eq 'y'&&!$wysiwyg}
	{tr}Smileys{/tr}:
	{include file="tiki-smileys.tpl" area_name='editwiki'}
{/if*}

{if $feature_wiki_description eq 'y'}
	{tr}Description{/tr}:
	<input class="wikitext" type="text" name="description" value="{$description|escape}" />
{/if}

<br/>{tr}Edit{/tr}:<br />

{*if !$wysiwyg}
	{include file="textareasize.tpl" area_name='editwiki' formId='editpageform'}<br /><br />
	{include file=tiki-edit_help_tool.tpl area_name='editwiki'}
{/if*}

<textarea id='editwiki' class="wikiedit" name="edit" rows="40" style="WIDTH: 100%;">
	{$pagedata|escape}
</textarea>

{if $wysiwyg}
	 <script type="text/javascript" src="lib/fckeditor/fckeditor.js"></script>
	 <script type="text/javascript">
        sBasePath = 'lib/fckeditor/';
		var oFCKeditor = new FCKeditor( 'edit' ) ;
		oFCKeditor.BasePath	= sBasePath ;
		oFCKeditor.ReplaceTextarea() ;
	 </script>
{/if}

<input type="hidden" name="rows" value="{$rows}"/>
<input type="hidden" name="cols" value="{$cols}"/>
{*</td></tr>*}

{if $feature_wiki_footnotes eq 'y'}
	{if $user}
		{*<tr class="formcolor"><td>*}
		{tr}My Footnotes{/tr}:
		<textarea name="footnote" rows="8" cols="42" style="width:95%;" >{$footnote|escape}</textarea>
	{/if}
{/if}

{if $feature_wiki_replace eq 'y'}
	<script type="text/javascript">
	{literal}
	function searchrep() {
	  c = document.getElementById('caseinsens')
	  s = document.getElementById('search')
	  r = document.getElementById('replace')
	  t = document.getElementById('editwiki')
	
	  var opt = 'g';
	  if (c.checked == true) {
	    opt += 'i'
	  }
	  var str = t.value
	  var re = new RegExp(s.value,opt)
	  t.value = str.replace(re,r.value)
	}
	{/literal}
	</script>
	{tr}Search {/tr}:
	<input class="wikitext" type="text" id="search"/>
	Replace to:
	<input class="wikitext" type="text" id="replace"/>
	<input type="checkbox" id="caseinsens" />{tr}Case Insensitivity{/tr}
	<input type="button" value="{tr}replace{/tr}" onclick="javascript:searchrep();">
{/if}

{if $page|lower neq 'sandbox'}
	{tr}Edit Summary{/tr}:
	<input class="wikitext" type="text" name="comment" value="{$commentdata|escape}" />
	{if $wiki_feature_copyrights  eq 'y'}
		{tr}Copyright{/tr}:
		<tr class="formcolor"><td>
		{tr}Title:{/tr}
		<input size="40" class="wikitext" type="text" name="copyrightTitle" value="{$copyrightTitle|escape}" />
		{tr}Year:{/tr}
				<input size="4" class="wikitext" type="text" name="copyrightYear" value="{$copyrightYear|escape}" />
		{tr}Authors:{/tr}
			<input size="40" class="wikitext" name="copyrightAuthors" type="text" value="{$copyrightAuthors|escape}" />
	{/if}
{/if}

{if $feature_freetags eq 'y' and $tiki_p_freetags_tag eq 'y'}
	<br/>
	{include file=freetag.tpl}
{/if}

{if $feature_wiki_allowhtml eq 'y' and $tiki_p_use_HTML eq 'y'}
	<br/>
	{tr}Allow HTML{/tr}:
	 <input type="checkbox" name="allowhtml" {if $allowhtml eq 'y'}checked="checked"{/if}/>
{/if}

{if $wiki_spellcheck eq 'y'}
	{tr}Spellcheck{/tr}:
	<input type="checkbox" name="spellcheck" {if $spellcheck eq 'y'}checked="checked"{/if}/>
{/if}

{if $feature_wiki_import_html eq 'y'}
	  {tr}Import HTML{/tr}:
	    <input class="wikitext" type="text" name="suck_url" value="{$suck_url|escape}" />&nbsp;
	    <input type="submit" class="wikiaction" name="do_suck" value="{tr}Import{/tr}" />&nbsp;
	    <input type="checkbox" name="parsehtml" {if $parsehtml eq 'y'}checked="checked"{/if}/>&nbsp;
	    {tr}Try to convert HTML to wiki{/tr}
{/if}

{if $tiki_p_admin_wiki eq 'y'}
	{tr}Import page{/tr}:
	<input type="hidden" name="MAX_FILE_SIZE" value="1000000000" />
	<input name="userfile1" type="file" />
	<a href="tiki-export_wiki_pages.php?page={$page|escape:"url"}&amp;all=1" class="link">{tr}export all versions{/tr}</a>
{/if}

{if $feature_wiki_pictures eq 'y' and $tiki_p_upload_picture eq 'y'}
	<br/>
	{tr}Upload picture{/tr}
	<input type="hidden" name="MAX_FILE_SIZE" value="1000000000" />
	<input type="hidden" name="hasAlreadyInserted" value="" />
	<input type="hidden" name="prefix" value="/img/wiki_up/{if $tikidomain}{$tikidomain}/{/if}" />
	<input name="picfile1" type="file" onchange="javascript:insertImg('editwiki','picfile1','hasAlreadyInserted')"/>
{/if}

{if $feature_wiki_icache eq 'y'}
	{tr}Cache{/tr}
	    <select name="wiki_cache">
	    <option value="0" {if $wiki_cache eq 0}selected="selected"{/if}>0 ({tr}no cache{/tr})</option>
	    <option value="60" {if $wiki_cache eq 60}selected="selected"{/if}>1 {tr}minute{/tr}</option>
	    <option value="300" {if $wiki_cache eq 300}selected="selected"{/if}>5 {tr}minutes{/tr}</option>
	    <option value="600" {if $wiki_cache eq 600}selected="selected"{/if}>10 {tr}minute{/tr}</option>
	    <option value="900" {if $wiki_cache eq 900}selected="selected"{/if}>15 {tr}minutes{/tr}</option>
	    <option value="1800" {if $wiki_cache eq 1800}selected="selected"{/if}>30 {tr}minute{/tr}</option>
	    <option value="3600" {if $wiki_cache eq 3600}selected="selected"{/if}>1 {tr}hour{/tr}</option>
	    <option value="7200" {if $wiki_cache eq 7200}selected="selected"{/if}>2 {tr}hours{/tr}</option>
	    </select> 
{/if}

<br />
<input type="hidden" name="page" value="{$page|escape}" />
<input type="submit" class="wikiaction" name="preview" value="{tr}preview{/tr}" />

{if $feature_antibot eq 'y' && $anon_user eq 'y'}
	{tr}Anti-Bot verification code{/tr}:
	<img src="tiki-random_num_img.php" alt='{tr}Random Image{/tr}'/>
	{tr}Enter the code you see above{/tr}:
	<input type="text" maxlength="8" size="8" name="antibotcode" />
{/if}

{if $wiki_feature_copyrights  eq 'y'}
	{tr}License{/tr}:
	<a href="tiki-index.php?page={$wikiLicensePage}">{tr}{$wikiLicensePage}{/tr}</a>
	{if $wikiSubmitNotice neq ""}
		{tr}Important{/tr}:
		<b>{tr}{$wikiSubmitNotice}{/tr}</b>
	{/if}
{/if}

{if $page|lower neq 'sandbox' or $tiki_p_admin eq 'y'}
	{if $tiki_p_minor eq 'y' and $page|lower ne 'sandbox'}
		<input type="checkbox" name="isminor" value="on" />{tr}Minor{/tr}
	{/if}
	<input type="submit" class="wikiaction" name="save" value="{tr}save{/tr}" /> &nbsp;&nbsp;
	{if $page|lower ne 'sandbox'}
		<input type="submit" class="wikiaction" name="cancel_edit" value="{tr}cancel edit{/tr}" />
	{/if}
{/if}

</form>
<br />

{if !$wysiwyg}
 {include file=tiki-edit_help.tpl}
{/if}
