<div id="askDelete" style="display:none; width:300px">
	Tem certeza que quer apagar esse arquivo do acervo?<br/><br/>
	<input type="checkbox" id="askDeleteCheckbox">Não mostrar este aviso novamente<br/><br/>
	<a class="pointer" onClick="deleteFile(0, (document.getElementById('askDeleteCheckbox').checked ? 1 : 0), 1);">SIM</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a class="pointer" onClick="hideLightbox('askDelete')">NÃO</a>
</div>