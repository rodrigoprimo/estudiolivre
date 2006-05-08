<div id="menu-el">

    <div><a href="el-gallery_upload.php">compartilhe sua obra</a></div>

    <div><a href="tiki-view_forum.php?forumId=16">sobre o acervo</a></div>

    <div><a href="el-gallery_list.php">todos os arquivos</a></div>

    <div><a href="tiki-view_faq.php?faqId=3">FAQ acervo livre</a></div>

    <div><a href="tiki-index.php?page=Contato+acervo">contato</a></div>

</div>

{if $user}
<div id="menu-usergal">
  <div id="el-u-avatar"><a href="tiki-user_information.php">{$avatar}</div></a>
  <div id="el-u-info">
    {$user|userlink}<br/>
    {if $user_uploads neq 0}
      {if $user_uploads eq 1}<a href="el-gallery_manage.php">{$user_uploads}</a> arquivo na galeria<br/>
      {else}<a href="el-gallery_manage.php">{$user_uploads}</a> arquivos na galeria<br/>
      {/if}
    {/if}
    {if $new_files neq 0}
      {if $new_files eq 1}{$new_files} novo arquivo desde sua última visita
      {else}{$new_files} novos arquivos desde sua última visita
      {/if}
    {/if}
  </div>
</div>
{/if}