/*
Class: com.mab.ui.scrolling.basicScroller

Description:
Simple scroll bar class. The height the of the scroller is scaled to be porportional to the amount of content that needs to be scrolled. Just like in a real operating system.

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

class com.mab.ui.scrolling.basicScroller extends com.mab.ui.scrolling.scrollCore {
	/*
	 Variable: startHeight
	 The value of this._height when the class is instantiated
	 
	 Variable: startY
	 The value of this._y when the class is instantiated
	 
	 Variable: contentStartY
	 The _y value of the contentHolder when setTarget() is called
	 
	 Variable: minHeight
	 The minimum height of the scroll bar
	 
	 Variable: stretchHeight
	 The amount of pixels that the scroll bar can 'shrink' to represent the amount of content being scrolled
	 
	 Variable: currScrollRatio
	 The percentage that the content MC's height fits into the content's mask. 
	 This is used to determine what the height of the scrollbar should be.
	 
	 Variable: scrollHeight
	 The amount of pixels the scroll bar can scroll
	 
	 Variable: contentScrollHeight
	 The amount of pixels of the content holder that arent covered by the mask
	 */
	private var startHeight:Number;
	private var startY:Number;
	private var contentStartY:Number;
		
	public var minHeight:Number = 20;
	public var pixelFontSafe:Boolean = false;
	private var stretchHeight:Number;
	private var currScrollRatio:Number;
	private var scrollHeight:Number;
	private var contentScrollHeight:Number;
	
	private var updateInterval:Number;
	public var noScroll:Boolean;
	
	function basicScroller() {
		super();

		startHeight = _height;
		startY = _y;
		
		initBroadcaster();
	}
	
	public function setTarget(t:MovieClip, m:MovieClip):Void {
		super.setTarget(t, m);
		
		contentStartY = contentHolder._y;
		
		updateMetrics();
	}
	
	public function updateMetrics(Void) : Void {
		contentScrollHeight = contentHolder._height - contentMask._height;
		stretchHeight = startHeight - minHeight;
		
		currScrollRatio = contentMask._height/contentHolder._height;
		
		if(currScrollRatio >= 1) {//then no scrolling is required
			//trace("No Scrolling Needed");
			
			noScroll = true;
			initLockPos();
			dispatchEvent({type:"noScrollRequired"});
			
			return;
		} else {
			noScroll = false;
		}

		_height = currScrollRatio * stretchHeight + minHeight;
		scrollHeight = startHeight - _height;
		
		initLockPos();
		updateView();
	}
	
	public function onPress() {
		super.onPress();
		updateInterval = setInterval(Delegate.create(this, updateView), 30);
	}
	
	public function onRelease() {
		super.onRelease();
		clearInterval(updateInterval);
	}
	
	public function onReleaseOutside() {
		super.onReleaseOutside();
		clearInterval(updateInterval);
	}
	
	public function updateView(Void):Void {
		if(noScroll) return;

		var newY = contentStartY - ((_y - startY)/scrollHeight*contentScrollHeight);
		contentHolder._y = pixelFontSafe ? Math.round(newY) : newY;
	}
	
	public function scrollDown(Void):Void {
		if(_y != startY + startHeight) {//make sure the scroller isn't at the bottom
			if(_y + scrollIncrement + _height > startY + startHeight) {
				_y = startY + startHeight - _height;
			} else {
				_y += scrollIncrement;
			}
			
			updateView();
		}
	}
	
	public function scrollUp(Void):Void {
		if(_y != startY) {//make sure the scroller still has room to move up
			if(_y - scrollIncrement < startY) {//then the scroller would go beyond bounds if scrolled up!
				_y = startY;
			} else {
				_y -= scrollIncrement;
			}
			
			updateView();
		}
	}
	
	public function initLockPos():Void {
		lockPos = [_x, startY, _x, _height == startHeight ? startY : startY + (startHeight - _height)];
	}
}