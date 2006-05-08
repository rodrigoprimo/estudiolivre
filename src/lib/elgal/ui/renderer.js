/*
 * Class renderer
 */

function ElRenderer() {

    this.ctrl = new Array();
    this.listeners = new Array();
    this.views = new Array();

    this.STATE_SYNCHRONIZED = 0;
    this.STATE_MODIFIED = 1;

    this.state = this.STATE_MODIFIED;

}

function elRenderer_notify() {
    this.state = this.STATE_MODIFIED;
}

function elRenderer_addController(controller) {
    this.ctrl[this.ctrl.length] = controller;
    this.addListener(controller);
}

function elRenderer_addView(view) {
    this.views[this.views.length] = view;
}

function elRenderer_addListener(listener) {
    this.listeners[this.listeners.length] = listener;
}

function elRenderer_onLoad() {
    this.render();
}

function elRenderer_getDataSections() {
    return null;
}

function elRenderer_update() {
    if (this.state != this.STATE_SYNCHRONIZED) {
	nd();
	
	for(var i=0; i<this.views.length; i++) {
	    this.views[i].render();
	}
	
	for (var i=0; i<this.listeners.length; i++) {
	    this.listeners[i].onUpdate();
	}

	this.state = this.STATE_SYNCHRONIZED;

    }
}

function elRenderer_render() {
    for (var i=0; i<this.ctrl.length; i++) {
	this.ctrl[i].render();
    }

    for (var i=0; i<this.listeners.length; i++) {
	this.listeners[i].onRender();
    }

    this.notify();
    this.update();
}

ElRenderer.prototype.render = elRenderer_render;
ElRenderer.prototype.update = elRenderer_update;
ElRenderer.prototype.onLoad = elRenderer_onLoad;
ElRenderer.prototype.getDataSections = elRenderer_getDataSections;
ElRenderer.prototype.addView = elRenderer_addView;
ElRenderer.prototype.addListener = elRenderer_addListener;
ElRenderer.prototype.addController = elRenderer_addController;
ElRenderer.prototype.notify = elRenderer_notify;
