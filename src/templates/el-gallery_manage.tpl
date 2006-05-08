<script language="JavaScript" src="lib/cpaint/cpaint2.inc.js"></script>
<script language="JavaScript" src="lib/elgal/el-rating.js"></script>

{$msg}
<br/>

<div id="el-arquivo">

  <b>Todos os seus arquivos</b><br/><br/>
  {foreach from=$all.data item=p}
    {include file="el-gallery_list_item.tpl" arquivo=$p}
  {/foreach}
  <br />

  {if $pending.cant neq 0}
  <b>Arquivos pendentes</b><br/><br/>
  {foreach from=$pending.data item=p}
  <div class="el-list-pending">
    {if $p.licencaId eq 0 and $p.arquivo eq ""}
      <a id="titulop" href="el-gallery_upload.php?save=save&arquivoId={$p.arquivoId}&step=license">{$p.nomeArquivo}</a><br/><br/><br/>
      Licensa não especificada, Nenhum arquivo gravado<br/>
      <a href="el-gallery_manage.php?arquivoId={$p.arquivoId}&action=delete">
      apagar</a>
    {elseif $p.arquivo eq ""}
      <a id="titulop" href="el-gallery_upload.php?save=save&arquivoId={$p.arquivoId}&step=upload">{$p.nomeArquivo}</a><br/><br/><br/>
      <b>Licensa:</b> {$p.licenca}, Nenhum arquivo gravado<br/>
      <a href="el-gallery_manage.php?arquivoId={$p.arquivoId}&action=delete">
      apagar</a>
    {/if}
  </div>
  {/foreach}
  {/if}

<br/><br/>
<a href="el-gallery_upload.php">novo arquivo</a><br/>
<a href="el-gallery_list_files.php">ver todos</a><br/><br/>
</div>