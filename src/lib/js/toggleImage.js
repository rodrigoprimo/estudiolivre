Image.prototype.setAlternatePath = function (image1) {
	var imageName = this.src.replace(new RegExp(/^.*(\/|\\)/), '');
	var path = this.src.replace(imageName, '');
	// we get the new image
	this['image1']=path+image1;
	// and add the one already there
	this['image2']= this.src;
}


Image.prototype.toggleImage = function (alternatePath){
	if(!this.image1) {this.setAlternatePath(alternatePath) }
	
	if(this.src == this.image1){
		this.src=this.image2;
	}else{
		this.src=this.image1;
	}
	this.blur();
	//alert(this.src);
}