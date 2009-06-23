/*
 Class: com.mab.util.colorConverter
 
 Description:
 Class to make converting rgb values to hex values easier
 
 Author:
 Michael Bianco, http://mabwebdesign.com/
 
 Version:
 1.0
 */
 
class com.mab.util.colorConverter {
	/*
	 Function: toHex
	 Converts an rgb color value to a hex value
	 
	 Parameters:
		r - the red value of the color to convert. This number must be between 0-255
		g - the green value of the color to convert. This number must be between 0-255
		b - the blue value of the color to convert. This number must be between 0-255
	 
	 Return:
	 String; The hex equivilent of the rgb value given
	 */
	static function toHex(r:Number, g:Number, b:Number):String {
		var R, G, B;
		R = r.toString(16);
		G = g.toString(16);
		B = b.toString(16);
		//for some odd reason the toString() function is quirky and wont convert
		//0s to 2 0s also has some trouble with other double things
		//had a problem with my own fix for this (displayed at the bottom) so i used some code from
		//http://actionscript-toolbox.com/colorobject2.php
		while(R.length < 2) {
        	R = "0"+R;
        }
		
        while(G.length < 2) {
        	G = "0"+G;
        }
		
        while(B.length < 2) {
        	B = "0"+B;
        }
		
		return "0x"+R.toUpperCase()+G.toUpperCase()+B.toUpperCase();
	}
	
	/*
	 Function: toRGB
	 Converts a hex value to its RGB equivilent
	 
	 Parameters:
		hex - A string or number hex value
	 
	 Returns:
	 Object; The object contains 3 variables: r, g, and b which are the red, green, and blue values of the hex value given
	 */
	static function toRGB(hex):Object {
		if(hex instanceof String) hex = new Number(hex);
		
        var red = hex>>16;
        var grnBlu = hex-(red<<16);
        var grn = grnBlu>>8;
        var blu = grnBlu-(grn<<8);
        return {r:red, g:grn, b:blu};
	}
}