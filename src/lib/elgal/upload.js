var timerId = null;
var thumbTimerId = null;
var uploadStartTimer = null;
var originalWidth = 245;
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
var tagOffset = 0;

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
	    xajax_clear_uploaded_file();
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
		document.getElementById('js-cancel').innerHTML = '<span onClick="cancelUpload();">interromper</span>';
		document.getElementById('js-percent').innerHTML = '0%';
		document.getElementById('js-statusBar').style.width = '0px';
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
		document.getElementById('js-cancel').innerHTML = '';
		document.getElementById('js-statusBar').className = "statusBarGo";
		document.getElementById('js-statusBar').style.width = originalWidth + 'px';
		document.getElementById('js-percent').innerHTML = '100%';
		if (thumbUpId == null && (tipoSelecionado == 'Imagem' || tipoSelecionado == 'Video')) {
			setTimeout('document.getElementById("ajax-thumbnail").src = "styles/bolha/img/iProgress.gif"',100);
			xajax_generate_thumb();
		}
		xajax_get_file_info();
	}
}

function setAutoFields(result) {
	for (var i=0; i<result.length; i += 2) {
		if (!editing[result[i]]) {
			setEditData(result[i], result[i+1]);
			exibeCampo(result[i], result[i+1]);		
		}
	}
}

function updateProgressMeter(uploadInfo) {
	var normalized = uploadInfo['bytes_uploaded'] / uploadInfo['bytes_total'];
	var percent = Math.ceil(100 * normalized);
	if (percent) {
		document.getElementById('js-percent').innerHTML = percent + '%';
		document.getElementById('js-statusBar').style.width = originalWidth*normalized + 'px';
	}	
}

function changeStatus(value) {
    show('js-desc');
    //hide('fileAltered');
    document.uploadForm.tipo.value = tipoSelecionado;
    document.getElementById('ajax-thumbnail').src = 'styles/bolha/img/iThumb'+tipoSelecionado+'.png';
    uploadStartTimer = setTimeout("upload()",500);
}

function removeUpload() {
	uploadError = false;
    uploadStarted = false;
    uploadFinished = false;
    document.uploadForm.style.display = 'block';
    document.getElementById('js-cancel').innerHTML = '';
    document.getElementById('js-percent').innerHTML = '';
    document.getElementById('js-statusBar').style.width = '0px';
    document.getElementById('js-statusBar').className = "";
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
		document.getElementById("js-icone" + tipo).src = "styles/bolha/img/iUp" + tipo + ".png";
	}
}

function apagaTipo(tipo) {
	if (!tipoSelecionado) {
		document.getElementById("js-icone" + tipo).src = "styles/bolha/img/iUp" + tipo + "Off.png";
	}
}

function selecionaTipo(tipo) {
	if (tipoSelecionado && !arquivoId) {
		document.getElementById("js-icone" + tipoSelecionado).src = "styles/bolha/img/iUp" + tipoSelecionado + "Off.png";
	}
	if (!arquivoId) {
		tipoSelecionado = tipo;
		document.getElementById("js-icone" + tipo).src = "styles/bolha/img/iUp" + tipo + ".png";
		show('js-browse');
		hide('js-pending');
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
		document.getElementById("ajax-thumbnail").src = "styles/bolha/img/iProgress.gif";
		document.getElementById('js-thumbStatus').innerHTML = '0%';
	}
	xajax_upload_info(thumbUpId, 'updateThumbProgressMeter');
	thumbTimerId = setTimeout('updateThumbUpInfo()',1000);
}

function finishUpThumb() {
	if (thumbTimerId) {
		clearTimeout(thumbTimerId);
		upThumbStarted = false;
		hide('js-thumbForm');
	}
}

function updateThumbProgressMeter(uploadInfo) {
    var normalized = uploadInfo['bytes_uploaded'] / uploadInfo['bytes_total'];
    var percent = Math.ceil(100 * normalized);
    if (percent) {
		document.getElementById('js-thumbStatus').innerHTML = percent + '%';	
    }
}

function restoreForm (id, tipo, arquivo, thumbnail) {
	selecionaTipo(tipo);
	arquivoId = id;
	setRequestUri(id);
	show('js-desc');
	if (arquivo) {
		document.getElementById('js-statusBar').className = "statusBarGo";
		document.getElementById('js-statusBar').style.width = originalWidth + 'px';
		document.getElementById('js-percent').innerHTML = '100%';
	}
	if (thumbnail) {
		document.getElementById('ajax-thumbnail').src = 'repo/' + thumbnail;
	} else {
		document.getElementById('ajax-thumbnail').src = 'styles/bolha/img/iThumb' + tipo + '.png';
	}
	document.thumbForm.arquivoId.value = arquivoId;
	restoreEdit(id);
}

function setUploadErrorMsg(msg) {
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

function getMoreTags() {
	tagOffset += 10;
	xajax_get_more_tags(tagOffset, 10);
}
