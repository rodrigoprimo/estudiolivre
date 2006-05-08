<div id="el-arquivo">
<br/>
<form method="post" action="el-gallery_manage.php">

<table class="el-upload-general el-upload-general1">
    <tr><td class="el-upload-general-right">Titulo:</td><td><input type="text" name="geralStub[titulo]"  value="{$arquivo.titulo}" size=40/></td></tr>
    <tr><td class="el-upload-general-right">Tipo:</td><td>{$arquivo.tipo}</td></tr>
    <tr><td class="el-upload-general-right">Licença:</td><td>
    <select name="geralStub[licencaId]">
	{foreach from=$licencas.data item=tipo}
	{foreach from=$tipo item=l}
	<option value="{$l.licencaId}" {if $arquivo.licencaId eq $l.licencaId}selected{/if}>{$l.tipo}, {$l.subTipo}</option>
	{/foreach}
	{/foreach}
    </select></td></tr>
    <tr><td class="el-upload-general-right">Autor:</td><td><input type="text" name="geralStub[autor]" value="{$arquivo.autor}" size=40/></td></tr>
    <tr><td class="el-upload-general-right">Detentor de DA:</td><td><input type="text" name="geralStub[donoCopyright]" value="{$arquivo.donoCopyright}" size=40/></td></tr>
    {include file="el-gallery_upload_todos.tpl"}
</table><br/>
<table class="el-upload-general el-upload-general2">
    <tr><td colspan=2>Descrição:<br/>
    <textarea name="geralStub[descricao]" cols="50" rows="15">{$arquivo.descricao}</textarea></td></tr>
    {if $feature_freetags eq 'y' && $tiki_p_freetags_tag eq 'y'}
    <tr>
      <td class="el-upload-general-right">Palavras Chaves:</td>
      <td>
	<input type="text" name="freetag_string" value="{$taglist|escape}" size=40/><br>
	<script language="JavaScript">
	{literal}
	  function addTag(tag) {
	    el = document.getElementById('tagBox');
	    el.value += ' ' + tag;
	  }
	{/literal}
	</script>
	{foreach from=$tag_suggestion item=t}
	  <a href="javascript:addTag('{$t}')">{$t}</a> 
	{/foreach}
	
      </td>
    </tr>
    {/if}
</table><br/>

    {include file="el-gallery_upload_"|cat:$arquivo.tipo|cat:".tpl"}
    
    Arquivo: {$arquivo.arquivo}, {$arquivo.formato}, {$arquivo.tamanho|show_filesize}<br/>
    Thumbnail: <img src="el-gallery_list_files.php?arquivo={$arquivo.arquivoId}&thumbnail=1"> <br/>

    <input type="hidden" name="geralStub[tipo]" value="{$arquivo.tipo}">
    <input type="hidden" name="action" value="save"><br/>
    <input type="submit" value="{tr}save{/tr}"><br/><br/>

</form>
</div>