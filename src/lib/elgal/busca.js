var selectedBusca = getCookie('busca');
if (!selectedBusca) {
	selectedBusca = 'wiki';
}

function marcaBusca(name) {
    if (selectedBusca == 'wiki' || selectedBusca == 'acervo') {
		document.getElementById('busca-'+selectedBusca).className = '';
	} 
	selectedBusca = name;
	setCookie('busca',selectedBusca);
	document.getElementById('busca-'+name).className = 'selected';	
}