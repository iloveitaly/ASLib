/*
 Class: com.mab.ui.sliderController
 
 Description:
 Easily create a slider UI element.
 
 Usage:
 This class requires the <Object> method additions and the <com.mab.drawing.shapeMaker> class.
 
 To-Do:
	- implement a assign slider function, which would allow you to assign sliding functionality to already existing MC's
	- implement a vertical assign slider function
	- implement a 'live update' feature which will update the percent properties and call the listeners 'live'
 
 Version:
 .6
 
 Author:
 Michael Bianco, http://mabblog.com/
 
 Date:
 03/22/05
 */

import com.mab.drawing.shapeMaker;

class com.mab.ui.SliderController {
	private static var counter:Number = 0;
	
	/*
	 Property: handle
	 reference to the handle of the slider
	 
	 Property: bar
	 reference to the bar of the slider
	 
	 Property: holder
	 reference to the holder of the slider, valid only for generated sliders
	 
	 Property: padding
	 optional amount to offset the end of the slider range by (negative or positive integer).
	 for example, instead of having the slider handle run to the end of the bar, you could offset it by 15px with the following statement:
	 */
	public var handle:MovieClip;
	public var bar:MovieClip;
	public var holder:MovieClip;
	
	private var vertical:Boolean;
	public var padding:Number;
	
	function SliderController() {
		super();
		
		vertical = false;
		padding = 0;
	}
	
	/*
	 Function: createSlider
	 Easily create a slider UI element. The slider created here has 3 main elements: the holder, slider bar, and the handle
	 
	 ||||||||||||||||||||||||||||||||
	 ||				Handle			|
	 ||			      \/			|
	 ||	  ===========|||==========	|
	 ||		  ^						|
	 ||   Slider Bar				|
	 ||||||||||||||||||||||||||||||||
	 
	 This function should be initially used to make a horizontal slider, to make a vertical slider simple set the _rotation property of the slider to 90
	 
	 
	 The handle property of this class (I.E. slider handle) dispatches one event, "sliderChange". It is called when the slider value has changed. Use addEventListener() to respond to that event.
	 
	 Parameters:
		barOb - a object containing the init properties for the slider bar. It must contain the following:
		- width; the width of the bar. This determines the max slide that the slider can go
		- height; height of the bar
		- color; hex color value for the color of the bar
	 
		handleOb - a object containing the init properties for the 'handle' on the slider bar. It must contain the following:
		- width; width of the bar
		- height; height of the bar
		- color; hex color value for the color of the bar
	 
		initOb - object containing some random init properties. Object must contain the following:
		- x; the x position you want the slider to be placed
		- y; the y position you want the slider to be placed
		- path; MC where you want the slider to be attatched to
	 
	 Returns:
	 MovieClip; a reference to the slider holder
	 */
	function createSlider(barOb:Object, handleOb:Object, initOb:Object):MovieClip {
		// create holder to create the slider components in
		holder = initOb.path.createEmptyMovieClip("_slider_holder"+counter, initOb.path.getNextHighestDepth())
		holder._x = initOb.x;
		holder._y = initOb.y;
				
		//attach the slider components
		bar = shapeMaker.makeBox({_x:0, _y:(handleOb.height - barOb.height)/2, _width:barOb.width, _height:barOb.height, color:barOb.color}, holder, "_slider_bar");
		
		//create the handle
		handle = shapeMaker.makeBox({_x:0, _y:0, _width:handleOb.width, _height:handleOb.height, color:handleOb.color}, holder, "_slider_handle");
		handle.maxWidth = barOb.width - handle._width

		initHandleEvents();
				
		//set the cooridants for the startDrag()
		handle.x = handle._x;
		handle.y = handle._y;
		
		//set the MC name counter
		counter++;
		
		//return a ref to the MC
		return holder;
	}
	
	/*
	 Function: makeSliderFromElements
	 Creates a slider from existing UI elements
	 
	 Parameters:
		b - [MovieClip] reference to the bar of the slider
		h - [MovieClip] reference to the handle of the slider
		v - [Boolean] whether or not the scroller is verically oriented
	 */
	function makeSliderFromElements(b, h, v) {
		handle = h;
		bar = b;
		vertical = v;
		
		// set the initial positions
		handle.x = handle._x;
		handle.y = handle._y;
		
		initHandleEvents();
	}
	
	function initHandleEvents() {		
		handle.initBroadcaster();
		handle._host = this;
		handle.vertical = vertical;
		
		handle.calcMaxPos = function() {
			if(this.vertical) {
				this.maxPos = this._host.bar._height - this._height;
			} else {
				this.maxPos = this._host.bar._width - this._width;
			}
			
			this.maxPos -= this._host.padding;
		}
		
		//set the dragging function
		handle.onPress = function() {
			this.calcMaxPos();
			this._dragging = true;
			
			// start drag defines a rectangle for the dragging restaints
			// depending on the slider orientation, we have to adjust the rectangles coordinants
			if(this.vertical) {
				this.startDrag(false, this.x, this.y, this.x, this.y + this.maxPos);
			} else {
				this.startDrag(false, this.x, this._y, this.x + this.maxPos, this._y);
			}
		}
		
		//set the drop function
		handle.onRelease = function() {
			this._dragging = false;
			this.stopDrag()
			this.dispatchEvent({type:"sliderChange"})
		}
		
		handle.setPercent = function(p) {
			this.calcMaxPos();
			
			// dont change the position while the slider is moving
			if(!this._dragging) {
				if(this.vertical) {
					this._y = (this.y + this.maxPos) * (p / 100);
				} else {
					this._x = (this.x + this.maxPos) * (p / 100);
				}
			}
		}
	}
	
	/*
	 Property: percent
	 The percent value of the position of the slider
	 */
	function get percent() {
		handle.calcMaxPos();

		if(this.vertical) {
			return Math.abs(Math.round(((handle.y - handle._y)/(handle.maxPos - handle._height + padding)) * 100));
		} else {
			return Math.abs(Math.round(((handle.x - handle._x)/(handle.maxPos - handle._width + padding)) * 100));
		}
	}
}	