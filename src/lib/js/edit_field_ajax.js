var saveFieldCache = new Array();
var display = new Array();
var mudado = new Array();
var thumbTimerId = null;
var thumbUpId;
var upThumbStarted = false;


function saveField(fieldObj){
    var field = fieldObj.id.replace(/^input-/,'');
    var value;
    if(fieldObj.type == "checkbox") {
    	value = (fieldObj.checked ? 1 : 0);
    } else {
	    value = fieldObj.value;
    }
    
    if (saveFieldCache[field] == null || saveFieldCache[field] != value) {
		//precisa ser implementada em cada caso que for editar campos em ajax
		call_save_function(field, value);
		saveFieldCache[field] = value;
		startEdit();
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
		var editElement = document.getElementById("input-" + field);
		editElement.style.display = "none";
    }
	editElement = document.getElementById("input-" + field).value = '';
	hide('error-' + field);
	eval('errorMsg_' + field + ' = "";');
}

function showEdit(field) {
    document.getElementById("show-"  + field).style.display = "none";
    document.getElementById("input-" + field).style.display = display[field];	
}

function editaCampo(field) {
	showEdit(field);
    document.getElementById("input-" + field).focus();
}

function restoreField(field, value) {
	document.getElementById("input-" + field).value = value;
	showEdit(field);
	startEdit();
}

function exibeErro(campo, msg) {
	eval('errorMsg_' + campo + ' = msg;');
	document.getElementById('error-' + campo).style.display = 'inline';
}

function finishEdit() {
	hide('save-exit');
}

function startEdit() {
	show('save-exit');
}

function cancelEdit() {
	saveFieldCache = new Array();
	xajax_rollback_arquivo(arquivoId);
	return true;
}

function restoreEdit() {
	xajax_restore_edit(arquivoId);
}

//TODO abstrair as funcoes de thumb pra outro js, ja que sao usadas no upload e no user...
function changeThumbStatus() {
    thumbUpId = document.thumbForm.UPLOAD_IDENTIFIER.value;
    document.thumbForm.submit();
    updateThumbUpInfo();
}

function updateThumbUpInfo() {
	if (!upThumbStarted) {
		upThumbStarted = true;
		show('gUserThumbStatus');
		hide('gUserThumbFormContainer');
		document.getElementById('gUserThumbStatus').innerHTML = '0%';
	}
	xajax_upload_info(thumbUpId, 'updateThumbProgressMeter');
	thumbTimerId = setTimeout('updateThumbUpInfo()',1000);
}

function finishUpThumb() {
	if (thumbTimerId) {
		clearTimeout(thumbTimerId);
		upThumbStarted = false;
		show('gUserThumbFormContainer');
		hide('gUserThumbStatus');	
	}
}

function updateThumbProgressMeter(uploadInfo) {
    var normalized = uploadInfo['bytes_uploaded'] / uploadInfo['bytes_total'];
    var percent = Math.ceil(100 * normalized);
    if (percent) {
		document.getElementById('gUserThumbStatus').innerHTML = percent + '%';	
    }	
}
