/*
 Class: com.mab.loading.loadingProgress
 
 Author:
 Michael Bianco, http://mabwebdesign.com/
 
 Date: 08/01/05

 Description:
 class to easily retrieve loading progress of a MC/_levelx. Requires <object.as> prototypes
 */

class com.mab.loading.loadingProgress {
	public var percent:Number;
	public var loadingTarget;
	
	/*
	 Function: loadingProgress
	 
	 Description:
	 Constructor function for the loadProgress class
	 
	 Arguments:
	 t - [Number|MovieClip] either a number representing the level to grab the progress from, or a MC reference
	 */
	function loadingProgress(t) {
		super();
		
		loadingTarget = t;
		percent = 0;
	}
	
	/*
	 Function: getPercent
	 
	 Description:
	 gets the loading progress
	 
	 Returns:
	 [Number] the loading progress of the loadingTarget as a percent/float value
	 */
	function getPercent(Void):Number { 
		if(loadingTarget.isMemberOf(MovieClip)) {
			percent = loadingTarget.getBytesLoaded()/loadingTarget.getBytesTotal();
		} else if(loadingTarget.isInstanceOf(Number)) {
			switch(loadingTarget) {
				case 3:
				percent = _level3.getBytesLoaded()/_level3.getBytesTotal();
				break;
				case 2:
				percent = _level2.getBytesLoaded()/_level2.getBytesTotal();
				break;
				case 1:
				percent = _level1.getBytesLoaded()/_level1.getBytesTotal();
				break;
			}
		}
		
		if(isNaN(percent)) {
			percent = 0;
		}
		
		return percent;
	}
}