/**
 *	 @class:		easing.as
 *	@author:		Michael Bianco, http://mabwebdesign.com/
 *	  @date:		11/18/04
 * @version: 		1.1
 *@description:		MovieClip method additions to make animating MovieClips easier
 *@requires:		mab.motion.Easing, movieclip/util.as
 **/

/*
 Function: animateFilter
 Easily animate a property of a filter
 
 Parameters:
	t - the target movieclip that you want to manipulate the filters on
	i - the index of the filter in target's filter array
	funct - the animation function to use to manipulate the filter's property
	args - the arguments to be given to the animation function.
 
 Usage:
 |var blur = new flash.filters.BlurFilter(30, 0, 3);
 |image.filters = [blur]
 |animateFilter(image, blur, 0, "incrementTo", ["blurX", 0, 10, Delegate.create(this, animationComplete), blur]);
 */
MovieClip.prototype.animateFilter = function(t, i:Number, funct:String, args:Array) {
	this.__findex = i;
	this.__mcref = t;
	
	this[funct].apply(this, args);
	this.__cfunct = this.onEnterFrame; // save the onEnterFrame function from the animation function
	
	this.onEnterFrame = this.animationFilter_funct;
}

MovieClip.prototype.animationFilter_funct = function() {
	var a = this.__mcref.filters;
	this.__ref = a[this.__findex];
	this.__cfunct();
	this.__mcref.filters = a;
}

/*
 Function: incrementTo
 Increments the propertie of choice to the destination of your choice
 
 Parameters:
 
	p - [String] the property that you want to change
	d - [Number] destination value of the property you want to change
	i - [Number] increment speed (could be negative or position doesn't matter)
	callBack - an object that contains the properties to dispatch an event
	target - a path to the target properties to be changed. If you do not define this the mc that the function is being used on will be used
 */
MovieClip.prototype.incrementTo = function(p:String, d:Number, i, callBack, target) {
	this.setRef(target);

	if(d-this.__ref[p] < 0) this.__i = -Math.abs(i); //increment should be negative
	else this.__i = Math.abs(i); //increment should be positive

	this.__p = p;
	this.__d = d;
	this.__callBack = callBack;
	this.__start = this.__ref[p];
	this.__diff = Math.abs(this.__d-this.__start);

	this.onEnterFrame = this.incrementTo_funct;
}

/*
 Function: incrementTo_funct
 helper function for the incrementTo function
 */
MovieClip.prototype.incrementTo_funct = function() {
	if(this.__diff < Math.abs(this.__ref[this.__p]+this.__i-this.__start)) {
		this.__ref[this.__p] = this.__d;
		this.onEnterFrame = this.__p = this.__d = this.__start = this.__diff = null;
		this.doCallBack();
	} else {
		this.__ref[this.__p] += this.__i;
	}
}

/*
 Function: easeTo
 Eases the property of choice to the destination of your choice
 
 Parameters: 
	p - [String] the property that you want to change
	d - [Untyped] destination value of the property you want to change
	e - [Number] the easing speed
	eventOb - [Function|Object] an object that contains the properties to dispatch an event. use {type:"functiontodispatch"}, can also be a function
 */
MovieClip.prototype.easeTo = function(p, d, e, eventOb, target) {
	this.setRef(target);
	
	this.__callBack = eventOb;
	this.__p = p;
	this.__d = d;
	this.__e = e;
		
	this.onEnterFrame = this.easeTo_funct;
}

/*
 Function: easeTo_funct
 Helper function for the easeTo()
 */
MovieClip.prototype.easeTo_funct = function() {
	if(Math.abs(this.__d-this.__ref[this.__p]) < 2) {
		this.__ref[this.__p] = this.__d;
		this.onEnterFrame = this.__p = this.__d = this.__e;
		this.doCallBack();
	} else {
		this.__ref[this.__p] += (this.__d-this.__ref[this.__p])/this.__e
	}
}

/*
 Function: bounceOutEndEaseTo
 
 Description:
 eases the property of choice to the destination of your choice with a 'bounce' before it starts moving
 
 Arguments:
	 p - the property that you want to change
	 d - destination value of the property you want to change
	 e - the easing speed to be used
	 eventOb - an object that contains the properties to dispatch an event. use {type:"functiontodispatch"}, can also be a function
	 target - a path to the target properties to be changed. If you do not define this the mc that the function is being used on will be used
 */
MovieClip.prototype.bounceOutEndEaseTo = function(p, d, e, eventOb, target) {
	var ref;
	if(target) ref = target;
	else ref = this;

	this.easeTo(p, Math.round((-d)*.1)+ref[p], e, function(){this.easeTo(p, d, e, eventOb, target)}, target);
}

/**
 *@description: eases the property of choice to the destination of your choice with a 'bounce' after its done moving
 *@param: p, the property that you want to change
 *@param: d, destination value of the property you want to change
 *@param: e, the easing speed to be used
 *@param: eventOb, an object that contains the properties to dispatch an event. use {type:"functiontodispatch"}, can also be a function
 *@param: target, a path to the target properties to be changed. If you do not define this the mc that the function is being used on will be used
 **/
MovieClip.prototype.bounceOutEaseTo = function(p, d, e, eventOb, target) {
	this.setRef(target);
	this.easeTo(p, (Math.round(d*.1)*((d-this.__ref[p]<0)?-1:1))+d, e, function(){this.easeTo(p, d, e, eventOb, target)}, target);
}

/*
 Function: equationEase
 easing based on robbert penner's easing equations
 
 Parameters:
 
	p - the property that will be modified
	d - the destination value for the property
	t - the time (in onEnterFrames) that it will take to complete the animation
	f - a function taken from mab.motion.Easing's static/class functions
	callBack - an object that contains the properties to dispatch an event. use {type:"functiontodispatch"}, can also be a function
	target - a path to the target properties to be changed. If you do not define this the mc that the function is being used on will be used
 */
MovieClip.prototype.equationEase = function(p, d, t, f, callBack, target) {
	this.setRef(target);
	this.setEaseVars(p, d, t);
	this.__f = f ? f : com.mab.motion.easing.Quad.easeOut; //if the user didn't specify a function then just do normal easeOut
	this.__callBack = callBack;
	this.onEnterFrame = this.equationEase_funct;
}

/**
 *@description: function that sets all the variables for equation/robbert penner based easing
 *@param: p, the property that will be modified
 *@param: d, the destination value for the property
 *@param: t, the time (in onEnterFrames) that it will take to complete the animation
 **/
MovieClip.prototype.setEaseVars = function(p, d, t) {
	this.__p = p;
	this.__s = this.__ref[p]; //start
	this.__c = d - this.__ref[p]; //change
	this.__d = d;
	this.__pos = 0;
	this.__t = t;
}

/**
 *@description: internal easing function for the equation/robbert penner based easing
 **/
MovieClip.prototype.equationEase_funct = function() {
	this.__ref[this.__p] = this.__f(this.__pos++, this.__s, this.__c, this.__t);
	
	if(this.__pos == this.__t) {
		this.__ref[this.__p] = this.__d; // set it to its final value so we dont have worry about equation weirdness and not reaching its final value
		this.onEnterFrame = this.__p = this.__s = this.__c = this.__d = this.__pos = this.__t = this.__f = null;
		this.doCallBack();
	}
}

