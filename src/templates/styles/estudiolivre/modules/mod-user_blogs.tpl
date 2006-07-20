{* $Header: /home/rodrigo/devel/arca/estudiolivre/src/templates/styles/estudiolivre/modules/mod-user_blogs.tpl,v 1.1 2006-07-20 02:33:08 rhwinter Exp $ *}

{if $user}
    {if $feature_blogs eq 'y'}
		{tikimodule title="{tr}My blogs{/tr}" name="user_blogs" flip=$module_params.flip}
			{section name=ix loop=$modUserBlogs}
			    <a href="tiki-view_blog.php?blogId={$modUserBlogs[ix].blogId}">{$modUserBlogs[ix].title}</a>
			    &nbsp;&nbsp;&nbsp;
			    <a href="tiki-blog_post.php?blogId={$modUserBlogs[ix].blogId}">({tr}post{/tr})</a>
			    <br/>
			{/section}
		{/tikimodule}
    {/if}
{/if}
