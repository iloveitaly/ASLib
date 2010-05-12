/*
Class: mab.drawing.shapeMaker

Description:
Create shapes with ease

Usage:
Use the static functions of this class to create shapes. This class requires the Math2 class.

ToDo:
Complete the makeGrid() function

Notes:
**notes**

Version:
1.0

Author:
Michael Bianco, http://mabblog.com/

Date:
11/8/05

*/

package mab.drawing {
	import flash.display.*;
	import flash.geom.*;
	
	public class ShapeMaker extends Object {
		/*
		 Property: circles
		 An array of all the circles created
		 
		 Property: triangles
		 An array of all the triangles created
		 
		 Property: boxes
		 An array of all the boxes created
		 */
		public static var circles:Array = [];
		public static var triangles:Array = [];
		public static var boxes:Array = [];
		
		/*
		 Function: makeBox
		 Create a sharp-edged box during runtime
		 
		 Parameters:
		 propOb - a object containing the following properties:
		 
		 color, the color of the box. Must be hex value.	
			
		 _x, the x cooridnant the box should be drawn	
				
		 _y, the y cooridnant the box should be drawn	
				
		_width, the width of the box		
							
		 _height, the height of the box		
							
		 path - path to the MC which the box should be attatched to
		 name - name of the box to be drawn
		 
		 Returns:
		 A reference to the created MC
		 */
		static public function makeBox(props:Object) : Sprite {			
			var newBox:Sprite = new Sprite();
			
			// set the default color to white
			if(props.color == undefined)
				props.color = 0xFFFFFF;
			
			newBox.x = props.x;
			newBox.y = props.y;
			
			newBox.graphics.beginFill(props.color);
			
			if(props.cornerRadius == undefined) {
				newBox.graphics.drawRect(0, 0, props.width, props.height);
			} else {
				newBox.graphics.drawRoundRect(0, 0, props.width, props.height, props.cornerRadius);
			}
			
			boxes.push(newBox);
			
			return newBox;
		}
		
		/*
		 Function: makeGradientBox
		 Create a box filled with a gradient
		 
		 Parameters:
		 propOb - a object containing the following properties:
		 
		 color, the color of the box. Must be hex value.	
		 
		 x, the x cooridnant the box should be drawn	
		 
		 y, the y cooridnant the box should be drawn	
		 
		 width, the width of the box		
		 
		 height, the height of the box
		 
		 fromAlpha, the starting alpha value of the gradient
		 
		 toAlpha, the ending alpha value of the gradient
		 
		 fromColor, the starting color value of the gradient
		 
		 toColor, the ending color value of the gradient
		 
		 Returns:
		 A reference to the created Sprite
		 */
		
		static public function makeGradientBox(props:Object) : Sprite {
			// grabbed some of the code from: http://snipplr.com/view.php?codeview&id=7050
			
			if(props.fromColor == undefined && props.toColor == undefined) {
				props.fromColor = props.toColor = props.color;
			}
			
			if(props.fromAlpha == undefined && props.toAlpha == undefined) {
				props.fromAlpha = props.toAlpha = 100;
			}
			
			if(props.rotation == undefined) {
				props.rotation = 0;	
			}
			
			var gradType:String = GradientType.LINEAR;
			
			var colors:Array = [ props.fromColor, props.toColor ];
			var alphas:Array = [ props.fromAlpha, props.toAlpha ];
			
			// color distribution ratios.  
			// The value defines percentage of the width where the color is sampled at 100%
			var ratios:Array = [ 0, 255 ];
			
			// the matrix defines the spread of the colors through the object
			var matr:Matrix = new Matrix();
			matr.createGradientBox(props.width, props.height, props.rotation, 0, 0);
			
			var gradBox:Sprite = new Sprite();
			var g:Graphics = gradBox.graphics;
			g.beginGradientFill(gradType, colors, alphas, ratios, matr, SpreadMethod.PAD);
			g.drawRect(0, 0, props.width, props.height);
						
			return gradBox;
		}
		

#ifdef DUMBNESS
		static public function makeEmptyBox(propOb:Object, path:MovieClip, name:String) : MovieClip {
			var ref = path.createEmptyMovieClip(name, path.getNextHighestDepth());
			
			if(propOb.color == undefined)
				propOb.color = 0xFFFFFF;
			
			if(propOb.scale == undefined)
				propOb.scale = "normal";
			
			if(propOb.hinting == undefined)
				propOb.hinting = true;
			
			if(propOb.capsStyle == undefined)
				propOb.capsStyle = "round";
			
			ref._x = propOb._x;
			ref._y = propOb._y;

			ref.lineStyle(propOb.thickness, propOb.color, 100, propOb.hinting, propOb.scale, propOb.capsStyle);
			ref.moveTo(0, 0);
			ref.lineTo(0, propOb._height);
			ref.lineTo(propOb._width, propOb._height);
			ref.lineTo(propOb._width, 0);
			ref.lineTo(0, 0);
			
			boxes.push(ref);
			
			return ref;
		}
				
		static public function makeBitmapBox(propOb:Object, path:MovieClip, name:String) : MovieClip {
			var ref = path.createEmptyMovieClip(name, path.getNextHighestDepth());
			
			ref.beginBitmapFill(propOb.bitmap, propOb.transform, null, propOb.smoothing);
			ref.moveTo(0, 0);
			ref.lineTo(propOb._width, 0);
			ref.lineTo(propOb._width, propOb._height);
			ref.lineTo(0, propOb._height);
			ref.endFill();
		
			return ref;
		}
		
		/*
		 Function: makeCircle
		 Creates a circle at runtime
		 
		 Parameters:
		 propOb - an object containing the properties of the circle, it must contain:
		 
		 _x, x position of the circle

		 _y, y position of the circle
		 
		 color, hex value of the color of the circle
		 
		 radius, radius of the circle
		 
		 _width, width of the circle
		 
		 _height, height of the circle

		 path - path of the movieClip to attach the circle to
		 name - a string representing the name of the MC to create in path
		 
		 Returns: a reference to the circle created
		 **/
		static function makeCircle(propOb, path, name) {
			var ref = path.createEmptyMovieClip(name, path.getNextHighestDepth());
			var offset = propOb.radius;
			
			ref._x = propOb._x;
			ref._y = propOb._y;
			
			ref.beginFill(propOb.color, 100)
			ref.moveTo(Math2.cosD(0)*propOb.radius + offset, Math2.sinD(0)*propOb.radius + offset)
			
			for(var angle = 0, x, y; angle<=362; angle+=2) {
				x = Math2.cosD(angle)*propOb.radius + offset;
				y = Math2.sinD(angle)*propOb.radius + offset;
				ref.lineTo(x, y);
			}
			
			ref.endFill();
			
			circles.push(ref);
			
			return ref;
		}

		static function makeEmptyCircle(propOb, path:MovieClip, name:String) {
			var ref = path.createEmptyMovieClip(name, path.getNextHighestDepth());
			
			// keep the registration point at the upper left
			var offset = propOb.radius + propOb.thickness/2;
			
			ref._x = propOb._x;
			ref._y = propOb._y;
			
			ref.lineStyle(propOb.thickness, propOb.color);
			ref.moveTo(Math2.cosD(0)*propOb.radius + offset, Math2.sinD(0)*propOb.radius + offset);
			
			for(var angle = 0, x, y; angle <= 362; angle+=2) {
				x = Math2.cosD(angle)*propOb.radius;
				y = Math2.sinD(angle)*propOb.radius;
				ref.lineTo(x + offset, y + offset);
			}
						
			circles.push(ref);
				
			return ref;		
		}

		static public function makeTrap(propOb, path:MovieClip, name:String) : MovieClip {
			var ref = path.createEmptyMovieClip(name, path.getNextHighestDepth());
			
			// set the default color to white
			if(propOb.color == undefined) propOb.color = 0xFFFFFF;
			
			ref._x = propOb._x;
			ref._y = propOb._y;
			
			var padd = (propOb.w1 - propOb.w2)/2;

			ref.beginFill(propOb.color, 100);
			ref.moveTo(0, propOb._height);
			ref.lineTo(propOb.w1, propOb._height);
			ref.lineTo(propOb.w2 + padd, 0);
			ref.lineTo(padd, 0);
			ref.lineTo(0, propOb._height);
			ref.endFill();
			
			return ref;
		}
		
		/**
		 *@description: creates a traingle
		 *@param: propOb, object containing the following properties:
		 *************************************
		 *@param: w, the width of the triangle base. 
		 *(equivilent to the adjacent or opposite traingle side depending on the _rotation of the triangle)
		 *This function determines the width from drawing from (0, 0) to (w, 0)
		 *@param: h, the height of the triangle.
		 *This function determines the height of the triangle by using cos(x) and sin(y) mutiplied
		 *against the height. The hieght could then be thought of as the radius
		 *@param: angle, the angle of the triangle. This will be used by the cos() and sin() functions
		 *@param: _x, the x position of the MC
		 *@param: _y, the y posistion of the MC
		 *@param: color, hex value of the color of the MC
		 **************************************
		 *@param: path, path to attach the traingle to
		 *@param: name, the name to be assigned to the attatched MC
		 *@returns: a reference to the MC
		 *@note: use the _rotation property to change the traingles position
		 **/
		static function makeTriangle(propOb, path, name) {
			var ref;
			ref = path.createEmptyMovieClip(name, path.getNextHighestDepth());
			
			ref._x = propOb._x;
			ref._y = propOb._y;
			
			ref.beginFill(propOb.color);
			ref.moveTo(0, 0);
			ref.lineTo(propOb.w, 0);
			ref.lineTo(Math2.cosD(propOb.angle)*propOb.h, Math2.sinD(propOb.angle)*propOb.h)
			ref.lineTo(0, 0);
			ref.endFill();
			
			triangles.push(ref)
			
			return ref;
		}
		
		/**
		 *@description: makes a grid using a specified or drawn object
		 *@param: propOb, an object containing the following properties:
		 ******************
		 *@param: maxRows, the max amount of rows of objects to create
		 ******************
		 **/
		static function makeGrid(propOb, path) {
			var r = 0, c = 0, padding = propOb.padding, x = 0, y = 0, firstGridObject,
			gridObName, tempRefs = [[]];
			
			if(propOb.customObject) {//if we have a custom object make the first object in the grid so we can duplicate it
				tempRefs[r][c] = firstGridObject = path.attachMovie(propOb.customObject, propOb.customObject+"_"+r+"_"+c, path.getNextHighestDepth(), {
					__rootname:propOb.customObject,
					__column:c,
					__row:r,
					__maxRows:propOb.maxRows,
					__maxCols:propOb.maxColumns,
					_width:propOb.size,
					_height:propOb.size,
					_x:x,
					_y:y
				});
				
				//fake the end of the for loop
				c++;
				x += propOb.size+padding;
				gridObName = propOb.customObject;
			} else {//implement making a default box in the future
			
			}
			
			for(r = 0; r<propOb.maxRows; c++, x+=propOb.size+padding) {
				if(c == propOb.maxColumns) {
					tempRefs[++r] = []; //add a new array to the references
					x = -(propOb.size+padding); //counter act the increment at the end of the loop
					y += propOb.size+padding;
					c = -1; //it will be incremented++ so it will become 0
					continue;
				}

				tempRefs[r][c] = firstGridObject.duplicateMovieClip(propOb.customObject+"_"+r+"_"+c, path.getNextHighestDepth(), {
					__rootname:gridObName,
					__column:c,
					__row:r,
					__maxRows:propOb.maxRows,
					__maxCols:propOb.maxColumns,
					_x:x,
					_y:y
				});			
			}
			
			return tempRefs;
		}
		
#endif
	}
}