xajax.realCall = xajax.call;
xajax.call = function(sFunction, aArgs, sRequestType) {
    document.getElementById('elLoading').style.display = 'block';
    return this.realCall(sFunction, aArgs, sRequestType);
}

var acervo_cache = new Array();
function acervoCache(tipo, offset, maxRecords, sort_mode, find, filters) {
    acervo_cache[tipo+offset+maxRecords+sort_mode+find+filters] = document.getElementById('content-'+tipo).innerHTML;
}

function el_get_files(tipo, offset, maxRecords, sort_mode, find, filters) {
    if(acervo_cache[tipo+offset+maxRecords+sort_mode+find+filters]) {
	document.getElementById('content-'+tipo).innerHTML = acervo_cache[tipo+offset+maxRecords+sort_mode+find+filters];
    }
    else {
	xajax_get_files(tipo, offset, maxRecords, sort_mode, find, filters);
    }
}

audio = new ElTab('Audio');
video = new ElTab('Video');
imagem = new ElTab('Imagem');
texto = new ElTab('Texto');

var tab = getCookie('el-tab');
if (!tab) tab = 'Audio';

elTabs[tab].focus();
