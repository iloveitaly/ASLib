/*
 Class: com.mab.loading.easingLoader
 
 Description:
 A class that manages loading progress and creates an easing loading effect.
 
 Usage:
 Used to easily display the loading progress of a MC. This class requires the Object method additions along with the Delegate class
 
 Author:
 Michael Bianco, http://developer.mabwebdesign.com/
 
 Version:
 1.1
 */
 
import com.mab.util.Delegate;

class com.mab.loading.easingLoader {
    //MC Refs
    private var loadingTarget:MovieClip;
    private var loadingText:TextField;
    private var loadingBar:MovieClip;
    
    private var loadBarRatio:Number;
    private var percent:Number = 0;
    private var dest:Number;
    public var easeSpeed:Number = 10;
    private var interval:Number;
    
    //BOOLs
    private var pixelFontSafe:Boolean = false; //if true the percent text box always lands on a whole pixel
    private var alphaEffect:Boolean = false; //if true, an alpha effect is applied on the loading bar
	private var changeTextFieldSize:Boolean = true;
    
    /*
	 Function: easingLoader
     Constructor function
	 
	 Arguments:
     b - [MovieClip] the actual bar that you want to represent the progress
     w - [Number] the width ratio that will represent the max width for the bar (IE, 1.5 will make the bar 150px)
	 t - [TextField] optional textfield reference to be used with 
     */
    function easingLoader(b, w, t) {
    	super();
    	initBroadcaster();
     	
    	loadingBar = b;
    	loadBarRatio = w;
		loadingText = t;
    	
    	loadingBar._width = 0;
    }
    
    /*
	 Function: doLoadProgress
	 starts the loading progress
	 
	 Arguments:
     t - [MovieClip] the loadingTarget that will be polled asking how much of it is done loading
     */
    function doLoadProgress(t:MovieClip) {
    	loadingTarget = t;
    	interval = setInterval(Delegate.create(this, _doLoadProgress), Math.round(1000/30));
    }

	/*
	 Function: _doLoadProgress
	 internal loading progress polling function
	 */
    function _doLoadProgress() {
    	updatePercent();
    	updateBar();
		updateText();
    	checkFinished();
    }
    
    /*
	 Function: updatePercent
	 updates the percent class variables by polling loadingTarge for its percent loaded
     */
    function updatePercent(Void) : Number {
		var tempPercent = Math.round(loadingTarget.getBytesLoaded() / loadingTarget.getBytesTotal() * 100);
		if(isNaN(tempPercent)) {//check for NaN
			tempPercent = 0;
		}
		
		dest = loadBarRatio*tempPercent;
		return percent = tempPercent;
    }

    
    /*
	 Function: updateBar
     updates the loadingBar's _width to represent the loading progress
     */
    function updateBar() {
    	loadingBar._width += (dest - loadingBar._width)/easeSpeed;

    	if(alphaEffect) {
    		loadingBar._alpha += (percent - loadingBar._alpha)/easeSpeed;
    	}
    }
	   
    /*
	 Function: updateText
     updates the the text field to represent the loading progress
     */
    function updateText() {
		if(changeTextFieldSize) {
			loadingText._width = Math.round(loadingBar._width);
		}
		
		loadingText.text = Math.round(loadingBar._width/loadBarRatio)+"%";
    }
    
    /*
	 Function: checkFinished
	 checks to see if loadingTarget is done loading & the bar has reached its full width
     */
    function checkFinished() {
		if(percent == 100 && Math.abs(dest-loadingBar._width) < 1) {//once the percent == 100 and the bars animation is done
			setAsFinished();
		}
    }
    
    /*
	 Function: setAsFinished
     Sets the loading bar and the textfield to represent the completed progress
     */
    function setAsFinished() {
		//set all the elements to the done posistion
		loadingBar._alpha = 100;
		loadingBar._width = 100 * loadBarRatio;
		loadingText._width = 100 * loadBarRatio;
		
		//center the text field and say "complete"
		var temp = new TextFormat();
		temp.align = "center";
		loadingText.setNewTextFormat(temp)
		loadingText.text = "Complete";
		
		finished();
    }
    
    /*
	 Function: finished
     calls when the whole loading progress is complete, this function clears the interval timer responsible for the loading animation, and broadcasts a loadingComplete event.
     */
    function finished() {
		clearInterval(interval);
    	dispatchEvent({type:"loadingComplete"});
    }
}