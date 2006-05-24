var status = new Array('Inac','Inac','Inac','Inac');
var tipos = new Array();
var acervo_cache = new Array();
var sortMode = 'data_publicacao';
var sortDirection = '_desc'

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

function initButtons() {
	
	var hasCookie = false;
	var localTipos = new Array('Audio', 'Imagem', 'Video', 'Texto');
	
	for(var i = 0; i < localTipos.length; i++) {
		if(getCookie(localTipos[i])) {
			if(getCookie(localTipos[i]) == '1') {
				setButton(document.getElementById('listFilterBut'+i), i, localTipos[i]);
			}
			hasCookie = true;
		}
	}
	if(!hasCookie) {
		for(var i = 0; i < localTipos.length; i++) {
			setButton(document.getElementById('listFilterBut'+i), i, localTipos[i]);
		}
	}
	
	if(getCookie('sortMode')) {
		sortMode = getCookie('sortMode');
	}
	if(getCookie('sortDirection')) {
		sortDirection = getCookie('sortDirection');
	}
	
	xajax_get_files(tipos, 0, 5, sortMode+sortDirection, '');
	
}

function acervoCache(tipos,offet, maxRecords, sort_mode, find, filters) {
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
	
	setButton(button, position, tipo);
	
	xajax_get_files(tipos, 0, 5, sortMode+sortDirection);
	//el_get_files(tipos, 0, 5, 'data_publicacao_desc','', new Array());
	
}

function setButton(button, position, tipo) {
	var stat;
	if(button.className == 'buttonActive') {
		button.className = 'buttonInactive';
		stat = 'Inac';
		tipos.remove(tipo);
		setCookie(tipo, 0);
	} else {
		button.className = 'buttonActive';
		stat = 'Act';
		tipos.add(tipo);
		setCookie(tipo, 1);
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
}


function toggleSortArrow(img, alternate) {

	img.toggleImage(alternate);

	/*TODO: esse tro?o tb pode ser refatorado -> interface de cookies do estudiolivre! */
	if (sortDirection == '_desc') {
		sortDirection = '_asc';
	} else {
		sortDirection = '_desc';
	}
	setCookie('sortDirection', sortDirection);
	xajax_get_files(tipos, 0, 5, sortMode+sortDirection);
}

function setSortMode(sel) {
	sortMode = sel.value;
	setCookie('sortMode', sortMode);
	xajax_get_files(tipos, 0, 5, sortMode+sortDirection);
}
