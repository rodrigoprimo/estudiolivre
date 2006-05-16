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
		document.getElementById('gUpStatusBar').className = "gUpStatus gUpUploadingInside";
		originalWidth = document.getElementById('gUpStatusBar').style.width.replace(new RegExp(/px/), '');	
	}
	xajax_upload_info(uploadId);
	timerId = setTimeout('updateUploadInfo()',1000);
}

function finishUpload() {
	if(timerId) {
		clearTimeout(timerId);
		document.getElementById('gUpStatusBar').className = "gUpListItemFieldCompleteInside gUpEditing";
		document.getElementById('gUpContent').innerHTML = '100%';
		alert("fim");
	}
}

function updateProgressMeter(uploadInfo) {
	var percent = Math.ceil(100 * uploadInfo['bytes_uploaded'] / uploadInfo['bytes_total']);
	if (percent != 'NaN') {
		document.getElementById('gUpContent').innerHTML = percent + '%';
		document.getElementById('gUpStatusBar').style.width = percent;
	}	
}

function changeStatus(value) {
	document.getElementById('gUpContent').innerHTML = value;
}