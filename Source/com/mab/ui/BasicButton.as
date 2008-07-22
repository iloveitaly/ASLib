/*
Class: com.mab.ui.BasicButton

Description:
Simple button class allowing you to easily create a button from a MC 
within the Flash IDE and assign a target & action via AS.

Version:
1.0

Author:
Michael Bianco, http://mabblog.com/

Date:
11/4/05
*/

import com.mab.drawing.shapeMaker;

class com.mab.ui.BasicButton extends MovieClip {
	/*
	 Variable: target
	 The scope to apply the action on
	 
	 Variable: action
	 The function to call whenh the button is pressed
	 
	 Variable: _offAlpha
	 Alpha value while the button is inactive
	 
	 Variable: _onAlpha
	 Alpha value while the mouse is over the button
	 
	 Variable: _pressAlpha
	 Alpha value when the button is being pressed
	 */
	public var target:Object;
	public var action:Function;
	public var rollAction:Function;
	
	public var _offAlpha:Number = 75;
	public var _onAlpha:Number = 100;
	public var _pressAlpha:Number = 90;
	
	private var invisibleHitArea:MovieClip;
	
	function BasicButton() {
		super();
		
		_alpha = _offAlpha;
	}
	
	function generateHitArea() {
		invisibleHitArea = shapeMaker.makeBox({_width:_width, _height:_height, color:0xFAB}, this, "hiddenHitArea");
		invisibleHitArea._visible = false;
		hitArea = invisibleHitArea;
	}
	
	function onRollOver() {
		if(rollAction) {
			rollAction.call(this, true);
		} else {
			_alpha = _onAlpha;
		}
	}
	
	function onRollOut() {
		if(rollAction) {
			rollAction.call(this, false);
		} else {
			_alpha = _offAlpha;
		}
	}
	
	function onPress() {
		_alpha = _pressAlpha;
	}
	
	/*
	 Function: onRelease
	 onRelease() event. If the target variable is specified action is exacuted in the scope of target.
	 If target is not specified then action is exacuting in the scope of this button. A reference to this button is always passed to the reciever
	 */
	function onRelease() {
		_alpha = _onAlpha;
		
		if(action) {
			if(target) {
				action.apply(target, [this]);
			} else {
				action(this);
			}
		}
	}
}