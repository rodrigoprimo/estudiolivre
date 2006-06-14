//funcao que chama o ajax pra salvar o usuario
function call_save_function(field, value) {
	setWaiting(field, true);
	xajax_save_field(field, value);
}
