{foreach from=$arquivos item=p}
  {include file="el-gallery_list_item.tpl" arquivo=$p}
{/foreach}

{if $total > $maxRecords}
  <br/>
  <center>
  {if $offset-$maxRecords >= 0}
    <span onClick="el_get_files('{$tipo}', {$offset-$maxRecords}, {$maxRecords}, 'data_publicacao_desc','','')">ant</span>
    &nbsp;&nbsp;&nbsp;&nbsp;
  {/if}
  {if $offset+$maxRecords < $total}
    <span onClick="el_get_files('{$tipo}', {$offset+$maxRecords}, {$maxRecords}, 'data_publicacao_desc','','')">prox</span>
  {/if}
  </center>
  <br/>
{/if}