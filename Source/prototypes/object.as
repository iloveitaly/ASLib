/*
 Class: Object
 
 Description:
 Additional methods to the Object root class to allow some additional functionality to AS.
 
 Usage:
 sinclude into your project for easy use. You can add the function prototypes to your core class files to avoid compile errors.
 
 Notes:
 **notes**
 
 Version:
 1.1
 
 Author:
 Michael Bianco, http://developer.mabwebdesign.com/
 */

/*
 Function: initBroadcaster
 Inits the object as a EventDispatcher object, if it already hasn't been inited
 */

Object.prototype.initBroadcaster = function():Void {
	if(!this.__initedBroadcaster) {
		mx.events.EventDispatcher.initialize(this);
		this.__initedBroadcaster = true;
	}
}

/*
 Function: isInstanceOf
 
 Description:
 Tests whether the object is a member of the param classref
 *@param: classRef, a reference to a class object. IE Number
 *@returns: bool, representing if the object belongs to the specified class or not
 */
Object.prototype.isInstanceOf = function(classRef):Boolean {
	if(this.__proto__ == classRef.prototype) {
		return true;
	} else {
		return false;
	}
}

/**
 *@description: tests whether the object is a descendant/member of the param classref
 *@param: classRef, a reference to a class object. IE Number
 *@returns: bool, representing if the object belongs or descends from the specified class or not
 **/
Object.prototype.isMemberOf = function(classRef):Boolean {
	if(classRef == Object) {//always a descendant of an object!
		return true;
	}
	
	var ref = this.__proto__;

	while(ref != classRef.prototype) {
		if(ref == Object.prototype) {
			return false;
		}
		
		ref = ref.__proto__;
	}
	
	return true;
}

/*
Function: centerX

Description:
Centers the object horizontally depending on the given max x value

Parameters: 
xval - [Number] The max x position that the mc could be
*/
Object.prototype.centerX = function(xval:Number):Void {
	this._x = Math.round((xval-this._width)/2);
}

/**
 *@description: centers the object vertically depending on the given max y value
 *@param: yval, the max y position that the mc could be
 **/
Object.prototype.centerY = function(yval:Number):Void {
	this._y = Math.round((yval - this._height)/2);
}

/**
 *@description: centers the object vertically and horizontally depending on the given max x and y value's
 *@param: yval, the max y position that the mc could be
 *@param: xval, the max x position that the mc could be
 **/
Object.prototype.centerXY = function(x:Number, y:Number):Void {
	this.centerX(x);
	this.centerY(y);
}

ASSetPropFlags(Object.prototype, null, 1);
