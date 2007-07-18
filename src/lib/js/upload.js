var arquivoId = false;
var uploadIds = Array();
var uploadTimeouts = Array();
var originalWidth = 245;
var uploadI = 0;

// coloca o id do arquivo no request pra inicializar o arquivo nas chamadas ajax
function setRequestUri(id) {
	if (xajaxRequestUri.match(new RegExp(/arquivoId=/))) {
		xajaxRequestUri = xajaxRequestUri.replace(new RegExp(/arquivoId=\d+/), 'arquivoId='+id);
	} else {
		xajaxRequestUri += '?arquivoId=' + id;
	}
}

// depois de criada a publicacao, seta as infos nos formularios
function setPublication(id) {
	arquivoId = id;
	setRequestUri(id);
	document.uploadForm0.arquivoId.value = arquivoId;
	document.thumbForm.arquivoId.value = arquivoId;
}

// funcoes de lidar com o tipo
var tipoSelecionado = false;
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
		fixedTooltip('Voc&ecirc; n&atilde;o pode mudar o tipo de arquivo depois de come&ccedil;ar o upload');
	}
}
// fim do tipo

// chamada no onChange dos formularios de arquivo
function fileSelected(fileName, i) {
	if (!arquivoId) {
		show('js-desc');
    	document.getElementById('ajax-thumbnail').src = 'styles/bolha/img/iThumb'+tipoSelecionado+'.png';
    	xajax_create_file(tipoSelecionado, fileName);
	} else {
		newUpload(i);
	}
}

// inicializa um novo upload
// seta o uploadId usado no progress meter e da um submit no formulario
function newUpload(i) {
	var uploadId = Math.random().toString().replace(new RegExp(/0\./), '') + '.' + Date.now();
	uploadIds[i] = uploadId;
	setTimeout("startUploadProgress(" + i + ")", 500);
	eval("document.uploadForm" + i + ".UPLOAD_IDENTIFIER.setAttribute('value','" + uploadId + "')");
	eval("document.uploadForm" + i + ".submit()");
}

// inicializa os htmls de progress meter
function startUploadProgress(i) {
	document.getElementById('js-cancel' + i).innerHTML = '<span onClick="cancelUpload(' + i + ');">interromper</span>';
	document.getElementById('js-percent' + i).innerHTML = '0%';
	document.getElementById('js-statusBar' + i).style.width = '0px';
	updateUploadInfo(i);
}

// loop pra ficar atualizando o progress meter
function updateUploadInfo(i) {
	xajax_upload_info(uploadIds[i], i);
	uploadTimeouts[i] = setTimeout('updateUploadInfo(' + i + ')',1000);
}

// chamada no final do upload do arquivo
// para o loop de progrees meter e puxa infos automaticas
function finishUpload(i) {
	if (uploadTimeouts[i]) {
		clearTimeout(uploadTimeouts[i]);
		uploadTimeouts[i] = 0;
		document.getElementById('js-cancel' + i).innerHTML = '';
		document.getElementById('js-statusBar' + i).className = "statusBar statusBarGo";
		document.getElementById('js-statusBar' + i).style.width = originalWidth + 'px';
		document.getElementById('js-percent' + i).innerHTML = '100%';
		if (thumbId == null && (tipoSelecionado == 'Imagem' || tipoSelecionado == 'Video')) {
			setTimeout('document.getElementById("ajax-thumbnail").src = "styles/bolha/img/iProgress.gif"',100);
			xajax_generate_thumb();
		}
		xajax_get_file_info();
	}
}

// cancela um upload em progresso
function cancelUpload(i) {
	if (uploadTimeouts[i]) {
		window.stop();
		clearTimeout(uploadTimeouts[i]);
		uploadTimeouts[i] = 0;
		document.getElementById('js-cancel' + i).innerHTML = '';
		document.getElementById('js-percent' + i).innerHTML = '';
		document.getElementById('js-statusBar' + i).style.width = '0px';
	    document.getElementById('js-statusBar' + i).className = "statusBar statusBarGoing";
	    eval("document.uploadForm" + i + ".reset()");
	}
}

// busca mais sugestao de tags
var tagOffset = 0;
function getMoreTags() {
	tagOffset += 10;
	xajax_get_more_tags(tagOffset, 10);
}


// usada no ajax e no upload_file.php
function setUploadErrorMsg(msg) {
	document.getElementById('js-errorDiv').innerHTML = msg;
	showLightbox('js-errorDiv');
}

// salva a licenca escolhida no upload
function saveLicenca() {
	var padrao = false;
	if (resposta1 != null && resposta2 != null && (resposta2 == 1 || resposta3 != null)) {
		padrao = (document.getElementById("uLicencaPadrao").checked ? 1 : 0);
		if (document.getElementById('resposta3-0').disabled) xajax_set_arquivo_licenca(resposta1, resposta2, -1, padrao);
		else xajax_set_arquivo_licenca(resposta1, resposta2, resposta3, padrao);
		hide('licencaErro');
		hideLightbox();
	} else {
		show('licencaErro');
	}
}
//implementacao do checkLightBox para a licenca
setLightboxCheckFunction('el-license',hideLicencaErro);

// chamados somente pelo ajax
function setAutoFields(result) {
	for (var i=0; i<result.length; i += 2) {
		if (!editing[result[i]]) {
			setEditData(result[i], result[i+1]);
			exibeCampo(result[i], result[i+1]);		
		}
	}
}
function updateProgressMeter(uploadInfo, i) {
	var normalized = uploadInfo['bytes_uploaded'] / uploadInfo['bytes_total'];
	var percent = Math.ceil(100 * normalized);
	if (percent) {
		document.getElementById('js-percent' + i).innerHTML = percent + '%';
		document.getElementById('js-statusBar' + i).style.width = originalWidth*normalized + 'px';
	}	
}
// fim do ajax

// restauracao de arquivos pendentes
function restoreForm (id, tipo, arquivo, thumbnail) {
	selecionaTipo(tipo);
	arquivoId = id;
	setRequestUri(id);
	show('js-desc');
	for (var i=0; i < arquivo.length; i++) {
		document.getElementById('js-statusBar' + i).className = "statusBar statusBarGo";
		document.getElementById('js-statusBar' + i).style.width = originalWidth + 'px';
		document.getElementById('js-percent' + i).innerHTML = '100%';
	}
	if (thumbnail) {
		document.getElementById('ajax-thumbnail').src = 'repo/' + thumbnail;
	} else {
		document.getElementById('ajax-thumbnail').src = 'styles/bolha/img/iThumb' + tipo + '.png';
	}
	document.thumbForm.arquivoId.value = arquivoId;
	//xajax_restoreEdit();
}