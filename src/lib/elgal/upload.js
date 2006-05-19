var timerId = null;
var uploadStartTimer = null;
var originalWidth = 159;
var uploadId;
var uploadStarted = false;
var originalWidth;
var tipoSelecionado = false;
var tipos = new Array('Audio','Video','Imagem','Texto');
var arquivoId = false;
var saveFieldCache = new Array();
var display = new Array();
var mudado = new Array();

function upload() {
	uploadId = document.uploadForm.UPLOAD_IDENTIFIER.value;
	if (!tipoSelecionado) alert('bug');
	xajax_create_file(tipoSelecionado, uploadId);		
}

function startUpload(id) {
	arquivoId = id;
	document.uploadForm.arquivoId.value = arquivoId;
	// TODO: checar o tipo
	updateUploadInfo();
	document.uploadForm.submit();
}

function updateUploadInfo() {
	if (!uploadStarted) {
		uploadStarted = true;
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
		document.getElementById('gUpButton').innerHTML = '<span onClick="removeUpload();">remover</span>';
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
    uploadStartTimer = setTimeout("upload()",500);
    document.uploadForm.tipo.value = tipoSelecionado;
}

function removeUpload() {
    uploadStarted = false;
    document.uploadForm.style.display = 'block';
    document.getElementById('gUpButton').innerHTML = 'procurar';
    document.getElementById('gUpPercent').innerHTML = '';
    document.getElementById('gUpStatusBar').style.width = '0px';
    document.getElementById('gUpStatusBar').className = "gUpStatus";
    document.getElementById('gUpFileName').innerHTML = '';
    document.uploadForm.reset();
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
		alert('Você não pode mudar o tipo de arquivo depois de começar o upload')
	}
}

function saveField(fieldObj){
    field = fieldObj.id.replace(/^input-/,'');
    value = fieldObj.value
    if (saveFieldCache[field] == null || saveFieldCache[field] != value) {
	xajax_save_field(arquivoId, field, value);
	saveFieldCache[field] = value;
    } else {
	exibeCampo(field, value);
    }
}

function limpaCampo(field) {
    if (mudado[field] == null) {
	document.getElementById('input-'+field).value = '';
    }
}

function exibeCampo(field, value) {
    if (value.length > 0) {
	var showElement = document.getElementById("show-" + field);
	showElement.style.display = display[field];
	showElement.innerHTML = value.replace(new RegExp(/\n/g), '<br/>');
	document.getElementById("input-" + field).style.display = "none";
    }
}

function editaCampo(field) {
    document.getElementById("show-"  + field).style.display = "none";
    document.getElementById("input-" + field).style.display = display[field];
    document.getElementById("input-" + field).focus();
	
}
