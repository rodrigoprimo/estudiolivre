/*
 * class Iterator
 */

function ElIterator(ar) {
    this.ar = ar;
    this.i = 0;
    if (ar) {
	this.length = ar.length;
    } else {
	alert('bug');
    }

}

function elIterator_reverse() {
    var r = new Array();
    for (var i=0; i<this.ar.length; i++) {
	r[i] = this.ar[this.ar.length-1-i];
    }
    
    return new ElIterator(r);
}

function elIterator_getNext() {
    return this.ar[this.i++];
}

function elIterator_reset() {
    this.i=0;
}

function elIterator_getPosition() {
    return this.i;
}

ElIterator.prototype.reverse = elIterator_reverse;
ElIterator.prototype.getNext = elIterator_getNext;
ElIterator.prototype.reset = elIterator_reset;
ElIterator.prototype.getPosition = elIterator_getPosition;
