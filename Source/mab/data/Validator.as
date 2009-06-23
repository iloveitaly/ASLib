/*
Class: com.mab.data.Validator

Description:
Validate various types of data easily.

Usage:
|import com.mab.data.Validator;
|if(Validator.isEmail("hello@gmail.com")) {
|	trace("Its a email!");
|}
|if(Validator.isPhoneNum("666-666-666")) {
|	trace("Its a phone number");
|}

Notes:
Original javascript code aquired from: http://www.actionscript.org/forums/archive/index.php3/t-179.html.
This class required the string additions, specifically the fullTrim() method. 
 
Version:
1.0

Author:
Michael Bianco, http://mabblog.com/

Date:
11/28/05

*/

import com.mab.util.Delegate;

class com.mab.data.Validator {
	public var backing:MovieClip;
	public var typeSpeed:Number = 20;
	public var offAlpha:Number = 50;
	public var incrementSpeed:Number = 5;
	
	private var field:TextField;
	private var checkFunct:Function;
	private var errorMessage:String;
	
	function Validator(tf:TextField, type:String, errMsg:String) {
		super();
		
		field = tf;
		field.onSetFocus = Delegate.create(this, onSetFocus); // TextField's dont broadcast these events
		field.onKillFocus = Delegate.create(this, onKillFocus);
		field.isValid = Delegate.create(this, isValid); // convience reference
		
		errorMessage = errMsg;
		
		switch(type) {
			case "email":
				checkFunct = Validator.isEmail;
				break;
			default:
				checkFunct = Validator.isNotEmpty;
				break;
		}
	}
	
	function isValid() : Boolean {
		var valid = checkFunct(field.text);
		
		if(!valid) {
			if(field.typeWriter) {
				if(!field.isTyping) {
					field.typeWriter(errorMessage, typeSpeed);
				}
			} else { // no fancy effects, just display the text
				field.text = errorMessage;
			}
			
			return false;
		}
		
		return true;
	}
	
	function onSetFocus() {
		backing.incrementTo("_alpha", 100, incrementSpeed);
		
		if(field.text == errorMessage) {
			field.text = "";
		} else if(field.isTyping) {
			field.killTyping()
			field.text = "";
		}
	}
	
	function onKillFocus() {
		backing.incrementTo("_alpha", offAlpha, incrementSpeed);
	}
	
	/*
	 Function: isNotEmpty
	 Checks if a string is not empty. For use in a Validator instance so we can have a reference to a default check function in checkFunct
	 
	 Arguments:
	 str - [String] string to check
	 */
	public static function isNotEmpty(str:String) : Boolean {
		return str.length != 0;
	}
	
	/*
	 Function: isEmail
	 Checks a str to see if its a valid email address.
	 
	 Parameters:
		str - the string to be checked for a valid email address
	 */
	public static function isEmail(str:String):Boolean {
		return ((str != "") && (str.indexOf("@") != -1) && (str.substr(str.indexOf("@")).indexOf(".") != -1));
	}
	
	/*
	 Function: isState
	 Checks if the string specified represents a valid US state
	 
	 Parameters:
		str - str to be checked to see if it represents a valid state
	 */
	public static function isState(str:String):Boolean {
		str = str.toUpperCase();
		return ((str == "AK") || (str == "AL") || (str == "AR") || (str == "AZ") || (str == "CA") || (str == "CO") || (str == "CT") || (str == "DC") || (str == "DE") || (str == "FL") || (str == "GA") || (str == "HI") || (str == "IA") || (str == "ID") || (str == "IL") || (str == "IN") || (str == "KS") || (str == "KY") || (str == "LA") || (str == "MA") || (str == "MD") || (str == "ME") || (str == "MI") || (str == "MN") || (str == "MO") || (str == "MS") || (str == "MT") || (str == "NB") || (str == "NC") || (str == "ND") || (str == "NH") || (str == "NJ") || (str == "NM") || (str == "NV") || (str == "NY") || (str == "OH") || (str == "OK") || (str == "OR") || (str == "PA") || (str == "RI") || (str == "SC") || (str == "SD") || (str == "TN") || (str == "TX") || (str == "UT") || (str == "VA") || (str == "VT") || (str == "WA") || (str == "WI") || (str == "WV") || (str == "WY") );
	}
	
	/*
	 Function: isZipCode
	 
	 Parameters:
	 str - [String] a zip code to check
	 */
	public static function isZipCode(str:String):Boolean {
		var l = str.length;
		if ((l != 5) && (l != 10)) {
			return false;
		}
		
		for (var j = 0; j < l; j++) {
			if ((l == 10) && (j == 5)) {
				if (str.charAt(j) != "-") { return false }
			} else {
				if ((str.charAt(j) < "0") || (str.charAt(j) > "9")) { return false }
			}
		}
		return true;
	}
	
	/*
	 Function: isPhoneNum
	 Checks to see if a string is a valid phone number.
	 This function checks for two types of valid phone numbers:
	 - 666-666-6666
	 - 1234567890
	 
	 Parameters:
		str - str that will be checked for a valid phone number
	 */
	public static function isPhoneNum(str:String):Boolean {
		//str = str.fullTrim();
		if (str.length != 12 && str.length != 10) {
			return false;
		}
		
		if(str.length == 12) {//phone number formatted as 666-666-6666
			for(var j = 0; j < str.length; j++) {
				if ((j == 3) || (j == 7)) {//if there is not a hyphen where their should be
					if (str.charAt(j) != "-") {
						return false;
					}
				} else {
					if ((str.charAt(j) < "0") || (str.charAt(j) > "9")) {//if theres not a number where their should be
						return false;
					}
				}
			}
		} else {//formatted as 6666666666
			for(var j = 0; j < str.length; j++) {
				if(str.charAt(j) < "0" || str.charAt(j) > "9") {//
					return false;
				}
			}
		}
		
		return true;
	}
	
	/*
	 Function: isDate
	 Checks to see if a string represents a valid date
	 
	 */
	public static function isDate(str:String):Boolean {
		if (str.length != 10) {
			return false;
		}
		
		for (var j = 0; j < str.length; j++) {
			if ((j == 2) || (j == 5)) {
				if (str.charAt(j) != "/") { return false }
			} else {
				if ((str.charAt(j) < "0") || (str.charAt(j) > "9")) { return false }
			}
		}
		
		var month = str.charAt(0) == "0" ? parseInt(str.substring(1,2)) : parseInt(str.substring(0,2));
		var day = str.charAt(3) == "0" ? parseInt(str.substring(4,5)) : parseInt(str.substring(3,5));
		var begin = str.charAt(6) == "0" ? (str.charAt(7) == "0" ? (str.charAt(8) == "0" ? 9 : 8) : 7) : 6;
		var year = parseInt(str.substring(begin, 10));
		
		if (day == 0) {
			return false;
		}
		
		if (month == 0 || month > 12) {
			return false;
		}
		
		if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
			if (day > 31) { return false }
		} else {
			if (month == 4 || month == 6 || month == 9 || month == 11) {
				if (day > 30) { return false }
			} else {
				if (year%4 != 0) {
					if (day > 28) { return false }
				} else {
					if (day > 29) { return false }
				}
			}
		}
		return true;
	}
}