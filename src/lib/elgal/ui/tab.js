var elTabCounter = 0;
var elTabFocus;
var elTabs = new Array();

// class elTab

function ElTab(label) {
    this.id = label;

    this.STATE_HIDDEN = 0;
    this.STATE_VISIBLE = 1;
    this.STATE_FOCUSED = 2;

    this.state = this.STATE_VISIBLE;

    elTabs[this.id] = this;
}

function elTab_show() {
    var tab = document.getElementById('tab-'+this.id);
    tab.className = 'tabmark';
    tab.style.display = 'inline';

    this.state = this.STATE_VISIBLE;

    this.onShow();
}

function elTab_hide() {
    if (elTabFocus == this.id) {
	for (var i=1; i<elTabs.length; i++) {
	    if (elTabs[i].visible()) {
		elTabs[i].focus();
		break;
	    }
	}
    }
    var tab = document.getElementById('tab-'+this.id);
    tab.style.className = 'tabmark';
    tab.style.display = 'none';

    this.state = this.STATE_HIDDEN;

    this.onHide();
}

function elTab_focus() {
    if (elTabFocus) {
	elTabs[elTabFocus].show(); // coloca estilo certo
	hide('content-'+elTabFocus);
	elTabs[elTabFocus].onBlur();
    }

    var tab = document.getElementById('tab-'+this.id);
    tab.className = 'tabfocused';

    tab.style.display = 'inline';

    show('content-'+this.id);
    
    elTabFocus = this.id;

    setCookie('el-tab', this.id);

    this.state = this.STATE_FOCUSED;

    el_get_files(this.id, 0, 5, 'data_publicacao_desc','','');

    this.onFocus();
}

function elTab_onFocus() { return false; }
function elTab_onBlur()  { return false; }
function elTab_onHide()  { return false; }
function elTab_onShow() {  return false; } 


function elTab_visible() { return this.state != this.STATE_HIDDEN; }
function elTab_focused() { return this.state == this.STATE_FOCUSED; }


ElTab.prototype.show = elTab_show;
ElTab.prototype.hide = elTab_hide;
ElTab.prototype.focus = elTab_focus;
ElTab.prototype.onFocus = elTab_onFocus;
ElTab.prototype.onBlur = elTab_onBlur;
ElTab.prototype.onHide = elTab_onHide;
ElTab.prototype.onShow = elTab_onShow;
ElTab.prototype.visible = elTab_visible;
ElTab.prototype.focused = elTab_focused;
