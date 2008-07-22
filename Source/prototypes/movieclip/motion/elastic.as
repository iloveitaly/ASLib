/**
 *	 @class:		movieClipProtos
 *	@author:		Michael Bianco, http://mabwebdesign.com/
 *	  @date:		11/18/04
 * @version: 		.8
 *@description:		MovieClip prototypes containing usefull function to make animating, and managing MC's easier
 *@requires:		The colorConverter class
 **/

/*
 Function: elasticEase
 
 Description:
 Same as easeTo except it applies a bounce effect to the easing
 
 Arguments:
 p - the property to change
 d - destination value of the property you want to change
 f - represents the friction and the bouncyness value, or if an array is specified the first element in the array represents the bouncyness and the second element represents the friction, if a third element is specified it will represent the velocity
 eventOb - an object that contains the properties to dispatch an event. use {type:"functiontodispatch"}
 del - whether or not to delete the onenterframe action when the easing is complete. Define del as true/1 to delete the onenterframe.
 target - a path to the target properties to be changed. If you do not define this the mc that the function is being used on will be used
 */
MovieClip.prototype.elasticEase = function(p, d, f, eventOb, target) {
	this.__a = 0; //acceleration
	this.__v = 0; //velocity
	this.__bouncyness = f
	this.__friction = f
	this.__prev = undefined; //the previous value of the acceleration
	this.__callBack = eventOb;
	this.__p = p;
	this.__d = d;
	
	if(f instanceof Array) {//if the user specified an array for values
		switch(f.length) {			
			case 3:
			this.__v = f[2];
			case 2:
			this.__friction = f[1];
			case 1:
			this.__bouncyness = f[0];
			break;
		}
	}
	
	if(target) this.__ref = target;
	else this.__ref = this;
	
	this.onEnterFrame = this.elasticEase_funct;
}

/**
 *@description: helper function for elasticEase()
 **/
MovieClip.prototype.elasticEase_funct = function() {
	this.__prev = this.__a;
	this.__a = (this.__d-this.__ref[this.__p])*this.__bouncyness;
	if(this.__prev === this.__a && Math.abs(this.__a)<1) {//if the same acceleration is repeated twice then the function is done
		this.__ref[this.__p] = this.__d; //set the prop == to its destination
		this.onEnterFrame = null;
		//this.__v, this.__friction, this.__bouncyness, this.__p, this.__d, this.__prev, this.__a, this.__v; //same as below dispatch setting
		this.doCallBack()	
	} else {
		this.__v *= this.__friction;
		this.__v += this.__a;
		this.__ref[this.__p] += this.__v;
	}
}
