/*
Class: com.mab.ui.scrolling.scrollCore

Description:
Abtract scrolling class

Usage:
|usage code here

Notes:
**notes**

Version:
1.0

Author:
Michael Bianco

Date:
11/12/05

*/

import com.mab.util.Delegate;

class com.mab.ui.scrolling.scrollCore extends MovieClip {
	/*
	 Variable: upButn
	 The MC or button representing the 'up button' on the scroller.
	 
	 Variable: downButn
	 The MC or button representing the 'down button' on the scroller.
	 
	 Variable: scrollIncrement
	 Increment to scroll when scrollDown() or scrollUp() is called
	 
	 Variable: lockPos
	 Array containing the coordinants to be used for startDrag()
	 
	 Variable: contentHolder
	 Reference to the content MC
	 
	 Variable: contentMask
	 Reference to the MC masking contentHolder
	 */
	private var upButn;
	private var downButn;
	
	public var scrollIncrement:Number = 10;
	public var lockPos:Array;
	
	private var contentHolder:MovieClip;
	private var contentMask:MovieClip;
	
	function scrollCore() {
		super();
	}
	
	/*
	 Function: setUpButn
	 Set the scroll up button
	 
	 Parameters:
		u - Button or MovieClip. This function will the set the upButn variable, and set the action variable on the Button or MC given.
			The reason that this function sets the action variable on the Button or MC given is becasue it will make it easier to 
			create a working scroller when using either the <basicButton> or <toggleButton> classes	
	 */
	public function setUpButn(u):Void {
		upButn = u;
		upButn.action = Delegate.create(this, scrollUp);
	}
	
	public function setDownButn(d):Void {
		downButn = d;
		downButn.action = Delegate.create(this, scrollDown);
	}
	
	/*
	 Function: setTarget
	 Method to initalize the scroller and sets its content MC & content MC mask
	 
	 Parameters:
	 t - Content holder
	 m - Mask of the content holder
	 */	
	public function setTarget(t:MovieClip, m:MovieClip):Void {
		contentHolder = t;
		contentMask = m;
	}
	
	public function initLockPos():Void {
		//implement in the sub-class
	}
	
	public function scrollDown(Void):Void {
		//implement in the sub-class
	}
	
	public function scrollUp(Void):Void {
		//implement in the sub-class
	}
	
	public function onPress() {
		this.startDrag(false, lockPos[0], lockPos[1], lockPos[2], lockPos[3]); //'this' needed to Flash IDE compilation
	}
	
	public function onRelease() {
		stopDrag()
	}
	
	public function onReleaseOutside() {
		stopDrag();
	}
}