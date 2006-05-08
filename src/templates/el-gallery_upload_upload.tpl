<div id="el-arquivo">
<br/>
<form method="post" enctype="multipart/form-data" action="el-gallery_upload.php">
    <table class="el-upload-general el-upload-general4">
		<tr>
			<td class="el-upload-general-right">
				Passo 3 de 4 .:. Envio da obra para o acervo&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
    </table>
    <br />
    <table class="el-upload-general el-upload-general1">
            <tr>
                    <td>
                            {if $errormsg}<font color="red">{$errormsg}</font><br /><br />{/if}
                            Arquivo: <input style="width: auto;" type="file" name="arquivo" size=40 /><br>
                    </td>
            </tr>
    </table>
    <br />
    <table class="el-upload-general el-upload-general2">

		<tr>
			<td colspan="2" class="el-upload-general-right">
			<div align='left'>
                        <a href='el-gallery_manage.php'>Lista de arquivos pendentes</a>	
    			&nbsp;&nbsp;&nbsp;
                        </div>
			</td>
		</tr>
    </table>
    <br />
    <table class="el-upload-general el-upload-general3">

		<tr>
			<td colspan="2" class="el-upload-general-right">
                        <input style="width: auto;" type="submit" name="save" value="{tr}Save{/tr}" />
    			&nbsp;&nbsp;&nbsp;
                        </div>
			</td>
		</tr>
    </table>
    <input type="hidden" name="step" value="upload" />
    <input type="hidden" name="arquivoId" value="{$arquivoId}" />
    <input type="hidden" name="tipo" value="{$arquivo.tipo}" />
	
</form>
</div>