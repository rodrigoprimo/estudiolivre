<div id="el-license" style="display: none; width: 500px;">
	<br />
	<br />
	<h2>Escolha uma licença:</h2>

	Agora você precisa escolher sob qual licença sua obra será publicada.<br />
	As questões abaixo te ajudam nessa tarefa, mas se você tiver alguma dúvida, visite o FAQ sobre <a href="tiki-view_faq.php?faqId=2" target="_blank">Direitos autorais e generosidade intelectual</a>

	<div id="atribution">
	  <br />
 	  <b>Permitir o uso comercial de sua obra?</b><br />
	  <input style="width: auto;" type="radio" name="resposta1" value="2" onclick="resposta1 = 0; testLicense();">&nbsp;Não<br />
	  <input style="width: auto;" type="radio" name="resposta1" value="1" onclick="resposta1 = 1; testLicense();">&nbsp;Sim<br />
	  <br />

	  <b>Permitir o uso de trechos de sua obra para a criação de obras derivadas (sampling, colagem etc.)?</b><br />
	  <input style="width: auto;" type="radio" name="resposta2" value="2" onClick="resposta2 = 0; enableAttribution(); testLicense();">&nbsp;Não<br />
	  <input style="width: auto;" type="radio" name="resposta2" value="1" onClick="resposta2 = 1; disableAttribution(); testLicense();">&nbsp;Sim<br />
	  <br />

	  <b>Permitir modificações em sua obra?</b><br />
	  <input style="width: auto;" type="radio" id="resposta3-0" name="resposta3" value="2" onclick="resposta3 = 0; testLicense();" disabled>&nbsp;Não<br />
	  <input style="width: auto;" type="radio" id="resposta3-1" name="resposta3" value="1" onclick="resposta3 = 1; testLicense();" disabled>&nbsp;Sim<br />
	  <input style="width: auto;" type="radio" id="resposta3-2" name="resposta3" value="3" onclick="resposta3 = 2; testLicense();" disabled>&nbsp;Sim, contanto que outros compartilhem pela mesma licença <br />
	  <br />
	  <div id="licenseCont" style="display: none"><img id="licenseImg"><div id="licenseDesc"></div><br /></div>
      {if $upload}
	  <input id="uLicencaPadrao" type="checkbox" {if !$licenca}checked{/if}/> Definir como licença {tooltip text="Nas próximas vezes que você for enviar um arquivo a licença utilizada será essa"}padrão{/tooltip}.
      {/if}
	  <div id="licencaErro" style="display: none">Você não escolheu nenhuma licença!</div>
	  <br /><br />

	  <input style="width: auto;" type="submit" value="Escolher" onClick="saveLicenca();"/>&nbsp;&nbsp;&nbsp;
	  <input style="width: auto;" type="submit" value="Cancelar" onClick="hideLightbox();"/>&nbsp;&nbsp;&nbsp;
	</div>
</div>