/**
 *	 @class:		movieClipProtos
 *	@author:		Michael Bianco, http://mabwebdesign.com/
 *	  @date:		11/18/04
 * @version: 		.8
 *@description:		MovieClip prototypes containing usefull function to make animating, and managing MC's easier
 *@requires:		The colorConverter class
 **/

/*
 Function: setRGB
 
 Description:
 Sets the RGB value using the color object
 
 Arguments:
 r - the red value if you are passing 3 params (a rgb value that is) or a hex value if you are passing a hex value
 g - green value
 b - the blue value
 */
MovieClip.prototype.setRGB = function(r, g, b) {
	if(!this.__color) this.__color = new Color(this);
	
	if(arguments.length == 3) {//rgb value
		this.__color.setRGB(com.mab.util.colorConverter.toHex(r, g, b));
	} else if(arguments.length == 1) {//hex value
		this.__color.setRGB(r);
	}
}

/*
 Function: getRGB
 
 Description:
 Gets the RGB value from the MC in hex value
 
 Returns:
 0xFFFFFF if the color has not been set by setRGB(), returns the last call to setRGB() if the color has been set
 */
MovieClip.prototype.getRGB = function() {
	if(!this.__color) this.__color = new Color(this);
	
	return ((this.__color.getRGB() == 0)?0xFFFFFF:this.__color.getRGB());
}

/*
 Function: colorFade
 
 Description:
 Fades the movieclip from one color to another
 
 Arguments:
 s - speed of the fade
 colorOb - a object conaining a r, g, and b value that represents the target end color value
 eventOb - event object that will be used to dispatch an event
 target - a target MC to apply the actions on
 
 Note:
 You must set the RGB value before hand or white (0xFFFFFF) will be assumed as the starting value. you must use the MovieClips setRGB() not the color object's set RGB() in addition the smaller the increment the better the fade will look
 */
MovieClip.prototype.colorFade = function(s, colorOb, eventOb, target) {
	if(target) this.__ref = target;
	else this.__ref = this;

	this.__speed = s;
	this.__endColor = colorOb;
	this.__currColor = com.mab.util.colorConverter.toRGB(this.__ref.getRGB());
	this.__sign_r = (colorOb.r-this.__currColor.r < 0) ? -1 : 1; //if colorOb.r-this.__currColor.r is negative then the increment must be - if not then +
	this.__sign_g = (colorOb.g-this.__currColor.g < 0) ? -1 : 1;
	this.__sign_b = (colorOb.b-this.__currColor.b < 0) ? -1 : 1;
	this.__callBack = eventOb;
	this.onEnterFrame = this.colorFade_funct;
}

MovieClip.prototype.colorFade_funct = function() {
	if(Math.abs(this.__currColor.r - this.__endColor.r) <= this.__speed && 
	   Math.abs(this.__currColor.g - this.__endColor.g) <= this.__speed && 
	   Math.abs(this.__currColor.b - this.__endColor.b) <= this.__speed) {
		this.setRGB(this.__endColor.r, this.__endColor.g, this.__endColor.b);
		this.onEnterFrame = null;
		this.doCallBack();
	} else {
		if(Math.abs(this.__currColor.r-this.__endColor.r)>this.__speed) this.__currColor.r += this.__sign_r*this.__speed;
		if(Math.abs(this.__currColor.g-this.__endColor.g)>this.__speed) this.__currColor.g += this.__sign_g*this.__speed;
		if(Math.abs(this.__currColor.b-this.__endColor.b)>this.__speed) this.__currColor.b += this.__sign_b*this.__speed;
		this.__ref.setRGB(this.__currColor.r, this.__currColor.g, this.__currColor.b);
	}
}

/**
 *@description: sets the color transform for the MC
 *@param: transform, same as the Color.setTranform() param
 **/
MovieClip.prototype.setTransform = function(transform) {
	if(!this.__color) this.__color = new Color(this);
	
	this.__color.setTransform(transform);
}

/**
 *@description: creates a bleach fade
 *@param: s, the speed of the fade. This is optional
 *@param: eventOb, the event that you want to be dispatched after the action is complete
 *@param: del, BOOL of whether or not the onEnterFrame should be deleted
 *@param: target, the target MC for this action to be applied to
 **/
MovieClip.prototype.whiteColorFade = function(s, eventOb, target) {	
	if(target) this.__ref = target;
	else this.__ref = this;
	
	this.__transform = {ra:100, rb:255, ga:100, gb:255, ba:100, bb:255, aa:100, ab:0};
	this.__ref.setTransform(this.__transform);
	this.__callBack = eventOb;
	this.__speed = s;
	this.onEnterFrame = this.whiteColorFade_funct;
}

/**
 *@description: helper function for the whiteColorFade
 **/
MovieClip.prototype.whiteColorFade_funct = function() {
	if(this.__transform.rb>0) this.__transform.rb -= this.__speed;
	if(this.__transform.gb>0) this.__transform.gb -= this.__speed;
	if(this.__transform.bb>0) this.__transform.bb -= this.__speed;
	this.__ref.setTransform(this.__transform);
	
	if(this.__transform.rb<=0 && this.__transform.gb<=0 && this.__transform.bb<=0) {		
		delete this.onEnterFrame;
		this.doCallBack();
	}
}
