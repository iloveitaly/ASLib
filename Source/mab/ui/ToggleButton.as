/*
 Class: mab.ui.ToggleButton
 
 Description:
 Easily create a toggle button
 
 Usage:
 |usage code here
 
 Notes:
 **notes**
 
 Version:
 1.1
 
 Author:
 Michael Bianco
 
 Date:
 10/17/05
 */

package mab.ui {
	import flash.events.*;
	import mab.util.debug;
	
	public class ToggleButton extends BasicButton {
		/*
		prop: toggleState
		When false, the button is 'off'. When true the button is 'on'. False ('off') is the inital state.
		
		prop: toggleAction
		Action that is called everytime the button is clicked, it is passed one argument- the new toggle state.
		This function should change the state of the button when called.		
		*/
		
		public var toggleState:Boolean;
		public var toggleAction:Function; 
		
		function ToggleButton() {
			super();
			
			toggleState = false;
		}
		
		/*
		 Function: onRelease
		 onRelease() event. If the toggleState is true the alternateAction is fired.
		 		 
		 If neither are specified then alternateAction is exacuted in the scope of the button itself.
		 
		 If toggleState is false then simpleButton's onRelease is executed.
		 */
		override public function onMouseRelease(evn:Event) : void {
			if(toggleState) {// if the button was previously 'off'
				toggleState = false;				
				alpha = _onAlpha;
			} else {
				toggleState = true;
				alpha = _offAlpha;
			}	
			
			// execute the toggle action in this scope sending it the toggleState as an argument
			toggleAction(toggleState);
		}
		
		/*
		 function: setState
		sets the state of the button and fires the toggleAction
		
		 Arguments: 
		 s - BOOL representing the state that the button should be set to
		 */
		public function setState(s:Boolean) : void {
			toggleState = s;
			toggleAction(toggleState);
		}	
	}
}