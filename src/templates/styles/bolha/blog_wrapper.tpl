{* $Id: blog_wrapper.tpl 29178 2010-09-13 17:56:34Z Jyhem $ *}
{css extra='tiki-view_blog_post,tiki-view_blog_post_item'}
<div class="postbody inline-block">
	<a name="postId{$post_info.postId}"></a>
	{include file='blog_post_postbody_title.tpl'}
	{include file='blog_post_author_info.tpl'}
	{include file='blog_post_postbody_content.tpl'}
	<div class="postfooter">
		{if $blog_post_context ne 'print'}
			{include file='blog_post_author_actions.tpl'}
			{include file='blog_post_actions.tpl'}
			{include file='blog_post_status.tpl'}
		{/if}
	</div>
	{include file='blog_post_navigation.tpl'}
</div> <!-- postbody -->
