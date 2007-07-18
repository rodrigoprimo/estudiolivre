var thumbId = null;
var thumbTimeout = false;

function thumbSelected() {
    thumbId = document.thumbForm.UPLOAD_IDENTIFIER.value;
    document.thumbForm.submit();
    startThumbProgress();
}

function startThumbProgress() {
	document.getElementById("ajax-thumbnail").src = "styles/bolha/img/iProgress.gif";
	document.getElementById('js-thumbStatus').innerHTML = '0%';
	updateThumbInfo();
}

function updateThumbInfo() {
	xajax_upload_info(thumbId, 0, 'updateThumbProgressMeter');
	thumbTimeout = setTimeout('updateThumbInfo()',1000);
}

function updateThumbProgressMeter(uploadInfo, i) {
    var normalized = uploadInfo['bytes_uploaded'] / uploadInfo['bytes_total'];
    var percent = Math.ceil(100 * normalized);
    if (percent) {
		document.getElementById('js-thumbStatus').innerHTML = percent + '%';	
    }
}

function finishUpThumb() {
	if (thumbTimeout) {
		clearTimeout(thumbTimeout);
		hide('js-thumbForm');
	}
}
