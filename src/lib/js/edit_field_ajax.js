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
		call_save_function(field, value);
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
