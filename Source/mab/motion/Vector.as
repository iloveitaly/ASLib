/*  
  This is a custom object designed to represent vectors and points
  in two-dimensional space. Vectors can added together,
  scaled, rotated, and otherwise manipulated with these methods.
  
  Dependencies: Math.sinD(), Math.cosD(), Math.acosD() (included below)
  
  Discussed in Chapter 4 of 
  Robert Penner's Programming Macromedia Flash MX
  
  http://www.robertpenner.com/profmx
  http://www.amazon.com/exec/obidos/ASIN/0072223561/robertpennerc-20
*/

import com.mab.util.Math2;

class com.mab.motion.Vector {
	public var x:Number;
	public var y:Number;
	
	function Vector(xx, yy) {
		x = xx;
		y = yy;
	}
	
	function toString() {
		var rx = Math.round (x * 1000) / 1000;
		var ry = Math.round (y * 1000) / 1000;
		return "[" + rx + ", " + ry + "]";
	}
	
	function reset(xx, yy) {
		x = xx;
		y = yy;
	}
	
	function getClone() {
		return new Vector (x, y);
	}
	
	function plus(v) {
		x += v.x;
		y += v.y;
	}
	
	function plusNew(v) {
		return new Vector (x + v.x, y + v.y);    
	}
	
	function minus(v) {
		x -= v.x;
		y -= v.y;
	}
	
	function minusNew(v) {
		return new Vector (x - v.x, y - v.y);    
	}
	
	function negate() {
		x = -x;
		y = -y;
	}
	
	function negateNew(v) {
		return new Vector (-x, -y);    
	}
	
	function scale(s) {
		x *= s;
		y *= s;
	}
	
	function scaleNew(s) {
		return new Vector (x * s, y * s);
	}
	
	function getLength() {
		return Math.sqrt(x*x + y*y);
	}
	
	function setLength(len) {
		var r = getLength();
		if (r) scale (len / r);
		else x = len;
	}
	
	function getAngle() {
		return Math2.atan2D (y, x);
	}
	
	function setAngle(ang) {
		with (this) {
			var r = getLength();
			x = r * Math2.cosD (ang);
			y = r * Math2.sinD (ang);
		}
	}
	
	function rotate(ang) {
		var ca = Math2.cosD (ang);
		var sa = Math2.sinD (ang);
		var rx = x * ca - y * sa;
		var ry = x * sa + y * ca;
		x = rx;
		y = ry;
	}
	
	function rotateNew(ang) {
		var v = new Vector (x, y);
		v.rotate(ang);
		return v;
	}
	
	function dot(v) {
		return x * v.x + y * v.y;
	}
	
	function getNormal() {
		return new Vector (-y, x); 
	}
	
	function isNormalTo(v) {
		return (dot (v) == 0);
	}
	
	function angleBetween(v) {
		var dp = dot (v); // find dot product
		// divide by the lengths of the two vectors
		var cosAngle = dp / (getLength() * v.getLength());
		return Math2.acosD(cosAngle); // take the inverse cosine
	}
}
