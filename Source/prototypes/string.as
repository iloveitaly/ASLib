/**
 *@class:			String Object Prototypes
 *@author:			Michael Bianco, http://mabwebdesign.com/
 *@description:		prototypes to make working with strings easier
 *@version:			1.0
 **/

/**
 *@description: a find and replace function that will search a string and find all occurances of "search" and replace it with "replace"
 *@param: find, a string, or an array of strings specfying what string(s) you want to find
 *@param: replace, a string, or an array of string specifying what to replace the strings found with.
 *if no value is specified, a empty string ("") replace value is assumed. If there are less entries in the replace array than in the find
 *array, empty string values are assumes for the rest of the replace values. This value is optional.
 *@param: limit, a limit to the amount of times to exacute the find & replace operation. This value is optional.
 *@returns: the string after the find and replace operations have been completed
 **/
String.prototype.findAndReplace = function(find, replace, limit:Number):String {
	var tempString = this, tempParts, pos, loopLength;
	
	if(typeof(find)!=="string") {//then the find and replace is an array
		if(replace === undefined) replace = [""]; //if no replace was specified
		else if(typeof(replace)==="string") replace = [replace]; //if only one replace was specified
	} else {//then they are a string
		//put both of them in array form
		find = [find];
		replace  = [replace];
	}
	
	loopLength = find.length; //determines the loop length
	
	for(var a = 0, c = 0; a<loopLength; a++, c = 0) {
		while((pos = tempString.indexOf(find[a]))!==-1) {
			if(limit!==undefined && c>=limit) break;
			
			//split the array into 3 parts
			tempParts = new Array(tempString.substring(0, pos), tempString.substr(pos, find[a].length), tempString.substr(pos+find[a].length));
			tempParts[1] = (replace[a]===undefined)? ("") : replace[a]; //if there was no replace specified give an empty string
			tempString = tempParts[0]+tempParts[1]+tempParts[2];
			
			c++; //increase the counter
		}
	}
	
	return tempString;
}

/*
 Function: countOf
 Counts the amount of occurances of a character or string in the string
 
 Parameters:
	s - string/character to count the occurances of
 */
String.prototype.countOf = function(s:String):Number {
	var i = 0, c = 0, cpy = this;
	
	while((i = cpy.indexOf(s)) != -1 && c < 20) {
		c++;
		cpy = cpy.substr(i+1);
	}
	
	return c;
}

/**
 *@description: uppercases the first letter of a string
 **/
String.prototype.ucfirst = function():String {
	var firstChar = this.charAt(0);
	firstChar = firstChar.toUpperCase();
	return firstChar + this.substring(1);
}

String.prototype.fullTrim = function():String {
	var s = this;
	
	s = s.split(" ").join("");	//remove whitespace
	s = s.split("\t").join("");	//remove tabs
	s = s.split("\n").join("");	//remove newlines
			
	return s;
}

ASSetPropFlags(String.prototype, null, 1);
