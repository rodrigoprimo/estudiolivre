tipos = new Array('Audio', 'Video', 'Imagem', 'Texto');

//funcao que chama o ajax pra salvar o usuario
function call_save_function(field, value) {
	xajax_save_field(field, value);
}

function sendMsg() {
	var body = document.getElementById('uMsgSendInput').value;
	if (body) {
		xajax_sendMsg('foobar', body);
	}
}

//implementacao da licenca
var resposta1 = null;
var resposta2 = null;

function saveLicenca() {
	if (resposta1 && resposta2) {
		xajax_set_licenca(resposta1, resposta2);
		hide('licencaErro');
		hideLightbox();
	} else {
		show('licencaErro');
	}
}

function hideLicencaErro() {
		hide('licencaErro');
		return true;
}
