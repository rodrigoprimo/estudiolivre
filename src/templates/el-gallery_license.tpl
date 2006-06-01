<div id="el-license" style="display: none; width: 500px;">
	<br />
	<br />

	Agora você precisa escolher sob qual licença sua obra será publicada.<br />
	As questões abaixo te ajudam nessa tarefa, mas se você tiver alguma dúvida, visite o FAQ sobre <a href="tiki-view_faq.php?faqId=2" target="_blank">Direitos autorais e generosidade intelectual</a>

	<div id="atribution">
	    <br />
		<table class="el-upload-general el-upload-general2">
		<tr>
			<td>
				<b>Permitir o uso comercial de sua obra?</b><br />
				<input style="width: auto;" type="radio" name="resposta1" value="2" onclick="resposta1 = 1;">&nbsp;Não<br />
		        <input style="width: auto;" type="radio" name="resposta1" value="1" onclick="resposta1 = 2">&nbsp;Sim<br />
				<br />

        		<b>Permitir modificações em sua obra?</b><br />
        		<input style="width: auto;" type="radio" name="resposta2" value="2" onclick="resposta2 = 1;" >&nbsp;Não<br />
				<input style="width: auto;" type="radio" name="resposta2" value="1" onclick="resposta2 = 2;">&nbsp;Sim<br />
        		<input style="width: auto;" type="radio" name="resposta2" value="3" onclick="resposta2 = 3;">&nbsp;Sim, contanto que outros compartilhem pela mesma licença <br />
        		
			</td>
		</tr>
		</table>
		<br />
		
		<input id="uLicencaPadrao" type="checkbox" {if !$licenca}checked{/if}/> Definir como licença padrão.
		<div id="licencaErro" style="display: none">Você não escolheu nenhuma licença!</div>
        <br />
		<table class="el-upload-general el-upload-general3">
			<tr>
				<td class="el-upload-general-right">
					<input style="width: auto;" type="submit" value="Escolher" onClick="saveLicenca();"/>&nbsp;&nbsp;&nbsp;
				</td>
				<td class="el-upload-general-right">
					<input style="width: auto;" type="submit" value="Cancelar" onClick="hideLightbox();"/>&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		
		
    </div>
     
</div>
