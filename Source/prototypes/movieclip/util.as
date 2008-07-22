/**
 *	 @class:		movieClipProtos
 *	@author:		Michael Bianco, http://mabwebdesign.com/
 *	  @date:		11/18/04
 * @version: 		.8
 *@description:		MovieClip prototypes containing usefull function to make animating, and managing MC's easier
 *@requires:		The colorConverter class
 **/

/*
 Description: A function used for creating empty movie clips with subclass association.
 
 Parameters:
 c:Function - The class to associate with the the empty movie clip.
 name:String - The instance name for the empty movie clip.
 depth:Number - The depth for the empty movie clip.
 initOb:Object - Optional, object to copy properties from 
 
 Returns:
 MovieClip - A reference to the newly created movie clip.
 */
MovieClip.prototype.createClassMovieClip = function(c:Function, name:String, depth:Number, initOb:Object) : MovieClip {
	var mc:MovieClip = this.createEmptyMovieClip(name, depth);
	mc.__proto__ = c.prototype;
	mc.constructor = c;
	
	if(initOb) {
		for(var prop in initOb) {
			mc[prop] = initOb[prop];
		}
	}
	
	c.call(mc);
	return mc;
}

/**
 *@description: adds a onEnterFrame event
 *@param: funct, a string representing the function to be called
 *@param: args, an array containing all the arguments to be passed to the function via Function.apply()
 **/
MovieClip.prototype.addEvent = function(funct, args) {
	if(!this.__eventCount) this.__eventCount = 0;
	if(!this.__eventStack) this.__eventStack = [];
	
	var nextPos = this.__eventStack.length;
	this.__eventStack[nextPos] = this.createEmptyMovieClip("__eventMC"+this.__eventCount++, this.getNextHighestDepth());
	this.__eventStack[nextPos][funct].apply(this.__eventStack[nextPos], args);
	return this.__eventStack[nextPos];
}

/*
 Function: addMultipleEvents
 
 Description:
 Add mutiple events to a MC
 
 Arguments:
 functs - [Array|String] a 1 demensional array containing strings of function names that will be called. This parameter can also be just one string representing a function name if you want the same function to be used for as many arg's there are
 args - [Array] a two demension array, the first index corresponds to the first index of the functs array, the array in the first index must contain the param's that will be sent to the function via Function.apply(). the length of this array determines how many event objects are created
 */
MovieClip.prototype.addMultipleEvents = function(functs, args) {
	this.clearAllDoneEvents();
	
	var len = args.length;
	if(typeof functs == "string") {
		var tempFunct = functs;
		functs = [];
		for(var a = 0; a<len; a++)
			functs[a] = tempFunct;
	}
	
	for(var a = 0; a<len; a++)
		this.addEvent(functs[a], args[a])
}

/**
 *@description: clears all events that are complete, you should use this function periodically
 *@returns: false on failure
 **/
MovieClip.prototype.clearAllDoneEvents = function() {
	if(!this.__eventStack) return false;
	var len = this.__eventStack.length;
	for(var a = 0; a<len; a++) {//loop through all the onEnterFrame holders
		if(!this.__eventStack[a].onEnterFrame) {//then we can get rid of the onEnterFrame cause there isn't any reason to keep it
			//remove it from the array and removeMovieClip()
			var tempRef = this.__eventStack[a];
			this.__eventStack.splice(a, 1)
			tempRef.removeMovieClip();
		}
	}
}

/**
 *@description: clears all events
 *@returns: false on failure
 **/
MovieClip.prototype.clearAllEvents = function() {
	if(!this.__eventStack) return false;

	for(var a = 0; a<this.__eventStack.length; a++) {
		delete this.__eventStack[a].onEnterFrame;
		this.__eventStack[a].removeMovieClip();
	}
	
	this.__eventStack = []; //re-set the array
}

