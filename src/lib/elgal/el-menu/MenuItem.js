function MenuItem(id) {
	this.id = id;
	this.object = document.getElementById(id);
	this.Ox = parseFloat(this.object.style.left);
	this.Oy = parseFloat(this.object.style.top);
	this.posicao = new MenuVetor(parseFloat(this.object.style.left),
				     parseFloat(this.object.style.top));
	this.raio = 30;
	this.massa = 60;
	this.velocidade = new MenuVetor(0,0);
}

function MenuItemMove() {
    var mx = mouseX - 412;
    var my = mouseY - 6;
    var conectadoMouse;
    var forcaInst = new MenuVetor(0,0);

    if (Math.pow(mx - this.Ox,2) + Math.pow(my - this.Oy,2) > Math.pow(this.raio,2)) {
	conectadoMouse = false;
    } else {
	conectadoMouse = true;
    }

    if (!conectadoMouse && (this.velocidade.x < 0.05 && this.velocidade.x > -0.05) &&
	(this.velocidade.y < 0.05 && this.velocidade.y > -0.05)) {
	return false;
    }

    if (conectadoMouse) {
	var molaMouse = new MenuMola(mx, my, 5);
	var forca = molaMouse.aplicaForca(this.posicao.getX(),
					  this.posicao.getY());
	forcaInst.soma(forca);
    }

    var mola = new MenuMola(this.Ox, this.Oy, 2);
    var forca = mola.aplicaForca(this.posicao.getX(),
				 this.posicao.getY());
    forcaInst.soma(forca);

    // atrito
    var constanteAtrito = 25;
    var atrito = new MenuVetor(this.velocidade.getX(), this.velocidade.getY());
    atrito.resize(-constanteAtrito);
    forcaInst.soma(atrito);
    forcaInst.resize(1.0/this.massa);
    
    if ((forcaInst.x < 0.05 && forcaInst.x > -0.05) && (forcaInst.y < 0.05 && forcaInst.y > -0.05)) {
	return false;
    }
	
    this.velocidade.soma(forcaInst);

    this.posicao.soma(this.velocidade);

    this.object.style.left = this.posicao.getX() + 'px';
    this.object.style.top = this.posicao.getY() + 'px';

    return true;
}

MenuItem.prototype.move = MenuItemMove;
