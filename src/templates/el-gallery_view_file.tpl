<div id="el-arquivo">
{if sizeof($arquivo.thumbnail)}
  <br/><img src="el-download.php?arquivo={$arquivo.arquivoId}&thumbnail=1" border=0><br/>
{/if}
  <br/>
  <span style="vertical-align:top"><a id="titulo" href="el-download.php?arquivo={$arquivoId}&action=download">{$arquivo.titulo}</a>

  {if $arquivo.tipo eq 'Audio'}
    <object type="application/x-shockwave-flash" data="styles/estudiolivre/musicplayer.swf?&song_url=repo/{$arquivo.arquivo}" width="17" height="17"></object>
  {else}
    <a href="el-download.php?arquivo={$arquivoId}"><img src="styles/estudiolivre/entrar.png" border=0 title="stream"></a>
  {/if}
  </span>&nbsp;&nbsp;&nbsp;<a href="{$arquivo.licenca.link_human_readable}"><img src="{$arquivo.licenca.link_imagem}" border=0></a>
  <br/><br/>
  <img id="rtimg-{$arquivo.arquivoId}" src="styles/estudiolivre/rt_{math equation="round(x)" x=$arquivo.rating|default:"blk"}.png" width="16" height="16"><span id="rt-{$arquivo.arquivoId}">{$arquivo.rating}</span><br/>

  <span class="campo">Autor:</span> {$arquivo.autor}<br/>
  <span class="campo">publicação:</span> {$arquivo.data_publicacao|date_format:"%d/%m/%Y"}<br/>
  <span class="campo">Detentor dos DA:</span> {$arquivo.donoCopyright}<br/>
  <span class="campo">Produtora:</span> {$arquivo.produtora}<br/>
  <span class="campo">Contato:</span> {$arquivo.contato}<br/>
  <span class="campo">Palavras chave:</span>
  {foreach from=$freetags.data item=taginfo}
	  <a class="freetag" href="tiki-freetag_list_objects.php?tag={$taginfo.tag}">{$taginfo.tag}</a> 
  {/foreach}<br/>

  {include file="el-gallery_view_"|cat:$arquivo.tipo|cat:".tpl"}

<hr>

{if $tiki_p_read_comments eq 'y' || $comments_cant > 0}
<div id="page-bar">
<table>
<tr><t>
<div class="button2">
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
</td></tr></table>
</div>
{include file=comments.tpl}
{/if}

  
  <br/>

  <img src="http://creativecommons.org/images/public/somerights20.pt.png"><br/><br/><br/>

  {if $user eq $arquivo.user}
  <form method="post" action="el-gallery_manage.php" style="display:inline">
    <input type="hidden" name="arquivoId" value="{$arquivoId}" />
    <input type="hidden" name="action" value="edit" />
    <input type="submit" value="{tr}editar{/tr}" />
  </form>
  <form method="post" action="el-gallery_manage.php" style="display:inline">
    <input type="hidden" name="arquivoId" value="{$p.arquivoId}" />
    <input type="hidden" name="action" value="delete" />
    <input type="submit" value="{tr}excluir{/tr}" />
  </form><br/><br/>
  {/if}

  <a href="el-gallery_list_files.php">voltar pra lista</a><br/><br/><br/>

</div>