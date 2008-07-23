/*
Class: QueryString

Description:
** Description Here... **

Usage:
|usage code here

Notes:
**notes**

Version:
1.0

Author:
Michael Bianco

Date:
7/22/08
*/
	
/*
 Client-side access to querystring name=value pairs
 Version 1.3
 28 May 2008

 License (Simplified BSD):
 http://adamv.com/dev/javascript/qslicense.txt
*/

class com.mab.util.QueryString {
	private var queryString:String;
	private var params:Object;
	
	// optionally pass a querystring to parse
	function QueryString(qs:String) {	
		queryString = qs;
		params = {};
		
		// Turn <plus> back to <space>
		// See: http://www.w3.org/TR/REC-html40/interact/forms.html#h-17.13.4.1
		qs = qs.findAndReplace('+', ' ');
		var args = qs.split('&'); // parse out name/value pairs separated via &
		
		// split out each name=value pair
		for (var i = 0; i < args.length; i++) {
			var pair = args[i].split('=');
			var name = unescape(pair[0]);
			
			var value = (pair.length == 2) ? unescape(pair[1]) : name;
			params[name] = value;
		}
		
		com.mab.util.debug.dumpObject(params);
	}
	
	public function getString() : String {
		return queryString;	
	}
	
	public function get(key) {
		return (params[key] != null) ? params[key] : "";
	}
	
	public function contains(key) {
		return (params[key] != null);
	}
	
	public function copy(object:Object) {
		for(var i in params) {
			object[i] = params[i];
		}
	}
}