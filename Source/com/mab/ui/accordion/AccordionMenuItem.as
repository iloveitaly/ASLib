/*
Class: com.mab.ui.accordion.AccordionMenuItem

Description:
** Description Here... **

Usage:
|usage code here

Notes:
**notes**

Version:
1.0

Author:
Michael Bianco

Date:
5/17/07

*/

import com.mab.ui.accordion.AccordionController;
import com.mab.drawing.shapeMaker;

class com.mab.ui.accordion.AccordionMenuItem extends MovieClip {
	/*
	 Variable: menuController
	 A reference to the associated AccordionController
	 */
	public var menuController:AccordionController;
	
	/*
	 Variable: oContentArea
	 The content area that will be collasped on the accordion menu item
	 
	 Variable: oContentMask
	 The mask for the content area
	 
	 Variable: oMenuTitle
	 The 'header' button that will open/close the menu title.
	 <AccordionController> expects this to be a <basicButton>, but you can subclass AccordionController to change this functionality 
	 
	 Variable: initialY
	 The initial position of the holder, used for position in <shiftBy>
	 */
	private var oContentArea;
	private var oContentMask;
	private var oMenuTitle;
	
	private var initialY:Number;
	
	/*
	 Function: AccordionMenuItem
	 If oContentMask is not set, it will create one and setMask() on oContentArea.
	 If you want to set a custom oContentMask oContentMask.removeMovieClip() and do your custom stuff in a subclass or place one in the MC before its initialized
	 */
	function AccordionMenuItem() {
		super();
		
		if(!oContentMask) {
			oContentMask = shapeMaker.makeBox({_width:contentWidth, _height:0, _x:oContentArea._x, _y:oContentArea._y}, this, "mask");
		}
		
		oContentArea.setMask(oContentMask);
	}
	
	/*
	 Function: open
	 Opens the content mask for the menu item
	 */
	public function open() : Void {
		oContentMask.clearAllEvents();
		oContentMask.equationEase("_height", contentHeight, menuController.easeSpeed);
	}
	
	/*
	 Function: close
	 Closes the content mark for the menu item
	 */
	public function close() : Void {
		oContentMask.clearAllEvents();
		oContentMask.equationEase("_height", 0, menuController.easeSpeed);
	}
	
	/*
	 Function: shiftBy
	 Shifts the whole movieclip down by a specified amount
	 
	 Arguments:
	 dY - [Number] amount to shift the _y of the menu item by
	 */
	public function shiftBy(dY:Number) : Void {
		clearAllEvents();
		equationEase("_y", initialY + dY, menuController.easeSpeed);
	}
	
	/*
	 Function: initMenuItem
	 Sets the initial Y position and the target & action for the button.
	 Overide in subclass if your not using basicButton for the oMenuTitle or want to do something fancy
	 */
	public function initMenuItem() : Void {
		oMenuTitle.target = menuController;
		oMenuTitle.action = menuController.menuClicked;
		
		initialY = _y;
	}
	
	function get contentHeight() : Number {
		return oContentArea._height;
	}
	
	function get contentWidth() : Number {
		return oContentArea._width;	
	}
}