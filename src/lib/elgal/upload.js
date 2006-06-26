var timerId = null;
var thumbTimerId = null;
var uploadStartTimer = null;
var originalWidth = 159;
var uploadId;
var thumbUpId;
var uploadStarted = false;
var upThumbStarted = false;
var originalWidth;
var tipoSelecionado = false;
var tipos = new Array('Audio','Video','Imagem','Texto');
var arquivoId = false;
var uploadFinished = false;
var uploadError = false; // nao faz nada por enquanto

function setRequestUri(id) {
	if (xajaxRequestUri.match(new RegExp(/arquivoId=/))) {
		xajaxRequestUri = xajaxRequestUri.replace(new RegExp(/arquivoId=\d+/), 'arquivoId='+id);
	} else {
		xajaxRequestUri += '?arquivoId=' + id;
	}
}

function upload() {
	uploadId = document.uploadForm.UPLOAD_IDENTIFIER.value;
	var filename = document.uploadForm.arquivo.value;
	if (!tipoSelecionado) alert('bug');
	if (arquivoId) {
		startUpload(arquivoId);
	} else {
		xajax_create_file(tipoSelecionado, filename, uploadId);		
	}
}

function startUpload(id) {
	arquivoId = id;
	setRequestUri(id);
	document.uploadForm.arquivoId.value = arquivoId;
	document.thumbForm.arquivoId.value = arquivoId;
	updateUploadInfo();
	document.uploadForm.submit();
}

function updateUploadInfo() {
	if (!uploadStarted) {
		uploadStarted = true;
		document.uploadForm.style.display = 'none';
		document.getElementById('gUpButton').innerHTML = '<span onClick="cancelUpload();">cancelar</span>';
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
		uploadFinished = true;
		if (uploadError) {
			return removeUpload();
		}
		document.getElementById('gUpButton').innerHTML = '<span onClick="removeUpload();">remover</span>';
		document.getElementById('gUpStatusBar').className = "gUpStatus gUpEditing";
		document.getElementById('gUpStatusBar').style.width = originalWidth + 'px';
		document.getElementById('gUpPercent').style.backgroundColor = '#ffe475';
		document.getElementById('gUpPercent').innerHTML = '100%';
		if (thumbUpId == null && (tipoSelecionado == 'Imagem' || tipoSelecionado == 'Video')) {
			document.getElementById('thumbnail').src = "";			
			document.getElementById('thumbnail').className = "gUpThumbImgCreating";
			setTimeout('document.getElementById("thumbnail").src = "styles/estudiolivre/iProgress.gif"',100);
			xajax_generate_thumb();
		}
		xajax_get_file_info();
	}
}

function setAutoFields(result) {
	for (var i=0; i<result.length; i += 2) {
		setEditData(result[i], result[i+1]);
		exibeCampo(result[i], result[i+1]);		
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
    hide('fileAltered');
    uploadStartTimer = setTimeout("upload()",500);
    document.uploadForm.tipo.value = tipoSelecionado;
    document.getElementById('thumbnail').src = 'styles/estudiolivre/iThumb'+tipoSelecionado+'.png';
}

function removeUpload() {
	uploadError = false;
    uploadStarted = false;
    uploadFinished = false;
    document.uploadForm.style.display = 'block';
    document.getElementById('gUpButton').innerHTML = 'procurar';
    document.getElementById('gUpPercent').innerHTML = '';
    document.getElementById('gUpPercent').style.backgroundColor = '#e1a7a4';
    document.getElementById('gUpStatusBar').style.width = '0px';
    document.getElementById('gUpStatusBar').className = "gUpStatus";
    document.getElementById('gUpFileName').innerHTML = '';
    document.uploadForm.reset();
}

function cancelUpload() {
	if (uploadStarted) {
		window.stop();
		clearTimeout(timerId);
		removeUpload();
	}
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
	if (tipoSelecionado && !arquivoId) {
		document.getElementById("icone" + tipoSelecionado).src = "styles/estudiolivre/iUp" + tipoSelecionado + "Off.png";
	}
	if (!arquivoId) {
		tipoSelecionado = tipo;
		document.getElementById("icone" + tipo).src = "styles/estudiolivre/iUp" + tipo + ".png";
		show('gUpList');
	} else {
		fixedTooltip('Você não pode mudar o tipo de arquivo depois de começar o upload');
	}
}

function call_save_function(field, value) {
	setWaiting(field, true);
	xajax_save_field(field, value);
}

function changeThumbStatus() {
    thumbUpId = document.thumbForm.UPLOAD_IDENTIFIER.value;
    document.thumbForm.submit();
    updateThumbUpInfo();
}

function updateThumbUpInfo() {
	if (!upThumbStarted) {
		upThumbStarted = true;
		hide('thumbnail');
		show('gUpThumbStatus');
		hide('gUpThumbForm');
		document.getElementById('gUpThumbStatus').innerHTML = '0%';
	}
	xajax_upload_info(thumbUpId, 'updateThumbProgressMeter');
	thumbTimerId = setTimeout('updateThumbUpInfo()',1000);
}

function finishUpThumb() {
	if (thumbTimerId) {
		clearTimeout(thumbTimerId);
	}
	upThumbStarted = false;
	show('thumbnail');
	show('gUpThumbForm');
	hide('gUpThumbStatus');
}

function updateThumbProgressMeter(uploadInfo) {
    var normalized = uploadInfo['bytes_uploaded'] / uploadInfo['bytes_total'];
    var percent = Math.ceil(100 * normalized);
    if (percent) {
	document.getElementById('gUpThumbStatus').innerHTML = percent + '%';	
    }	
}

function restoreForm (id, tipo, arquivo, thumbnail) {
	selecionaTipo(tipo);
	arquivoId = id;
	setRequestUri(id);
	show('gUpRight');
	if (arquivo) {
		document.uploadForm.style.display = 'none';
		document.getElementById('gUpButton').innerHTML = '<span onClick="removeUpload();">remover</span>';
		document.getElementById('gUpStatusBar').className = "gUpStatus gUpEditing";
		document.getElementById('gUpStatusBar').style.width = originalWidth + 'px';
		document.getElementById('gUpPercent').style.backgroundColor = '#ffe475';
		document.getElementById('gUpPercent').innerHTML = '100%';
	}
	if (thumbnail) {
		document.getElementById('thumbnail').src = 'repo/' + thumbnail;
	}
	restoreEdit(id);
}

function setUploadError(msg) {
	uploadError = true;
	var div=document.getElementById('errorDiv');
	div.innerHTML = msg;
	showLightbox('errorDiv');
}

//implementacao do checkLightBox para a licenca

function saveLicenca() {
	var padrao = false;
	if (resposta1 != null && resposta2 != null && (resposta2 == 1 || resposta3 != null)) {
		padrao = (document.getElementById("uLicencaPadrao").checked ? 1 : 0);
		xajax_set_arquivo_licenca(resposta1, resposta2, resposta3, padrao);
		hide('licencaErro');
		hideLightbox();
	} else {
		show('licencaErro');
	}
}

setLightboxCheckFunction('el-license',hideLicencaErro);

