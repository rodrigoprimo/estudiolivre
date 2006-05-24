var saveFieldCache = new Array();
var display = new Array();
var mudado = new Array();

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
