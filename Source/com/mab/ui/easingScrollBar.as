/*
 Class: easingScrollBar
 
 Description:
 Easily create a easing scroller
 
 Usage:
 Create a scrollbar in the IDE and attach this class in the linkage panel. Then use <setTarget> to set the scrolling metrics
 
 Notes:
 **notes**
 
 Version:
 1.2
 
 Author:
 Michael Bianco, http://developer.mabwebdesign.com/
 
 Date:
 06/08/05
 */
 
class com.mab.ui.easingScrollBar extends MovieClip {	
	/*
	 Variable: lockPos
	 Array used for the coordinates in the startDrag() method
	 
	 Variable: scrollHeight
	 The height that you would like the scroller handle to be able to move from its original position
	 
	 Variable: easeSpeed
	 The easing speed used for the easing in the easing scroller
	 
	 Variable: offSet
	 The _y position of the scroll handle initially. This should set automatically by the <initLockPos>() function
	 
	 Variable: pixelFontSafe
	 If true, makes sure pixel fonts are clear
	 
	 Variable: snapToExactPixels
	 If true, the scroller will make the content holder scrolls to the exact pixel
	 
	 Variable: noReverseScroll
	 If true prevents reverse scroll... who would want reverse scroll? Remove in the future?
	 */
	private var target;
	private var lockPos:Array;
	private var handleOffset:Number;
	private var targetOffset:Number;
	private var scrollRatio:Number;
	private var textFieldScroll:Boolean;
	
	public var scrollHeight:Number = 110;
	public var easeSpeed:Number = 5;
	public var pixelFontSafe:Boolean = true;
	public var snapToExactPixels:Boolean = false;
	public var simpleScroll:Boolean = false;
	
	function easingScrollBar() {
		super();

		initBroadcaster();

		initLockPos();		
	}
	
	/*
	 Function: initLockPos
	 
	 Description: inits the locking positions for the scrollers. Use this function to re-init the locking position after initalization time
	 */
	public function initLockPos():Void {
		handleOffset = _y
		
		//the locking positions for stopDrag()
		lockPos = [_x, _y, _x, _y + scrollHeight];
	}
	
	private function onPress() {
		this.startDrag(false, lockPos[0], lockPos[1], lockPos[2], lockPos[3])
		
		if(textFieldScroll) {
			onEnterFrame = updateTextFieldScroll;
		}
	}
	
	private function onRelease() {
		stopDrag()
		
		if(textFieldScroll) {
			onEnterFrame = null;
		}
	}
		
	private function onReleaseOutside() {
		stopDrag();
		
		if(textFieldScroll) {
			onEnterFrame = null;
		}		
	}
	
	/*
	 Function: setTarget
	 
	 Description:
	 Sets the target content area and mask for the scroller and starts the animation loop. 
	 Dispatches a "noScrollRequired" event if the content area is less than or equal to the height of the mask
	 
	 Arguments:
	 t - [MovieClip] the target holder that is being masked
	 m - [MovieClip] the mask
	 */
	public function setTarget(t, m):Void {
		if(t._height <= m._height) {
			dispatchEvent({type:"noScrollRequired"});
			return;
		}
		
		target = t;
		textFieldScroll = false;
		
		// scrollRatio = height of the text-field or MC - height of the viewable area + the offset of the content area divided by the scroll height
		scrollRatio = (t._height - m._height + t._y) / scrollHeight;
		targetOffset = t._y;
		
		onEnterFrame = updateEaseScroll;
	}
	
	public function setTextField(tf:TextField) {
		if(!tf.maxscroll || tf.maxscroll == 1) {
			dispatchEvent({type:"noScrollRequired"});
			return;
		}
		
		target = tf;
		textFieldScroll = true;		
	}
	
	private function updateEaseScroll() {
		// i = _y increment, l = distance remaining to ease to, p = is pixelFontSafe
		var dest = -(((_y - handleOffset) * scrollRatio) - targetOffset)
		var i, l;
		
		if(simpleScroll) {
			target._y = dest;
			return;
		}
		
		target._y += (i = (pixelFontSafe ? Math.round((dest - target._y) / easeSpeed) : (dest - target._y) / easeSpeed));
		
		if(snapToExactPixels) {
			l = dest - target._y;
			
			if(Math.abs(l) < easeSpeed && i == 0 && pixelFontSafe && l != 0) {
				l /= easeSpeed;
				target._y += pixelFontSafe ? Math.round(l) : l;
			} else if(Math.abs(l) < 2 && l != 0) {
				target._y = Math.round(dest);
			}
		}
	}
	
	private function updateTextFieldScroll() {
		target.scroll = Math.round((_y - handleOffset) * target.maxscroll/scrollHeight);
	}
}