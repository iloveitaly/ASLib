/**
 *	 @class:		movieClipProtos
 *	@author:		Michael Bianco, http://mabwebdesign.com/
 *	  @date:		11/18/04
 * @version: 		1.0
 *@description:		MovieClip prototypes pertaining to uncategorized motion (IE, spins, pulse)
 **/

/**
 *@description: spins a movie clip
 *@param: s, speed of the spin
 *@param: l, limit to how many spins the MC will do. Spin = 360
 **/
MovieClip.prototype.spin = function(s, l, eventOb, target) {
	if(target) this.__ref = target;
	else this.__ref = this;
	
	this.__s = s;
	this.__c = 0; //count of how many degrees the MC has rotated
	this.__l = l;
	this.__callBack = eventOb;

	this.onEnterFrame = spin_funct;
}

MovieClip.prototype.spin_funct = function() {
	if(this.__l && this.__l < (this.__c+this.__s)/360) {
		this.__ref._rotation = this.__l*360;
		delete this.onEnterFrame, this.__l, this.__s, this.__c;
		this.doCallBack();
	} else {
		this.__ref._rotation += this.__s;
		this.__c += this.__s;
	}
}
/**
 *@description: a pulse effect for the _alpha property
 *@param: s, the speed of the pulse
 *@param: min, the minimum alpha value of the pulse
 *@param: max, the maximum alpha value of the pulse
 *@param: target, the target movieClip to apply this to
 **/
MovieClip.prototype.alphaPulse = function(s, min, max, target) {
	if(target) this.__ref = target;
	else this.__ref = this;
	
	this.__minAlpha = min;
	this.__maxAlpha = max;
	this.__s = s;
	
	this.alphaPulse_pulseUp();
}

/**
 *@description: helper function for the alphaPulse(), pulses the alpha to its max
 **/
MovieClip.prototype.alphaPulse_pulseUp = function() {
	if(this.__pulseShouldKill === 1) {//if then it should be killed on its max
		this.__pulseShouldKill = false;
		this.dispatchEvent({type:"pulseDone"});
	} else 
		this.incrementTo("_alpha", this.__maxAlpha, this.__s, this.alphaPulse_pulseDown, this.__ref);
}

/**
 *@description: helper function for the alphaPulse(), pulses the alpha to its min
 **/
MovieClip.prototype.alphaPulse_pulseDown = function() {
	if(this.__pulseShouldKill === 2) {//if 2 then it should be killed on its min
		this.__pulseShouldKill = false;
		this.dispatchEvent({type:"pulseDone"});
	} else 
		this.incrementTo("_alpha", this.__minAlpha, this.__s, this.alphaPulse_pulseUp, this.__ref);
}

/**
 *@description: stops the pulse from happening, once the last pulse cycle is complete it dispatches a "pulseDone" event
 *@param: maxMin, bool determining whether it should be killed when its at maxAlpha or at minAlpha. True makes it killed on minAlpha
 **/
MovieClip.prototype.killAlphaPulse = function(maxMin) {
	this.__pulseShouldKill = (maxMin)?1:2;
}
