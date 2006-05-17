var timerId = null;
var uploadId;
var uploadStarted = false;
var originalWidth;

function upload(id) {
	uploadId = id;
		
	updateUploadInfo();
	document.uploadForm.submit();
}

function updateUploadInfo() {
	if(!uploadStarted) {
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
	if(timerId) {
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
}