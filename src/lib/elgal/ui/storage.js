function elStorageResponse(result) {
    strg.onLoad(result);
}

/*
 * Class storage
 */

function ElStorage(file) {
    this.file = file;

    this.strg = new Array();
    this.indx = new Array();
    this.listeners = new Array();

    this.cp = new cpaint();
    
    this.cp.set_debug(0);
    this.cp.set_use_cpaint_api(true);
    this.cp.set_persistent_connection(false);

    this.sect = new Array();

    // section name => new Array(index keys)

    this.sect['Audio'] = new Array('arquivoId','html');
    this.sect['Video'] = new Array('arquivoId','html');
    this.sect['Imagem'] = new Array('arquivoId','html');
    this.sect['Texto'] = new Array('arquivoId','html');

    this.sections = new Array('Audio','Video','Imagem','Texto');

    this.listIndex = new Array; // listeners index
    for (var i=0; i<this.sections.length; i++) {
	this.listIndex[this.sections[i]] = new Array();
    }

    /*
    this.prototype.getPosition = elStorage_getPosition;
    this.prototype.getById = elStorage_getById;
    this.prototype.getBy = elStorage_getBy;
    */
}

function elStorage_load(sect, params) {

    document.getElementById('elLoading').style.display = 'block';
    this.cp.call(this.file,'get' + sect, elStorageResponse, params);

}

function elStorage_loadAll() {
    for (var i=0; i<this.sections.length; i++) {
	this.load(this.sections[i], false);
    }
}

function elStorage_onLoad(result) {

    for (var key in this.sect) {
	var content = this._extractArray(result, key, this.sect[key]);
	if (content) {
	    this.store(key, content);

	    for (var i=0; i < this.listIndex[key].length; i++) {
		var listener = this.listIndex[key][i];
		listener.onLoad();
	    }
	}
    }

    /*   
    var sections = this.loader.xml.getElementsByTagName('section');

    for (var i=0; i<sections.length; i++) {
	var section = sections[i];
	for (var j=0; j<section.attributes.length; j++) {
	    var att = section.attributes[j];
	    if (att.nodeName == 'name' && this.sect[att.nodeValue]) {
		this.store(att.nodeValue, section.childNodes);
	    }
	}
    }
    */

    document.getElementById('elLoading').style.display = 'none';
}

function elStorage__extractArray(result, name, fields) {

    var objects = result.ajaxResponse[0][name];

    if (!objects) { return false }

    var jslist = new Array();

    for (var i=0; i < objects.length; i++) {

	jslist[i] = new Array();

	for (var j=0; j < fields.length; j++) {
	    var field = fields[j];

	    jslist[i][field] = objects[i][field][0].data;
	}
    }

    return jslist;
}    

function elStorage_addListener(listener) {
    this.listeners[this.listeners.length] = listener;

    var keys = listener.getDataSections();

    if (keys == null) {
	keys = this.sections;
    }
    for (var i=0; i<keys.length; i++) {
	this.listIndex[keys[i]][ this.listIndex[keys[i]].length ] = listener;
    }
}

// recebe um elemento e um array com os campos a indexar 
// (para poderem ser usados com getById e getByField)
function elStorage_store(key, value) {

    /*
    var res = new Array();
    var ind = new Array();

    var indexes = this.sect[key];
    
    if (!indexes) {
	indexes = new Array();
    }

    if (indexes[0]) {
	ind['_pkey'] = indexes[0];
    }
    
    for (var i=0; i<indexes.length; i++) {
	ind[indexes[i]] = new Array();
    }

    var i=0;
    for (var j=0; j<tag.length; j++) {

	if (tag[j].nodeType == 1) {
	    res[i] = new Array();

	    for (var k=0; k<tag[j].childNodes.length; k++) {
		var node = tag[j].childNodes[k];
		if (node.nodeType == 1 && node.childNodes.length > 0) {
		    var fieldName = node.nodeName;
		    var fieldValue = node.childNodes[0].nodeValue;
		    
		    for (var l=0; l<indexes.length; l++) {
			if (indexes[l] == fieldName) {
			    ind[fieldName][fieldValue] = i;
			    break;
			}
		    }
		    
		    res[i][fieldName] = fieldValue;
		}
	    }

	    i++;
	}

    } 
    */
    this.strg[key] = value;
    //this.indx[key] = ind;
    this.sort[key] = false; // ordem
}

function elStorage_remove(key) {
    this.strg[key] = false;
    this.indx[key] = false;
    this.sort[key] = false;
}

function elStorage_sort(key, field, title) {
    var data = this.strg[key];
    if (this.sort[key] && this.sort[key]['field'] == field) {
	mul = this.sort[key]['mul'] * -1;
    } else {
	mul = 1;
    }

    this.strg[key] = data.sort(
			       function (a,b) {
				   if (a[field] > b[field]) {
				       return mul;
				   } else if (a[field] < b[field]) {
				       return -mul;
				   }
				   return 0;
			       });

    this.sort[key] = new Array();
    this.sort[key]['field'] = field;
    this.sort[key]['mul'] = mul;
    this.sort[key]['title'] = title;
}

function elStorage_exists(key) {
    return this.strg[key] && this.strg[key].length > 0;
}

function elStorage_getAt(key, i) {
    return this.strg[key][i];
}

function elStorage_getAll(key) {
    if (!this.strg[key]) return false;

    return new ElIterator(this.strg[key]);
}

/*
function elStorage_getPosition(key, id) {
    if (this.indx[key][ this.indx[key]['_pkey'] ]) {
	return this.indx[key][ this.indx[key]['_pkey'] ][id];
    } else {
	alert(id);
	crip();
    }
}

function elStorage_getById(key, id) {
    return this.strg[key][  this.getPosition(key, id)  ]
}

function elStorage_getBy(key, field, value) {
    return this.strg[key][ this.indx[key][field][value]  ];
}
*/

function elStorage_getLength(key) { return this.strg[key].length; }
function elStorage_getOrder(key) { return this.sort[key] }

ElStorage.prototype.load = elStorage_load;
ElStorage.prototype.loadAll = elStorage_loadAll;
ElStorage.prototype.onLoad = elStorage_onLoad;
ElStorage.prototype.addListener = elStorage_addListener;
ElStorage.prototype.store = elStorage_store;
ElStorage.prototype.remove = elStorage_remove;
ElStorage.prototype.sort = elStorage_sort;
ElStorage.prototype.exists = elStorage_exists;
ElStorage.prototype.getAt = elStorage_getAt;
ElStorage.prototype.getAll = elStorage_getAll;
ElStorage.prototype.getLength = elStorage_getLength;
ElStorage.prototype.getOrder = elStorage_getOrder;
ElStorage.prototype._extractArray = elStorage__extractArray;

