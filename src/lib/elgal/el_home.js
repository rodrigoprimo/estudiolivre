var status = new Array('Act', 'Act', 'Act', 'Inac');
var tipos = new Array('Audio', 'Video', 'Imagem')
var acervo_cache = new Array();

function arrayContains(obj) {
	for(var i = 0; i < this.length; i++)
		if(this[i] == obj) return i;
	return -1;
}

function arrayRemove(obj) {
	var i = this.contains(obj);
	if(i >= 0)
		this.splice(i,1);
}

function arrayAdd(obj) {
	if(this.contains(obj) < 0) this.push(obj);
}

Array.prototype.contains = arrayContains;
Array.prototype.remove = arrayRemove;
Array.prototype.add = arrayAdd;

function acervoCache(tipos, offset, maxRecords, sort_mode, find, filters) {
    acervo_cache[tipos+offset+maxRecords+sort_mode+find+filters] = document.getElementById('gListCont').innerHTML;
}

function el_get_files(tipos, offset, maxRecords, sort_mode, find, filters) {
    if(acervo_cache[tipos+offset+maxRecords+sort_mode+find+filters]) {
		document.getElementById('gListCont').innerHTML = acervo_cache[tipos+offset+maxRecords+sort_mode+find+filters];
    }
    else {
		xajax_get_files(tipos, offset, maxRecords, sort_mode, find, filters);
    }
}

function toggleFilter(button, position, tipo) {
	var stat;
	if(button.className == 'buttonActive') {
		button.className = 'buttonInactive';
		stat = 'Inac';
		tipos.remove(tipo);
	} else {
		button.className = 'buttonActive';
		stat = 'Act';
		tipos.add(tipo);
	}
	status[position] = stat;
	switch(position) {
		case 0:
			document.getElementById('listFilterImg0').src = 'styles/estudiolivre/bLeft'+stat+'.png';
			document.getElementById('listFilterImg1').src = 'styles/estudiolivre/b'+stat+'2'+status[1]+'.png';
			break;
		case 3:
			document.getElementById('listFilterImg4').src = 'styles/estudiolivre/bRight'+stat+'.png';
			document.getElementById('listFilterImg3').src = 'styles/estudiolivre/b'+status[2]+'2'+stat+'.png';
			break;
		default:
			var prev = position-1; var next = position+1;
			document.getElementById('listFilterImg'+position).src = 'styles/estudiolivre/b'+status[prev]+'2'+stat+'.png';
			document.getElementById('listFilterImg'+next).src = 'styles/estudiolivre/b'+stat+'2'+status[next]+'.png';
			break;
	}
	
	xajax_get_files(tipos, 0, 5, 'data_publicacao_desc', '');
	//el_get_files(tipos, 0, 5, 'data_publicacao_desc','', new Array());
	
}

xajax_get_files(tipos, 0, 5, 'data_publicacao_desc', '');
