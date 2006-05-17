var timerId = null;
var uploadStartTimer = null;
var uploadId;
var uploadStarted = false;
var originalWidth;
var tipoSelecionado = false;
var tipos = new Array('Audio','Video','Imagem','Texto');

function upload() {
	uploadId = document.uploadForm.UPLOAD_IDENTIFIER.value;
	if (!tipoSelecionado) alert('bug');
	xajax_create_file(tipoSelecionado, uploadId);		
}

function startUpload(arquivoId) {
	document.uploadForm.arquivoId.value = arquivoId;
	// TODO: checar o tipo
	updateUploadInfo();
	document.uploadForm.submit();
}

function updateUploadInfo() {
	if (!uploadStarted) {
		uploadStarted = true;
		originalWidth = 159;
		document.uploadForm.style.display = 'none';
		document.getElementById('gUpButton').innerHTML = 'cancelar';
		document.getElementById('gUpPercent').innerHTML = '0%';
		document.getElementById('gUpStatusBar').style.width = '0px';
		document.getElementById('gUpStatusBar').className = "gUpStatus gUpUploading";
	}
	xajax_upload_info(uploadId);
	timerId = setTimeout('updateUploadInfo()',1000);
}

function finishUpload() {
	if (timerId) {
		clearTimeout(timerId);
		document.getElementById('gUpButton').innerHTML = 'remover';
		document.getElementById('gUpStatusBar').className = "gUpStatus gUpEditing";
		document.getElementById('gUpStatusBar').style.width = originalWidth + 'px';
		document.getElementById('gUpPercent').style.backgroundColor = '#ffe475';
		document.getElementById('gUpPercent').innerHTML = '100%';
	}
}

function updateProgressMeter(uploadInfo) {
	var normalized = uploadInfo['bytes_uploaded'] / uploadInfo['bytes_total'];
	var percent = Math.ceil(100 * normalized);
	if (percent) {
		document.getElementById('gUpPercent').innerHTML = percent + '%';
		document.getElementById('gUpStatusBar').style.width = originalWidth*normalized + 'px';
	}	
}

function changeStatus(value) {
	document.getElementById('gUpFileName').innerHTML = value.replace(new RegExp(/^.*(\/|\\)/), '');
	show('gUpRight');
	uploadStartTimer = setTimeout("upload()",2000);
	document.uploadForm.tipo.value = tipoSelecionado;
}

function acendeTipo(tipo) {
	if (!tipoSelecionado) {
		document.getElementById("icone" + tipo).src = "styles/estudiolivre/iUp" + tipo + ".png";
	}
}

function apagaTipo(tipo) {
	if (!tipoSelecionado) {
		document.getElementById("icone" + tipo).src = "styles/estudiolivre/iUp" + tipo + "Off.png";
	}
}

function selecionaTipo(tipo) {
	if (tipoSelecionado && !uploadStarted) {
		document.getElementById("icone" + tipoSelecionado).src = "styles/estudiolivre/iUp" + tipoSelecionado + "Off.png";
	}
	if (!uploadStarted) {
		tipoSelecionado = tipo;
		document.getElementById("icone" + tipo).src = "styles/estudiolivre/iUp" + tipo + ".png";
		show('gUpList');
	} else {
		alert('Voc? n?o pode mudar o tipo de arquivo depois de come?ar o upload')
	}
}

function saveField(field){
	
}

