/*
Class: MovieClip

Description:
Additional methods for the MovieClip class to simplify coding in AS.

Usage:
You must #include the approiate files for your project. There are the following files you can include:

util.as - Contains 'utility' methods. #include this file if you are using any of the other MC method additions
easing.as - Contains methods used for easily creating animation with an easing effect

Required Classes:
<com.mab.util.colorConverter>
<Object>

ToDo:
**todo**

Notes:
**notes**

Version:
1.2

Author:
Michael Bianco, http://mabwebdesign.com/
 
Date:
11/18/04

*/
intrinsic class methodAdditions.MovieClip {
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
	function animateFilter(t, i:Number, funct:String, args:Array);
	/*
	Function: addEvent

	Description:
	adds a onEnterFrame

	Parameters: 
	funct - A string representing the function to be applied to the MC
	args - An array containing all the arguments to be passed to the function via Function.apply()
	
	Usage:
	|target_mc.addEvent("equationEase", ["_x", 100, 100, com.mab.motion.easing.Linear.easeIn, function(){trace("done");}, target_mc]);

	*/
	function addEvent(funct,args);
	/*
	Function: addMultipleEvents

	Description:
	** Enter Method Description Here... **

	Parameters: 
	functs - [Untyped] ** Description here **
	args - [Untyped] ** Description here **

	*/
	function addMultipleEvents(functs,args);
	/*
	Function: alphaPulse

	Description:
	** Enter Method Description Here... **

	Parameters: 
	s - [Untyped] ** Description here **
	min - [Untyped] ** Description here **
	max - [Untyped] ** Description here **
	target - [Untyped] ** Description here **

	*/
	function alphaPulse(s,min,max,target);
	/*
	Function: alphaPulse_pulseDown

	Description:
	** Enter Method Description Here... **

	Parameters: 

	*/
	function alphaPulse_pulseDown();
	/*
	Function: alphaPulse_pulseUp

	Description:
	** Enter Method Description Here... **

	Parameters: 

	*/
	function alphaPulse_pulseUp();
	/*
	Function: back

	Description:
	** Enter Method Description Here... **

	Parameters: 

	*/
	function back();
	/*
	Function: bounceOutEaseTo

	Description:
	** Enter Method Description Here... **

	Parameters: 
	p - [Untyped] ** Description here **
	d - [Untyped] ** Description here **
	e - [Untyped] ** Description here **
	eventOb - [Untyped] ** Description here **
	target - [Untyped] ** Description here **

	*/
	function bounceOutEaseTo(p,d,e,eventOb,target);
	/*
	Function: bounceOutEndEaseTo

	Description:
	** Enter Method Description Here... **

	Parameters: 
	p - [Untyped] ** Description here **
	d - [Untyped] ** Description here **
	e - [Untyped] ** Description here **
	eventOb - [Untyped] ** Description here **
	target - [Untyped] ** Description here **

	*/
	/*
	 Function: attachMovieAnywhere
	 
	 Description:
	 Loads a clip (should have nothing on the stage, containing just assets) and attaches a movieclip from the loaded clip onto the stage
	 
	 Arguments:
	 file - [String] path to the SWF containing the assets
	 callBack - [Function] function that will be called once the asset swf is loaded, and the movieclip has been attatched. The scope of the function is the attatched movieclip, and the first argument is the attatched movieclip.
	 If you need a different scope use the <com.mab.util.Delegate> class.
	 NOTE: this function is not called once the attatched movieclip has been initialized, only when it has been attatched!
	 */	
	function bounceOutEndEaseTo(p,d,e,eventOb,target);
	/*
	Function: clearAllDoneEvents

	Description:
	** Enter Method Description Here... **

	Parameters: 

	*/
	function clearAllDoneEvents();
	/*
	Function: clearAllEvents

	Description:
	** Enter Method Description Here... **

	Parameters: 

	*/
	function clearAllEvents();
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
	function colorFade(s,colorOb,eventOb,target);
	/*
	Function: doCallBack

	Description:
	** Enter Method Description Here... **

	Parameters: 

	*/
	function doCallBack();
	/*
	Function: easeTo

	Description:
	** Enter Method Description Here... **

	Parameters: 
	p - [Untyped] ** Description here **
	d - [Untyped] ** Description here **
	e - [Untyped] ** Description here **
	eventOb - [Untyped] ** Description here **
	target - [Untyped] ** Description here **

	*/
	function easeTo(p,d,e,eventOb,target);
	/*
	 Function: elasticEase
	 
	 Description:
	 Same as easeTo except it applies a bounce effect to the easing
	 
	 Arguments:
	 p - [String] the property to change
	 d - destination value of the property you want to change
	 f - represents the friction and the bouncyness value, or if an array is specified the first element in the array represents the bouncyness and the second element represents the friction, if a third element is specified it will represent the velocity
	 eventOb - an object that contains the properties to dispatch an event. use {type:"functiontodispatch"}
	 del - whether or not to delete the onenterframe action when the easing is complete. Define del as true/1 to delete the onenterframe.
	 target - a path to the target properties to be changed. If you do not define this the mc that the function is being used on will be used
	 */
	function elasticEase(p,d,f,eventOb,target);
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
	function equationEase(p,d,t,f,callBack,target);
	/*
	Function: getNextHighestDepth

	Description:
	** Enter Method Description Here... **

	Parameters: 

	*/
	function getNextHighestDepth();
	/*
	Function: getRGB

	Description:
	** Enter Method Description Here... **

	Parameters: 

	*/
	function getRGB();
	/*
	Function: globalise

	Description:
	Converts local cooridants to global coordinants

	Parameters: 
	xPos - [Number] local x coordinant
	yPos - [Number] local y coordinant

	*/
	function globalise(xPos,yPos);
	/*
	Function: gravityBounce

	Description:
	** Enter Method Description Here... **

	Parameters: 
	p - [Untyped] ** Description here **
	d - [Untyped] ** Description here **
	g - [Untyped] ** Description here **
	callBack - [Untyped] ** Description here **
	target - [Untyped] ** Description here **

	*/
	function gravityBounce(p,d,g,callBack,target);
	/*
	Function: hideOb
	Hides the object by setting its _x & _y to -50000
	*/
	function hideOb();
	
	/*
	 Function: incrementTo
	 Increments the property of choice to the destination of your choice
	  
	 Parameters:
	  
	 p - [String] the property that you want to change
	 d - [Number] destination value of the property you want to change
	 i - [Number] increment speed (could be negative or position doesn't matter)
	 callBack - an object that contains the properties to dispatch an event
	 target - a path to the target properties to be changed. If you do not define this the mc that the function is being used on will be used
	 */
	 
	function incrementTo(p,d,i,callBack,target);
	/*
	Function: killAlphaPulse

	Description:
	** Enter Method Description Here... **

	Parameters: 
	maxMin - [Untyped] ** Description here **

	*/
	function killAlphaPulse(maxMin);
	/*
	Function: localise

	Description:
	 Convert a global coordinant to a local one
	 | destPt = someMC.globalise(someMC._x, someMC._y);
	 | destPt = otherMC.localise(destPt.x, destPt.y);


	Parameters: 
	xPos - [Number] ** Description here **
	yPos - [Number] ** Description here **

	*/
	function localise(xPos,yPos);
	/*
	Function: setEaseVars

	Description:
	** Enter Method Description Here... **

	Parameters: 
	p - [Untyped] ** Description here **
	d - [Untyped] ** Description here **
	t - [Untyped] ** Description here **

	*/
	function setEaseVars(p,d,t);
	/*
	Function: setRGB

	Description:
	Set the RGB value using the Color class

	Parameters: 
	r - [Object] The red value if you are passing seperate red, green, and blue values or a hex value (String or Number)
	g - [Number] Green value
	b - [Number] Blue value

	*/
	function setRGB(r,g,b);
	/*
	Function: setRef

	Description:
	** Enter Method Description Here... **

	Parameters: 
	r - [Untyped] ** Description here **

	*/
	function setRef(r);
	/*
	Function: setTransform

	Description:
	** Enter Method Description Here... **

	Parameters: 
	transform - [Untyped] ** Description here **

	*/
	function setTransform(transform);
	/*
	Function: showOb

	Description:
	Reverses the effects of hideOb()
	*/
	function showOb();
	/*
	Function: spin

	Description:
	** Enter Method Description Here... **

	Parameters: 
	s - [Untyped] ** Description here **
	l - [Untyped] ** Description here **
	eventOb - [Untyped] ** Description here **
	target - [Untyped] ** Description here **

	*/
	function spin(s,l,eventOb,target);
	/*
	Function: whiteColorFade

	Description:
	** Enter Method Description Here... **

	Parameters: 
	s - [Untyped] ** Description here **
	eventOb - [Untyped] ** Description here **
	target - [Untyped] ** Description here **

	*/
	function whiteColorFade(s,eventOb,target);
}
