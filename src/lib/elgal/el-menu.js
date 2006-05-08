var itens = new Array();

itens[0] = new MenuItem('oqeh');
itens[1] = new MenuItem('conversando');
itens[2] = new MenuItem('pessoas');
itens[3] = new MenuItem('faq');

var balancer = new Balancer(itens);

var IE = document.all?true:false;

if (!IE) document.captureEvents(Event.MOUSEMOVE);

document.onmousemove = getMouseXY;

var mouseX = 0;
var mouseY = 0;

function getMouseXY(e) {
    if (IE) { 
	mouseX = event.clientX + document.body.scrollLeft;
	mouseY = event.clientY + document.body.scrollTop;
    } else {  
	mouseX = e.pageX;
	mouseY = e.pageY;
    }  
    
    return true;
}
