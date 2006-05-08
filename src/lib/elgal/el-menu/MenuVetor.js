function MenuVetor(x, y) {
	this.x = x;
	this.y = y;
}

function MenuVetorSoma(v) {
    this.x += v.getX();
    this.y += v.getY();
}

function MenuVetorResize(r) {
    this.x *= r;
    this.y *= r;
}

function MenuVetorModulo() {
    return Math.sqrt(Math.pow(this.x,2) + Math.pow(this.y,2));
}

function MenuVetorUnidade() {
    if (this.modulo() != 0) {
	this.resize(1/this.modulo());
    }
    return this;
}

function MenuVetorGetX() {
    return parseFloat(this.x);
}

function MenuVetorGetY() {
    return parseFloat(this.y);
}

MenuVetor.prototype.unidade = MenuVetorUnidade;
MenuVetor.prototype.soma = MenuVetorSoma;
MenuVetor.prototype.resize = MenuVetorResize;
MenuVetor.prototype.modulo = MenuVetorModulo;
MenuVetor.prototype.getX = MenuVetorGetX;
MenuVetor.prototype.getY = MenuVetorGetY;
