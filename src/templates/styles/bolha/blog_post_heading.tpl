{if $blog_data.use_title_in_post eq 'y'}
	{css extra=list}
	<div id="blogHead">
		<h1>{tr}Blog{/tr}: <a href="tiki-view_blog.php?blogId={$blogId}">{$blog_data.title|escape}</a></h1>
	</div>
{/if}