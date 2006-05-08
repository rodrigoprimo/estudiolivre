function acervoVota(arquivoId, nota) {
    var img_src = 'styles/estudiolivre/rt_'+nota+'.png';
    var blk_src = 'styles/estudiolivre/rt_blk.png';
    
    var src;

    for (var i=1; i<=5; i++) {
	if (i <= nota) {
	    src = img_src;
	} else {
	    src = blk_src;
	}
	document.getElementById('rt-'+arquivoId+'-'+i).src = src;
    }

    xajax_vota(arquivoId, nota);
}

function acervoConfirmaVoto(result) {
    var avg = result.ajaxResponse[0]['rating'][0].data;
    var arquivoId = result.ajaxResponse[0]['arquivoId'][0].data;

    avg = Math.round(avg);

    document.getElementById('rt-'+arquivoId).innerHTML = avg;
    document.getElementById('rtimg-'+arquivoId).src = 'styles/estudiolivre/rt_'+avg+'.png';
}
