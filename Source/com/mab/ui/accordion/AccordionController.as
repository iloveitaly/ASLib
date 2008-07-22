/*
Class: com.mab.ui.accordion.AccordionController

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

import com.mab.ui.accordion.AccordionMenuItem;

class com.mab.ui.accordion.AccordionController extends MovieClip {
	public var easeSpeed:Number = 20;
	public var easeEquation:Function = com.mab.motion.easing.Quint.easeInOut;
	
	private var menuItems:Array;
	private var openIndex:Number;
	
	function AccordionController() {
		super();
		
		initBroadcaster();
		
		menuItems = [];
	}
	
	// :AccordionMenuItem
	function addMenuItem(item) : Void {
		menuItems.push(item);
		item.menuController = this;
		item.initMenuItem();
	}
	
	/*
	 Function: menuClicked
	 Called when the menu items added with <addMenuItem>() are clicked. Handles all the accordian logic and sets the <openIndex> variable.
	 Overide this to perform an action when a button was clicked, use <openIndex> to decide which action to perform.
	 
	 Argument:
	 button - the button that was clicked, the _parent of the button should be the AccordionMenuItem (ie the object in menuItems)
	 */
	function menuClicked(button) {
		button = button._parent;
		switchToMenuAtIndex(menuItems.contains(button));

	}
	
	function switchToMenuAtIndex(newIndex) {
		if(newIndex == openIndex) {
			// dont open the same thing twice
			return;
		}
		
		// close currently open menu
		// shift down all menus after it
		// shift all menus before it back to there original position
		
		menuItems[openIndex].close();
		
		for(var a = newIndex - 1; a >= 0; a--) {
			menuItems[a].shiftBy(0);
		}
		
		for(var a = newIndex + 1, dY = menuItems[newIndex].contentHeight; a < menuItems.length; a++) {
			menuItems[a].shiftBy(dY);
		}
		
		menuItems[newIndex].open();
		menuItems[newIndex].shiftBy(0);
		
		openIndex = newIndex;		
	}
}