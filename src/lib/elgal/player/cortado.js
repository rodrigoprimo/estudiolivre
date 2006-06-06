var playerVideo = document.applets[0];
var playerAudio = document.applets[1];

function loadFile(player, url, width, height, type) {
	document.getElementById('gCortadoCont'+type).style.width = width + 'px';
	document.getElementById('gCortadoCont'+type).style.height = height + 'px';
	player.height = height;
	player.width = width;
	showLightbox('gCortadoCont'+type);
	player.childNodes[1].value = url;
}