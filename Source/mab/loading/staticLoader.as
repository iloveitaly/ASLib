/*
 Class: com.mab.loading.staticLoader
 
 Description:
 Used to easily creater loader bars. easingScroller has much nicer effects, but this is simple and effective. Requires <Object>
 
 Author:
 Michael Bianco, http://mabblog.com/
 */

import com.mab.loading.loadingProgress;
import com.mab.util.Delegate;

class com.mab.loading.staticLoader {
	public var loadingBar:MovieClip;
	public var loadingTarget:MovieClip;
	
	public var progress:com.mab.loading.loadingProgress;
	public var updateFunct:Function;
	private var loadBarWidth:Number;
	private var interval:Number;
	
	/*
	 Function: staticLoader
	 
	 Description:
	 Constructor function
	 
	 Arguments:
	 b - the actual bar that you want to represent the progress
	 w - the width ratio that will represent the max width for the bar
	 */
	function staticLoader(b, r) {
		super();
		initBroadcaster();
		
		loadingBar = b;
		loadingBar._width = 0;
		loadBarWidth = r;
	}
	
	function doLoadProgressWith(t:MovieClip) {
		progress = new loadingProgress(loadingTarget = t);
		interval = setInterval(Delegate.create(this, _doLoadProgress), Math.round(1000/30));
	}
	
	private function _doLoadProgress() {
		updatePercent();
		updateFunct();
		updateBar();
	}
	
	function updatePercent() {
		if(progress.getPercent() == 1) {
			setAsFinished();
		}
	}
	
    /*
	 Function: updateBar
	 
     Description:
	 updates the loadingBar's _width to represent the loading progress
     */
    function updateBar() {
		loadingBar._width = progress.percent*loadBarWidth;
	}
	
	/*
	 Function: setAsFinished
	 
	 Description:
	 sets the loading bar and the textfield to represent the completed progress
	 */
	function setAsFinished() {
		finished();
	}
	
    /*
	 Function: finished
	 
     Description:
	 Is called when the whole loading progress is complete, this function clears the interval timer responsible for the loading animation, and broadcasts a loadingComplete event.
     */
    function finished() {
		clearInterval(interval);
    	dispatchEvent({type:"loadingComplete"});
    }
}