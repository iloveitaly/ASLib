/*
 Class: Math2
 
 Description:
 Extension of the Math class that provides functions to deal with degree based trig functions
 
 Author:
 Michael Bianco , http://mabwebdesign.com/
 
 Date: 1/28/05
 
 *@TODO:implement trig functions to accept x/y & radius values to calculate a x/y cooridant. 
 *Make documentation.
 *create a better min() function that can take multiple arguments and can take an array of values
 *make a trig array table for sin() cos() and tan() lookups
 */
class com.mab.util.Math2 extends Math {
	static function toRadians(d) {
		return d*(PI/180);
	}
	
	static function toDegrees(r) {
		return r*(180/PI);
	}
	
	static function cosD(x) {
		return cos(Math2.toRadians(x));
	}
	
	static function sinD(y) {
		return sin(Math2.toRadians(y));
	}
	
	static function atan2D(y, x) {
		return Math2.toDegrees(Math.atan2(y, x));
	}
	
	static function asinD(ratio) {
		return Math2.toDegrees(Math.asin(ratio));
	}

	static function acosD(ratio) {
		return Math2.toDegrees(Math.acos (ratio));
	}
}