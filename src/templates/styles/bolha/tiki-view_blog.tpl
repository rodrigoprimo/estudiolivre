{css extra='tiki-view_blog_post_item'}
<div id="vBlog">
	{*this is really nasty stuff!
	if strlen($heading) > 0}
		{eval var=$heading}
	{else}
	{/if*}
	
	{include file="blog-heading.tpl"}
	
	{*this too!
	 if $use_find eq 'y'}
		<div class="blogtools">
			<form action="tiki-view_blog.php" method="get">
			<input type="hidden" name="sort_mode" value="{$sort_mode|escape}" />
			<input type="hidden" name="blogId" value="{$blogId|escape}" />
			{tr}Find:{/tr}
			 <input type="text" name="find" /> <input type="submit" name="search" value="{tr}find{/tr}" />
			</form>
		</div>
	{/if *}
	
	{foreach from=$listpages item=post_info}
		<div class="blogpost post{if !empty($container_class)} {$container_class}{/if} inline-block">
			{include file='blog_wrapper.tpl' blog_post_context='view_blog'}
		</div>
	{/foreach}
	
	{pagination_links cant=$cant step=$maxRecords offset=$offset class='paginacao'}{/pagination_links}
	
	{* isso aqui só confunde tudo... (vou tirar e ver no que dá!)
	<hr>
	{if $prefs.feature_blog_comments == 'y'
	  && (($tiki_p_read_comments  == 'y'
	  && $comments_cant != 0)
	  ||  $tiki_p_post_comments  == 'y'
	  ||  $tiki_p_edit_comments  == 'y')}
		<div id="comments">
			<a href="#comments" onclick="javascript:flip('comzone{if $comments_show eq 'y'}open{/if}');" class="linkbut">
				{if $comments_cant == 0}
			        {tr}add comment{/tr}
			        {elseif $comments_cant == 1}
			          <span class="highlight">{tr}1 comment{/tr}</span>
			        {else}
			          <span class="highlight">{$comments_cant} {tr}comments{/tr}</span>
			        {/if}
			</a>
		</div>
		{include file=comments.tpl}
	{/if}
	<hr>
	*}
</div>