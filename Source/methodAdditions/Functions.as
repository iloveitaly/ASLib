/*
Class: Function

Description:
Useful additions to the function class.

Usage:
<code>Usage</code>

Example:
<code>Example(s)</code>

ToDo:
**todo**

Notes:
**notes**

Version:
1.1

Author:
Michael Bianco, http://mabwebdesign.com/

*/
intrinsic class methodAdditions.Function {
	/*
	Function: schedule

	Description:
	Schedule a function to be called at a later time

	Parameters: 
	ms - [Number] Time in miliseconds for the function call to be delayed
	ob - [Object] Scope for the function to be called on

	Return: 
	Number;
	The interval ID from setInterval()
	
	Usage:
	|mc.moveAlot.schedule(1000, mc); //call the function moveAlot after 1 second has passed

	*/
	function schedule(ms:Number,ob:Object):Number;
	/*
	Function: scheduleAndRepeat

	Description:
	Schedule a function to be called every ms miliseconds.

	Parameters: 
		ms - [Number] Time in miliseconds to wait before calling the function again
		ob - [Object] Scope for the function to be called on

	Return: 
	[Number] The interval ID from setInterval()
	
	Usage:
	|mc.moveAlot.scheduleAndRepeat(1000, mc); //call the function moveAlot every second

	*/
	function scheduleAndRepeat(ms:Number,ob:Object):Number;
}
