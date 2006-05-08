/*
 * Class gallery
 */

function ElGallery(storage,tipo,order) {
    this.tipo = tipo;
    this.strg = storage;

    this.containerId = 'el-gallery-'+tipo;

    this.tab = new ElTab(tipo,
			 false,
			 '<div id="'+this.containerId+'"></div>',
			 order,
			 false);

    this.tab.onFocus = function() { renderer.update() };

    this.STATE_SYNCHRONIZED = 0;
    this.STATE_MODIFIED = 1;

    this.notify();
}

function elGallery_render() {
    if (this.isModified()) {
	var content = '';
	var it = this.strg.getAll(this.tipo);
	
	if (it) {
	    var each;
	    while (each = it.getNext()) {
		content += each['html'];
	    }
	}
	
	document.getElementById(this.containerId).innerHTML = content;
    }

    this.sync();
}

function elGallery_onLoad() {
    this.notify();
}

function elGallery_getDataSections() {
    return new Array(this.tipo);
}

function elGallery_isModified() {
    return this.state == this.STATE_MODIFIED;
}

function elGallery_notify() { this.state = this.STATE_MODIFIED; }

function elGallery_sync()   { this.state = this.STATE_SYNCHRONIZED; }


ElGallery.prototype.render = elGallery_render;
ElGallery.prototype.onLoad = elGallery_onLoad;
ElGallery.prototype.getDataSections = elGallery_getDataSections;
ElGallery.prototype.isModified = elGallery_isModified;
ElGallery.prototype.notify = elGallery_notify;
ElGallery.prototype.sync = elGallery_sync;
