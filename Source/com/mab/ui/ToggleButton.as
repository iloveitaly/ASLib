/*
 Class: com.mab.ui.ToggleButton
 
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
class com.mab.ui.ToggleButton extends com.mab.ui.BasicButton {
	/*
	prop: toggleState
	When false, the button is 'off'. When true the button is 'on'. False ('off') is the inital state.
	
	prop: toggleAction
	Action that is called everytime the button is clicked, it is passed one argument- the new toggle state.
	This function should change the state of the button when called.
	
	prop: alternateAction
	Function that is called when the button is on a alternate state (true). This is called before toggleAction
	
	prop: alternateTarget
	Object to be used as the scope for the alternate action
	*/
	
	public var toggleState:Boolean = false;
	public var toggleAction:Function; 
	public var alternateAction:Function;
	public var alternateTarget:Object; //target to be used as the scope for the alternate action
	
	function ToggleButton() {
		super();
	}
	
	/*
	 Function: onRelease
	 onRelease() event. If the toggleState is true the alternateAction is fired.
	 
	 If alternateTarget is specified then alternateAction is exacuted in the scope of alternateTarget.
	 
	 If alternateTarget is not specified, and target is then alternateAction is exacuted in the scope of target. 
	 
	 If neither are specified then alternateAction is exacuted in the scope of the button itself.
	 
	 If toggleState is false then simpleButton's onRelease is executed.
	 */
	function onRelease() {
		if(toggleState) {//if the button was previously 'off'
			toggleState = false;
			
			if(target || alternateTarget) {
				alternateAction.apply(alternateTarget ? alternateTarget : target);
			} else {
				alternateAction();
			}
			
			_alpha = _onAlpha;
		} else {
			toggleState = true;
			super.onRelease();
		}	
		
		//execute the toggle action in this scope sending it the toggleState as an argument
		toggleAction(toggleState);
	}
	
	/*
	 function: setState
	sets the state of the button and fires the toggleAction
	
	 Arguments: 
	 s - BOOL representing the state that the button should be set to
	 */
	function setState(s:Boolean) : Void {
		toggleState = s;
		toggleAction(toggleState);
	}	
}