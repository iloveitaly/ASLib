/*
 Class: com.mab.audio.mp3Player
 
 Description:
 MP3 player implementation. Just bind UI elements to the methods in this class to easily create a working MP3 Player.
 
 Notes:
 Dispatches 2 events:
	- "songChanged" dispatches when the song is changed
 
 This class requires the <mp3Sound> class
 
 Author:
 Michael Bianco, http://mabwebdesign.com/

 Date:
 6/25/05
 */

import com.mab.audio.mp3Sound;

class com.mab.audio.mp3Player {
	/*
	 Variable: songURLs
	 An array of strings specifying the location of the songs to load
	 
	 Variable: songNames
	 An array of strings to be assigned to <mp3Sound.songName> in the <songs> array
	 
	 Variable: songs
	 An array of <mp3Sound> objects that are used to represent the songs that will played using this class.
	 
	 Variable: currSong
	 Index of the song currently being played
	 
	 Variable: prevSong
	 Index of the song previously played
	 */
	
	public var songURLs:Array;
	public var songNames:Array;
	private var songs:Array;
	
	private var currSong:Number = 0;
	private var prevSong:Number;
	
	function mp3Player() {
		super();
		initBroadcaster();

		//init all the arrays
		songURLs = [];
		songNames = [];
		songs = [];
	}
	
	/*
	 Function: next
	 Advances to the next song in the list using <startSongAtIndex>
	 */
	public function next(Void):Void {
		startSongAtIndex(currSong+1);
	}
	
	/*
	 Function: previous
	 Plays the previous song in the playlist.
	 */
	public function previous(Void):Void {
		startSongAtIndex(currSong  -1);
	}
	
	/*
	 Function: pause
	 Pausing the currently playing song
	 */
	public function pause(Void):Void {
		pauseSongAtIndex(currSong);
	}
	
	/*
	 Function: play
	 Starts the MP3 player
	 */
	public function play(Void):Void {
		playSongAtIndex(currSong);
	}
	
	/*
	 Function: songComplete
	 Private listener function, called when a song finishes playing
	 */
	public function songComplete(Void):Void {//once the currently playing song is complete advance to the next song
		playSongAtIndex(currSong+1);
	}
	
	/*
	 Function: startSongAtIndex
	 Starts to play the song located at n. If the song is already loaded, its simply start()ed.
	 If its not loaded, a new <mp3Sound> object is created to represent it.
	 If n is a negative number, the last song in <songURLs> is played, if n is greater than songURLs.length - 1 then the first song is played.
	 After this function is called, a "songChanged" event is dispatched.
	 
	 Parameters:
		n - Number specifying the index of the song to play
	 */
	public function startSongAtIndex(n:Number):Void {
		prevSong = currSong;
		
		if(n < 0) {
			currSong = songURLs.length - 1;
		} else if(n >= songURLs.length) {
			currSong = 0;
		} else {
			currSong = n;
		}
						
		if(songs[currSong]) {
			songs[currSong].start();
		} else {
			var newSong = songs[currSong] = new mp3Sound();
			newSong.loadSound(songURLs[currSong]);
			newSong.songName = songNames[currSong];
			newSong.shouldLoop = false; //dont loop the same song
			newSong.addEventListener("songComplete", this); 		
		}
		
		if(prevSong != currSong) {
			pauseSongAtIndex(prevSong);
		}
		
		dispatchEvent({type:"songChanged"});
	}
	
	/*
	 Function: pauseSongAtIndex
	 Pauses the song at n index in the <song> array.
	 
	 Parameters:
	 
		n - Number which specifies the index of the song to pause in <songs>
	 */
	public function pauseSongAtIndex(n:Number):Void {
		songs[n].pause();
	}
	
	/*
	 Function: playSongAtIndex
	 Plays the song at n. If the song has already started playing, but was stopped, the song is played from the position at which it was stopped
	 
	 Parameters:
		n - Number which specifies the index of the song to play in <songs>
	 */
	public function playSongAtIndex(n:Number):Void {
		if(songs[n]) {
			songs[n].play();
		} else {
			startSongAtIndex(n);
		}
	}
	
	/*
	 Function: setVolume
	 Calls setVolume() on all the objects in <songs> using n as the volume level
	 
	 Parameters:
		v - The volume level you want all the songs to be set at
	 */
	public function setVolume(v:Number):Void {
		
	}
	
	/*
	 Variable: currentSong
	 The <mp3Sound> that is currently playing
	 */
	function get currentSong() {
		return songs[currSong];
	}
}