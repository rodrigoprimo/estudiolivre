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