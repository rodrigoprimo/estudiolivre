<div id="el-arquivo">


<form method="post" enctype="multipart/form-data">
<input type="hidden" name="arquivoId" value="{$arquivo.arquivoId}">
<input type="hidden" name="tipo" value="{$arquivo.tipo}">
<input type="hidden" name="arquivo" value="{$arquivo.arquivo}">

<br />
	<table class="el-upload-general el-upload-general4">
		<tr>
			<td class="el-upload-general-right">
				Passo 4 de 4 .:. Dados adicionais sobre sua obra&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
	</table>
	<br />
	<table class="el-upload-general">
		<tr>
			<td>
				{if $errormsg}<font color="red">{$errormsg}</font><br /><br />{/if}
	
				O preenchimento dos campos a seguir não é obrigatório, mas ajudam a descrever melhor o arquivo para quem estiver navegando no site.
			</td>
		</tr>
	</table>
<br>
        <table class="el-upload-general el-upload-general1">
	        {if $arquivo.tipo eq "Video" || $arquivo.tipo eq "Imagem"}
	        <tr><td class="el-upload-general-right">
		  <input type="checkbox" name="autothumb" onClick="toggleThumbUp()" style="width: auto;"></td>
		  <td>Criar thumbnail automaticamente...</td></tr>
		{/if}
		<tr id="thumbup" style="display:table-row">
			<td class="el-upload-general-right">Thumbnail:</td>
			<td>... ou subir um arquivo<br>
			  <input style="width: auto;" type="file" name="geralStub[thumbnail]" size=40>
			</td>
		</tr>
                        {include file="el-gallery_upload_todos.tpl"}

	</table>


{* comentando pq num tah funcionando 

<br/><b>Informações sobre arquivo de {$arquivo.tipo} </b><br/><br/>
{include file="el-gallery_upload_"|cat:$arquivo.tipo|cat:".tpl"}

<br />
	<table class="el-upload-general el-upload-general3">

		<tr>
			<td colspan="2" class="el-upload-general-right">
				
    			<input style="width: auto;" type="submit" name="save" value=" Salvar " />&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
	</table>
<input type="hidden" name="step" value="metadata"> *}



</form>


</div>