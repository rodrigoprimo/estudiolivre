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

function saveLicenca() {
    if (resposta1 != null && resposta2 != null && (resposta2 == 1 || resposta3 != null)) {
	xajax_set_licenca(resposta1, resposta2, resposta3);
	hide('licencaErro');
	hideLightbox();
    } else {
	show('licencaErro');
    }
}

