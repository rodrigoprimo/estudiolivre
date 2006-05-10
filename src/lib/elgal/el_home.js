var status = new Array('Act', 'Act', 'Act', 'Inac');
var tipos = new Array('Audio', 'Video', 'Imagem')

function arrayContains(obj) {
	for(var i = 0; i < this.length; i++)
		if(this[i] == obj) return i;
	return false;
}

function arrayRemove(obj) {
	var i = this.contains(obj);
	if(i)
		this[i] = this.pop();
}

function arrayAdd(obj) {
	if(!this.contains(obj)) this.push(obj);
}

Array.prototype.contains = arrayContains;
Array.prototype.remove = arrayRemove;
Array.prototype.add = arrayAdd;

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
	
	xajax_get_files(tipos, 0, 5, 'data_publicacao_desc', '', '');
	//el_get_files(tipos, 0, 5, 'data_publicacao_desc','','');
	
}