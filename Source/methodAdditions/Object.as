/*
Class: Object

Description:
Additional methods to the Object root class to allow some additional functionality to AS.

Usage:
#include into your project for easy use. You can add the function prototypes to your core class files to avoid compile errors.

Notes:
**notes**

Version:
1.1

Author:
Michael Bianco, http://developer.mabwebdesign.com/
*/
intrinsic class methodAdditions.Object {
	/*
	Function: centerX

	Description:
	Centers the object horizontally depending on the given max x value

	Parameters: 
	xval - [Number] The max x position that the mc could be
	*/
	function centerX(xval:Number):Void;
	/*
	Function: centerXY

	Description:
	centers the object vertically and horizontally depending on the given max x and y value's. It simply calls centerX() & centerY()

	Parameters: 
	x - [Number] The max x position that the mc could be
	y - [Number] The max y position that the mc could be
	*/
	function centerXY(x:Number,y:Number):Void;
	/*
	Function: centerY

	Description:
	Centers the object vertically depending on the given max y value

	Parameters: 
	yval - [Number] The max y position that the mc could be
	*/
	function centerY(yval:Number):Void;
	/*
	Function: initBroadcaster

	Description:
	Inits the object as a EventDispatcher object if it already hasn't been inited
	
	Usage:
	|target_ob.initBroadcaster();
	*/
	function initBroadcaster():Void;
	/*
	Function: isInstanceOf

	Description:
	Tests whether the object is a member (I.E. classRef.__proto__ == this.__proto__) of the param classref.
	This might seem identical to the instanceof operator, but it isn't. The usage section gives a example where instanceof would fail.

	Parameters: 
	classRef - A reference to a class object to be compared to

	Return: 
	Boolean;
	true if the object is a instance of classRef, false otherwise
	
	Usage:
	|var num = 0;
	|if(num.isInstanceOf(Number)) {
	|	trace("isInstanceOf() thinks its a number!");
	|}
	|if(num instanceof Number) {
	|	trace("instanceof thinks its a number!"); //will never trace()
	|}
	*/
	function isInstanceOf(classRef):Boolean;
	/*
	Function: isMemberOf

	Description:
	Checks if the object is a descendant/instance of classref

	Parameters: 
	classRef - [Object] reference to a class (i.e. Object, String)

	Return: 
	Boolean;

	*/
	function isMemberOf(classRef):Boolean;
}
