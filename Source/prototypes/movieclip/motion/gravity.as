/**
 *	 @class:		movieClipProtos
 *	@author:		Michael Bianco, http://mabwebdesign.com/
 *	  @date:		07/31/05
 * @version: 		1.0
 *@description:		MovieClip prototypes containing functions for gravity-like motion
 **/

/**
 *@description: creates a gravity bounce effect on the MC of choice
 *@param: p, the property that you want to change
 *@param: d, destination value of the property you want to change
 *@param: g, an array or a int value. If its an array the values should be as follows:
 *	g[0]: gravity value
 *	g[1]: bounce value, must be less than 1
 *	g[2]: inital speed value
 *@param: callBack, an object that contains the properties to dispatch an event
 *@param: target, a path to the target properties to be changed. If you do not define this the mc that the function is being used on will be used
 **/
MovieClip.prototype.gravityBounce = function(p, d, g, callBack, target) {
	/*higher g the harder the ball will fall.
	gravity = 0 can be set, as an experiment, but 
	it will in fact create a "zero gravity" effect
	gravity < 0 will create an inverted gravity effect*/

	/*Bounce is a number < 1 but close to 1
	The closer to 1, the higher the ball will bounce*/
	
	if(target) this.__ref = target;
	else this.__ref = this;
	
	this.__p = p;
	this.__d = d; //destinatoion or limit
	this.__callBack = callBack;
	this.__s = 0; //speed
	this.__b = .9; //bounce
	
	//if we have an array of values assign them accordingly
	if(g instanceof Array) {
		switch(g.length) {
			case 3:
			this.__s = g[2];
			case 2:
			this.__b = g[1];
			case 1:
			this.__g = g[0];
		}
	} else {
		this.__g = g;
	}
	
	//determine the gravity direction
	if(d-this.__ref[this.__p] < 0) {this.__g = -Math.abs(this.__g);this.__sign = -1;}
	else {this.__g = Math.abs(this.__g);this.__sign = 1;}
	
	this.onEnterFrame = this.gravityBounce_funct;
}
/**
 *@description: helper function for gravityBounce()
 **/
MovieClip.prototype.gravityBounce_funct = function() {
	this.__s += this.__g;

	if(this.__ref[this.__p] == this.__d && Math.abs(this.__s) < Math.abs(this.__g)) {
		delete this.onEnterFrame, this.__p, this.__d, this.__s, this.__b, this.__sign, this.__g;
		this.doCallBack();
	} else if((this.__ref[this.__p] += this.__s/5)*this.__sign > this.__d) {//maybe change the this.__s/5 in the future?
		this.__ref[this.__p] = this.__d;
		this.__s *= -this.__b;
	}
}
