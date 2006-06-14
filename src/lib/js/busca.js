var selectedBusca = getCookie('busca');

if (!selectedBusca) {
	selectedBusca = 'wiki';
}

function marcaBusca(name) {
    if (selectedBusca == 'wiki' || selectedBusca == 'gallery' || selectedBusca == 'forum') { 
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

function busca(category, value) {
	if (category == 'gallery' && selectedBusca == 'gallery') {
		xajax_get_files(tipos, 0, 5, sortMode+sortDirection, '', value); 
		findValue = value; 
	} else {
		document.searchForm.submit();
	}
}

function limpaBusca(input) {
	if (input.value == "Buscar") {
		input.value = "";
	}
}
