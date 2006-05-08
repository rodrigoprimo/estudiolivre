function MenuMola(x, y, e) {
    this.posicao = new MenuVetor(x,y);
    this.elasticidade = e;
}

function MenuMolaAplicaForca(xum, yum) {
    var x = this.posicao.getX() - xum;
    var y = this.posicao.getY() - yum;
    
    var forca = new MenuVetor(x, y);

    var modulo = forca.modulo();

    forca = forca.unidade();

    forca.resize(0.5 * this.elasticidade * Math.pow(modulo,2));

    return forca;
}

MenuMola.prototype.aplicaForca = MenuMolaAplicaForca;
