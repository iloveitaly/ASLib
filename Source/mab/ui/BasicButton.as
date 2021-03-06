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

package mab.ui {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import mab.drawing.ShapeMaker;
	import mab.util.debug;
	
	public class BasicButton extends MovieClip {
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
		
		public var _offAlpha:Number = 0.75;
		public var _onAlpha:Number = 1;
		public var _pressAlpha:Number = .9;
		
		private var invisibleHitArea:Sprite;
		
		public function BasicButton() {
			super();
			
			alpha = _offAlpha;
			
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseClick);
			addEventListener(MouseEvent.MOUSE_UP, onMouseRelease);
		}
		
		public function generateHitArea(evn:Event) : void {
			var invisibleHitArea:Sprite = ShapeMaker.makeBox({width:width, height:height, x:0, y:0, color:0xFAB});
			invisibleHitArea.visible = false;
			addChild(invisibleHitArea);
			hitArea = invisibleHitArea;
		}
		
		public function onMouseOver(evn:Event) : void {
			// http://www.jadbox.com/2009/02/as3-optional-callback-method-warning/
			
			if(rollAction !== null) {
				rollAction.call(this, true);
			} else {
				alpha = _onAlpha;
			}
		}
		
		public function onMouseOut(evn:Event) : void {
			if(rollAction !== null) {
				rollAction.call(this, false);
			} else {
				alpha = _offAlpha;
			}
		}
		
		public function onMouseClick(evn:Event) : void {
			alpha = _pressAlpha;
		}
		
		/*
		 Function: onRelease
		 onRelease() event. If the target variable is specified action is exacuted in the scope of target.
		 If target is not specified then action is exacuting in the scope of this button. A reference to this button is always passed to the reciever
		 */
		public function onMouseRelease(evn:Event) : void {
			alpha = _onAlpha;
			
			if(action !== null) {
				if(target) {
					action.apply(target, [this]);
				} else {
					action();
				}
			}
		}
	}
}