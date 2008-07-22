/*
Function: schedule

Description:
Schedule a function to be called at a later time

Parameters: 
ms - [Number] Time in miliseconds for the function call to be delayed
ob - [Object] Scope for the function to be called on

Return: 
[Number] The interval ID from setInterval()

Usage:
|mc.moveAlot.schedule(1000, mc);		//call the function moveAlot after 1 second has passed

*/
Function.prototype.schedule = function(ms:Number, ob:Object) : Number {
	var functionRef = this; 
	functionRef._target = ob;
	/*
	 this == the parent function 
	 So if test() is the function we want to call in this call ob.test.schedule() this will be mapped to equal test */
	ob.__args = arguments.slice(2);
	ob.__id = setInterval(
		function() {
			functionRef.apply(ob, ob.__args);
			clearInterval(ob.__id);
			
			//delete the vars
			ob.__args = ob.__id = null;
		}, ms);
		
	return ob.__id;
}

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
Function.prototype.scheduleAndRepeat = function(ms:Number, ob:Object) : Number {
	var functionRef = this; 
	functionRef._target = ob;
	/*this == the parent function 
	So if test() is the function we want to call in this call ob.test.schedule()
	this will be mapped to equal test*/
	ob.__args = arguments.slice(2);
	ob.__id = setInterval(
		function() {
			functionRef.apply(ob, ob.__args);
		}, ms);
		
	return ob.__id;
}
