var player = document.applets[0];

function loadFile(url, width, height, video) {
	document.getElementById('gPlayer').style.width = width + 'px';
	document.getElementById('gPlayer').style.height = height + 'px';
	player.height = height;
	player.width = width;
	showLightbox('gPlayer');
	player.childNodes[1].value = url;
	player.childNodes[2].value = video;
}