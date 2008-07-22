/**
 *@class:			Array object prototypes
 *@author:			Michael Bianco, http://mabwebdesign.com/
 *@description:		prototypes to make working with arrays easier
 *@version:			1.0
 **/


/**
 *@desciption, recursively makes a copy of the array
 *@returns: the new copy of the array
 **/
Array.prototype.copy = function() {
	var newCopy = [];
	for(var a = 0; a < this.length; a++)
		if(this[a] instanceof Array) newCopy.push(this[a].copy())
		else newCopy.push(this[a])
	return newCopy;
}

/**
 *@descrip: swaps two array indexes
 *@param: a, first index of the array element that will be replaced with b
 *@param: b, second index of the array element that will be replaced by a
 *@returns: the array on success, false if the indexes are out of the arrays bounds
 **/
Array.prototype.swap = function(a:Number, b:Number) {
	if(a>=this.length || b>=this.length) return false; //if the index is out of bounds
	var temp = this[a];
	this[a] = this[b];
	this[b] = temp;
	return this;
}

/**
 *@description: returns the last element in a array
 *@returns: the last element in the array
 **/
Array.prototype.last = function():Object {
    return this[this.length-1];
}

Array.prototype.contains = function(ob:Object, compareFunct:Function) {
	if(this.length == 0) return false; //cause there is no objects to compare to!
	
	if(compareFunct) {
		for(var l = this.length; l-- > 0;) {
			if(compareFunct.call(ob, this[l])) {
				return l;
			}
		}
	} else {
		for(var l = this.length; l-- > 0;) {
			if(this[l] == ob) {
				return l;
			}
		}
	}
	
	return false;
}

Array.prototype.remove = function(ob) {
	var index = this.contains(ob);
	
	if(index === false) {
		return false;
	}
	
	this.splice(index, 1);
}
