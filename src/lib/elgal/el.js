var selected = null;
var thumbUp = true;

function showLicence(id) {
    if(selected != null) {
        document.getElementById(selected).style.display = "none";
    }
    document.getElementById(id).style.display = "block";
    selected = id;
}

var selecionado = 1;

function hab(){

        if(selecionado>2)
                document.getElementById('_submit').disabled = false
}

function s(a){
        if(a!='0')
                selecionado++
        else
                selecionado--
}
setInterval('hab()',100)

function toggleThumbUp() {
    if(thumbUp) {
	document.getElementById("thumbup").style.display = "none";
	thumbUp = false;
    } else {
	document.getElementById("thumbup").style.display = "table-row";
	thumbUp = true;
    }
}
