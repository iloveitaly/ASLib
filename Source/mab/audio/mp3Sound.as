/*
 Class: com.mab.audio.mp3Sound
 
 Description:
 Representation of an mp3 file, this class should be used in accordance with a mp3player
 
 ToDo:
	- add a function that allows the user to set at runtime whether or not the music should repeat or not
	- add a function to retrieve the amount of seconds the song has played

 Author:
 Michael Bianco, http://mabwebdesign.com/
 
 Date:
 1/22/05
 
 */

class com.mab.audio.mp3Sound extends Sound {
	/*
	 Variable: counter
	 Used for the naming of some movieclips
	 
	 Variable: shouldStream
	 Bool, determines whether or not to stream the song
	 
	 Variable: shouldLoop
	 Bool, whether or not to loop the song once its been played
	 
	 Variable: songIsLoaded
	 Bool, whether or not the song is loaded
	 
	 Variable: isPaused
	 Bool, whether or not the song is paused
	 
	 Variable: pausePos
	 Position is miliseconds of when the song was paused
	 
	 Variable: progressLoader
	 Path to the progress bar updater
	 
	 Variable: sliderSync
	 Path to the slider syncher
	 
	 Variable: sliderHandle
	 path to the slider handle
	 
	 Variable: songName
	 Imaginary id3 information, since the flash id3 information doesn't work correctly
	 */
	private static var counter:Number = 0; //
	
	//BOOL's
	private var shouldStream:Boolean = true; //
	private var shouldLoop:Boolean = true; //
	public var songIsLoaded:Boolean = false; //
	private var isPaused:Boolean = false; //

	private var pausePos:Number = 0; //
	
	//MC refs
	private var progressLoader; //
	private var sliderSync; //
	private var sliderHandle; //
	
	//
	private var songName:String;
	
	function mp3Sound() {
		super();

		initBroadcaster();
	}
	
	/*
	 Function: loadSound
	 Alias function for <loadSong>.
	 
	 
	 Parameters:
	 url - a string to the target URL	 
	 */
	function loadSound(url) {
		loadSong(url);
	}
	
	/*
	 Function: loadSong
	 loads a song from the specified URL
	 
	 Parameters:
		url - a string to the target URL
	 */
	function loadSong(url) {
		songIsLoaded = false
		super.loadSound(url, shouldStream)
	}
	
	/*
	 Function: onSoundComplete
	 Called when the playing of the sound is complete, if the <shouldLoop> variable is true the song it will loop.
	 This function dispatches the songComplete event
	 */
	function onSoundComplete() {
		if(shouldLoop) {//if long looping is enables loop the song
			start();
		}
		
		dispatchEvent({type:"songComplete"});
	}
	
	/*
	 Function: onLoad
	 Called when the loading of all the song is complete and sets the <songIsLoaded> variable.
	 */
	function onLoad(success) {
		songIsLoaded = success;
	}
	
	/*
	 Function: setProgressBar
	 Function to set the target progress bar to monitor the loading progress of the sound
	 
	 Parameters:
		bar - path to the target progress bar
		maxWidth - number determining the max width for the progress bar
	 */
	function setProgressBar(bar, maxWidth:Number) {
		//create and define variables for the progress loader
		progressLoader = _root.createEmptyMovieClip("__sound_progress__"+counter, _root.getNextHighestDepth());
		progressLoader._path = bar;
		progressLoader._maxWidth = maxWidth;
		progressLoader._host = this;
		
		//assign the onEnterFrame event to handle the loading
		progressLoader.onEnterFrame = function() {
			if(this._host.percentLoaded == 100 && this._host.songIsLoaded) {
				this._path._width = this._maxWidth
				this.removeMovieClip();
			} else {
				if(this._host.percentLoaded!=0) //0 will give us a abnormal width
					this._path._width = this._maxWidth*(this._host.percentLoaded/100)
			}
		}
		
		counter++; //increase the usage counter
	}
	
	/*
	 Function: setSliderHandle
	 Sets a target slider handle to allow the slider to be synced with the progress of the song. 
	 The target slider must implement the setPercent() method which sets the slider a percent of its total slide area
	 
	 Parameters:
		s - path to slider
	 */
	function setSliderHandle(s) {
		//inits the slider synch MC and vars
		sliderHandle = s;
		sliderSync = _root.createEmptyMovieClip("__slider_sync"+counter, _root.getNextHighestDepth());
		sliderSync._host = this;
		sliderSync._path = s;
		
		//sets the slider sync's onenterframe syning function
		sliderSync.onEnterFrame = function() {
			this._path.setPercent(this._host.percentPlayed)
		}
		
		counter++;
	}
		
	/*
	 Function: sliderChange
	 Event function called when the position of the slider is changed.
	 The sender of the event must have a percent variable
	 */
	function sliderChange(eventObject) {
		playAtPercent(eventObject.target.percent)
	}
	
	/*
	 Function: pause
	 Stops the playing of the mp3
	 */
	function pause() {
		isPaused = true;
		pausePos = position; //value in miliseconds
		super.stop(); //for some reason i need to call super also
	}
		
	/*
	 Function: play
	 Plays the song from the previously stopped position
	 */
	function play() {
		if(isPaused) {//check to make sure the song is paused
			start(Math.round(pausePos/1000)); //converts miliseconds to seconds
			isPaused = false;
		}
	}
	
	/*
	 Function: playAtPercent
	 Plays the song at the position determined at the percent
	 */ 
	function playAtPercent(num) {
		start((Math.round(duration/1000)*num)/100)
	}
	
	/*
	 Function: percentPlayed
	 Gets a representation in percent of how much of the song has been played
	 */
	function get percentPlayed() {
		//mutiply the amount of bytes loaded because duration does not truly represent the total time if the 
		//song is not done loading
		return Math.round(((position/duration)*(getBytesLoaded()/getBytesTotal()))*100);
	}
	
	/*
	 Function: percentLoaded
	 Gets a percent value of the amount of the song loaded
	 */
	function get percentLoaded() {
		return Math.round((getBytesLoaded()/getBytesTotal())*100);
	}
	
	/*
	 Function: getSongLength
	 Gets a representation in seconds of how long of the song has been played
	 */
	function getSongLength() {
		return Math.round(duration/1000);
	}
	
	/*
	 Function: getSongName
	 Get the id3 song name information
	 */
	function getSongName() {
		return songName;
	}
}