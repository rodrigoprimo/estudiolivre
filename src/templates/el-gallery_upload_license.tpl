<div id="el-license">
<br />
	<table class="el-upload-general el-upload-general4">
		<tr>
			<td class="el-upload-general-right">
				Passo 2 de 4 .:. Escolhendo a Licença&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
	</table>
	<br />
	<table class="el-upload-general">
		<tr>
			<td>
				{if $errormsg}<font color="red">{$errormsg}</font><br /><br />{/if}
	
				Agora você precisa escolher sob qual licença sua obra será publicada.<br />
				As questões abaixo te ajudam nessa tarefa, mas se você tiver alguma dúvida, visite o FAQ sobre <a href="tiki-view_faq.php?faqId=2" target="_blank">Direitos autorais e generosidade intelectual</a>
			</td>
		</tr>
	</table>
	
	<br />
 <form method="post" action="el-gallery_upload.php">
 	
	<table class="el-upload-general el-upload-general1">
		<tr>
			<td>
				<h2>Tipo de Licença</h1>
				<input style="width: auto;" type="radio" name="tipo" id="tipo1" value="1" onClick="showLicence('atribution');" />&nbsp;<b>Alguns Direitos Reservados</b><br />
				<input style="width: auto;" type="radio" name="tipo" value="1" onClick="showLicence('sampling');" />&nbsp;<b>Recombo</b><br /><br />
			</td>
		</tr>
	</table>
	
    <div id="atribution" style="display:none">
        <br />
		<table class="el-upload-general el-upload-general2">
		<tr>
			<td>
				<b>Permitir o uso comercial de sua obra?</b><br />
				<input style="width: auto;" type="radio" name="resposta1" value="1" onclick="s('1')">&nbsp;Sim<br />
				<input style="width: auto;" type="radio" name="resposta1" value="2" onclick="s('1')">&nbsp;Não<br />
		        <br />

        		<b>Permitir modificações em sua obra?</b><br />
        		<input style="width: auto;" type="radio" name="resposta2" value="1" onclick="s('1')">&nbsp;Sim<br />
        		<input style="width: auto;" type="radio" name="resposta2" value="3" onclick="s('1')">&nbsp;Sim, contanto que outros compartilhem pela mesma licença <br />
        		<input style="width: auto;" type="radio" name="resposta2" value="2" onclick="s('1')" >&nbsp;Não<br />
				
			</td>
		</tr>
		</table>

        <br />
		<table class="el-upload-general el-upload-general3">
			<tr>
				<td class="el-upload-general-right">
				<input style="width: auto;" type="submit" id="_submit" name="save" value=" Continuar >>" disabled="disabled"/>&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		
		
    </div>
    <div id="sampling" style="display:none">
        <br />
		<table class="el-upload-general el-upload-general2">
		<tr>
			<td>
				
				<table border="0" cellspacing="8" cellpadding="0">
				<tr>
					<td width="64"><img src="styles/estudiolivre/sampling.gif" align="left" alt="Sampling" /></td>
					<td><input style="width: auto;" type="radio" name="resposta1" value="3"> <label
					for="sampling"><strong>Recombinação</strong>: As pessoas podem pegar e transformar <strong>pedaços</strong> do seu trabalho para qualquer fim exceto publicidade, que é proibida. Cópias e distribuição do  <strong>trabalho inteiro</strong> são <strong>proibidas</strong>.</label></td>
				
				</tr>
				<tr>
					<td><img src="styles/estudiolivre/sampling_plus.gif" align="left" alt="Sampling" /></td>
					<td><input style="width: auto;" type="radio" name="resposta1" value="4"> <label
					for="sampling+"><strong>Recombinação Plus</strong>: As pessoas podem pegar e transformar <strong>pedaços</strong> do seu trabalho para qualquer fim exceto publicidade, que é proibida. <strong>Cópias não-comerciais</strong> e distribuição (como troca de arquivos) do  <strong>trabalho inteiro</strong> são permitidas. Daí, "<strong>plus</strong>".</label></td>
				
				</tr>
				<tr>
					<td><img src="styles/estudiolivre/sampling_plus_nc.gif" align="left" alt="Sampling" /></td>
					<td><input style="width: auto;" type="radio" name="resposta1" value="5"> <label
					for="nc-sampling+"><strong>Uso Não-Comercial para Recombinação Plus</strong>: As pessoas podem pegar e transformar <strong>pedaços</strong> do seu trabalho somente para fins <strong>não-comerciais</strong>. <strong>Cópias não-comerciais</strong> e distribuição (como troca de arquivos) do  <strong>trabalho inteiro</strong> são permitidas.</label></td>
				
				</tr>
				</table>
				
			</td>
		</tr>
		</table>		
		<br />
		<table class="el-upload-general el-upload-general3">
			<tr>
				<td class="el-upload-general-right">
				<input style="width: auto;" type="submit" name="save" value=" Continuar >>" />&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		
		
    </div>
	
	
    {* <input type="hidden" name="arquivoId" value="{$arquivoId|escape}">
    <input type="hidden" name="step" value="license"> *}
</form>
<br /><br /><br /><br />
</div>
