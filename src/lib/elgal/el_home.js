function toggleFilter(button, position) {
	var stat;
	if(button.className == 'buttonActive') {
		button.className = 'buttonInactive';
		stat = 'Inac';
	} else {
		button.className = 'buttonActive';
		stat = 'Act';	
	}	
	switch(position) {
		case 1:
			document.getElementById('listFilterImg0').src = 'styles/estudiolivre/bLeft'+stat+'.png';
			if(document.getElementById('listFilterBut1').className == 'buttonActive')
				document.getElementById('listFilterImg1').src = 'styles/estudiolivre/b'+stat+'2Act.png';
			else
				document.getElementById('listFilterImg1').src = 'styles/estudiolivre/b'+stat+'2Inac.png';
			break;
		case 4:
			document.getElementById('listFilterImg4').src = 'styles/estudiolivre/bRight'+stat+'.png';
			if(document.getElementById('listFilterBut2').className == 'buttonActive')
				document.getElementById('listFilterImg3').src = 'styles/estudiolivre/bAct2'+stat+'.png';
			else
				document.getElementById('listFilterImg3').src = 'styles/estudiolivre/bInac2'+stat+'.png';
			break;
		default:
			var prevPrev = position-2;
			var prev = position-1;
			if(document.getElementById('listFilterBut'+prevPrev).className == 'buttonActive')
				document.getElementById('listFilterImg'+prev).src = 'styles/estudiolivre/bAct2'+stat+'.png';
			else
				document.getElementById('listFilterImg'+prev).src = 'styles/estudiolivre/bInac2'+stat+'.png';
			if(document.getElementById('listFilterBut'+position).className == 'buttonActive')
				document.getElementById('listFilterImg'+position).src = 'styles/estudiolivre/b'+stat+'2Act.png';
			else
				document.getElementById('listFilterImg'+position).src = 'styles/estudiolivre/b'+stat+'2Inac.png';
			break;
	}
	
}