/*
 Class: com.mab.util.quickLoader
 
 Description:
 Simple LoadVars subclass to allow quick loading/sending of variables.
 
 Broadcasts the onLoad event
 
 Author:
 Michael Bianco
 
 Date:
 06/07/05
 */
 
class com.mab.util.quickLoader extends LoadVars {
	/*
	 Variable: requireSuccess
	 [BOOL] Determines if the dispatchEvent() & __complete() are dispatched when the loading fails, false by default.
	 */
	public var requireSuccess = false;

	/*
	 Function: quickLoader
	 
	 Arguments:
		onLoad - [Function] event handler for when the quickLoader recieved data
		args - [Array] array of arguments/variables to 'write' to the quickLoader (IE POST variables you want to send)
		url - [String] the url to send the data/request to
		method - [String] function to use for sending data (IE "sendAndLoad")
		sendMethod - [String] for the sending methods that have this option ("POST", "GET") 
	 */
	function quickLoader(ob) {
		super();
		initBroadcaster();
		
		if(ob) {
			addEventListener("onLoad", ob);
			
			if(ob.args && ob.url && ob.method) {
				setVars.apply(this, ob.args);
				this[ob.method].apply(this, [ob.url, this, ob.sendMethod ? ob.sendMethod : null]);
			}
		}
	}
	
	/*
	 Function: setVars
	 
	 Description:
	 Quickly set arguments for a send() operation
	 
	 Arguments:
	 ... - each argument should be an array with two elements, the [0] element should be a string 
	 representing the name of the variable you want to write to the quickLoader() object the [1] element should be the value of the variable. 
	 
	 Example:
	 |var loader = new quickLoader()
	 |loader.setVars(["var1", 10], ["var2", 20]);
	 */
	function setVars() {
		for(var a = 0; a < arguments.length; a++) {
			this[arguments[a][0]] = arguments[a][1];
		}
	}
	
	function onLoad(success) {
		if(success || !requireSuccess) {
			this.__complete();
			this.dispatchEvent({type:"onLoad"});		
		}
	}
	
	/*
	 Function: send
	 
	 Arguments:
	 args - a two demensional array of arguments to be passed to setVars(). This is optional.
	 */
	function send(url, method, args) {
		if(args) {
			setVars.apply(this, args)
		}
		
		super.send(url, method);
	}
	
	/**
	 *@param: args, a two demensional array of arguments to be passed to setVars(). This is optional.
	 **/
	function sendAndLoad(url, method, args) {
		if(args) {
			setVars.apply(this, args);
		}
		
		super.sendAndLoad(url, this, method);
	}
	
	/*
	 Function: __complete
	 
	 Description:
	 called when the loading is complete. Overide in subclasses.
	 */
	function __complete(){}
}