function Balancer(itens) {
    this.itens = itens;
    this.balancing = false;
}

function BalancerStart() {
    if(!this.balancing) {
	this.balancing = true;
	this.run = setTimeout('balancer.balance()', 100);
    }
}

function BalancerStop() {
    this.balancing = false;
}

function BalancerBalance() {
    if(this.balancing){
	var needsBalancing = false;
	for(var i = 0; i < this.itens.length; i++) {
	    if (this.itens[i].move()) {
		needsBalancing = true;
	    }
	}
	if(needsBalancing) {
	    this.run = setTimeout('balancer.balance()', 100);
	}
	else {
	    balancer.stop();
	}
    }
}


Balancer.prototype.start = BalancerStart;
Balancer.prototype.stop = BalancerStop;
Balancer.prototype.balance = BalancerBalance;
