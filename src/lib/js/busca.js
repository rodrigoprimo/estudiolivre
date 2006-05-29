var selectedBusca = getCookie('busca');
if (!selectedBusca) {
	selectedBusca = 'wiki';
}

function marcaBusca(name) {
    if (selectedBusca == 'wiki' || selectedBusca == 'acervo' || selectedBusca == 'forum') { 
		document.getElementById('busca-'+selectedBusca).className = '';
	}
	selectedBusca = name;
	setCookie('busca',selectedBusca);
	document.getElementById('busca-'+name).className = 'selected';	
	if (selectedBusca == 'wiki' || selectedBusca == 'forum') {
		document.getElementById('form-busca').action = 'tiki-searchresults.php';
	} else {
		document.getElementById('form-busca').action = 'el-gallery_home.php';
	}
}