/*
 Function: attachMovieAnywhere
 
 Description:
 Loads a clip (should have nothing on the stage, containing just assets) and attaches a movieclip from the loaded clip onto the stage
 
 Arguments:
 file - [String] path to the SWF containing the assets
 callBack - [Function] function that will be called once the asset swf is loaded, and the movieclip has been attatched. The scope of the function is the attatched movieclip, and the first argument is the attatched movieclip.
 If you need a different scope use the <Delegate> class.
 NOTE: this does not call once the attatched movieclip has been initialized, only when it has been attatched!
 */
MovieClip.prototype.attachMovieAnywhere = function(file:String, idName:String, newName:String, depth:Number, initObject:Object, callBack:Function) {
	if(depth == undefined)
		depth = this.getNextHighestDepth();
	
	var parent:MovieClip = this;
	var container:MovieClip = this.createEmptyMovieClip(newName, depth);
	var mcLoader:MovieClipLoader = new MovieClipLoader();
	var listener:Object = new Object();
	
	listener.onLoadInit = function (mc) {
		parent[newName] = mc.attachMovie(idName, newName, mc.getNextHighestDepth(), initObject);
		if(callBack) callBack.call(parent[newName], parent[newName])
	}
		
	mcLoader.addListener(listener);
	mcLoader.loadClip(file, container);
}

/**
 *@description: returns the correct next highest depth that isn't occupied
 *@note: this function will only work correctly if you set the depths of you objects in order. That is this
 *function will not work correctly if you set your MC's at random depths. The best way to insure that this function works
 *perfectly is to use it whenever you are placing MC's on teh stage dynamically
 **/
MovieClip.prototype.getNextHighestDepth = function() {
	this.__counter = 0;
	while(this.getInstanceAtDepth(this.__counter) != undefined) {
		this.__counter++;
	}

	return this.__counter;
}

/**
 *@description: sets this.__ref to the correct reference
 **/
MovieClip.prototype.setRef = function(r) {
	if(r) {
		this.__ref = r;
	} else {
		this.__ref = this;
	}
}

/**
 *@description: CallBack caller, calls the this.__callBack function if the function is set, it delete the current callBack function if it is nessicary
 **/
MovieClip.prototype.doCallBack = function() {
	if(!this.__callBack) return;
	var tempCallBack = this.__callBack;
	if(this.__callBack instanceof Function)
		this.__callBack.call(this.__ref);
	else if(this.__callBack.type)
		this.__ref.dispatchEvent(this.__callBack);
		
	if(tempCallBack === this.__callBack) delete this.__callBack; //delete it so it doesn't get used again, only delete it if it is the same thing as the previous callBack
}


/*
 Function
 *Global to local functions from proto.layer51.com
 *Converts local cooridants to global coordinants
 **/
MovieClip.prototype.globalise = function(xPos,yPos){
	var temp = {x:xPos,y:yPos};
	this._parent.localToGlobal(temp);
	return temp;
}

/*
Function: localise

Description:
** Enter Method Description Here... **

Parameters: 
xPos - [Number] ** Description here **
yPos - [Number] ** Description here **
*/
MovieClip.prototype.localise = function(xPos,yPos) {
	var temp = {x:xPos,y:yPos};
	this._parent.globalToLocal(temp);
    return temp;
}

/**
 *@description: plays the movie clips frames in reverse
 **/
MovieClip.prototype.back = function() {
	this.onEnterFrame = function() {
		this.prevFrame();
		if (this._currentframe == 1) {
			delete this.onEnterFrame;
		}
	};
};


/*
 Function: hideOb
 Hides the object by setting its _x & _y to -50000
 */
MovieClip.prototype.hideOb = function() {
	if(this.__hidden) return;
	
	this.__x = this._x;
	this.__y = this._y;
	this._x = this._y = -50000;
	this._visible = false;
	this.__hidden = true;
}

/*
 Function: showOb

 Description:
 Reverses the effects of hideOb()
 */
MovieClip.prototype.showOb = function() {
	if(!this.__hidden) return;

	this._x = this.__x;
	this._y = this.__y;
	this._visible = true;
	this.__hidden = false;
}