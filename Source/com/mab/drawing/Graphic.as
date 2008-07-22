class com.mab.drawing.Graphic extends MovieClip{
	var mc;
	var color:String;
	var fill:String;
	var thick:Number;
	
	// constructor
	public function Graphics(depth:Number) {
		_root.createEmptyMovieClip("test1", depth);
		mc = _root.test1;
		// set defaults
		color = "0x000000";
		thick = 1;
		fill = "0x666666";
	}
	
	// setters
	function setColor(_color:String) {
		color = _color;
	}
	
	// set thickness
	function setThick(_thick:Number) {
		thick = _thick;
	}
	
	// set fill
	function setFill(_fill:String) {
		fill = _fill;
	}
	
	//change depth
	function changeDepth(_depth:Number){
	mc.swapDepths(_depth);
	}
//
//drawing functions
function drawLine(x1:Number, y1:Number,
				 x2:Number, y2:Number) {
	mc.lineStyle(thick, color);
	mc.moveTo(x1, y1);
	mc.lineTo(x2, y2);
}
function drawRect(x1:Number, y1:Number, 
			width:Number, height:Number) {
	mc.lineStyle(thick, color);
	mc.moveTo(x1, y1);
	mc.lineTo(x1+width, y1);
	mc.lineTo(x1+width, y1+height);
	mc.lineTo(x1, y1+height);
	mc.lineTo(x1, y1);
}
// fillRect
function fillRect(x1:Number, y1:Number, 
		width:Number, height:Number) {
		mc.lineStyle(thick, color);
		mc.moveTo(x1, y1);
		mc.beginFill(fill);
		mc.lineTo(x1+width, y1);
		mc.lineTo(x1+width, y1+height);
		mc.lineTo(x1, y1+height);
		mc.lineTo(x1, y1);
		mc.endFill();
	}
	//	------	DRAW CURVE	------- //
	
	function drawCurve(startX:Number,startY:Number,
	curveControlX:Number,curveControlY:Number,
	endX:Number,endY:Number)
	{
		mc.lineStyle(thick,color);
		mc.moveTo(startX,startY);
		mc.curveTo(curveControlX,curveControlY,endX,endY);
	}
	
	// draw Oval
	function drawOval(x:Number,y:Number, 
		width:Number,height:Number){
		mc.lineStyle(thick, color);
		mc.moveTo(x,y+height/2);
		mc.curveTo(x,y,x+width/2, y);
		mc.curveTo(x+width,y,x+width, y+height/2);
		mc.curveTo(x+width,y+height, x+width/2, y+height);
		mc.curveTo(x,y+height, x, y+height/2);
	}
	// ---------	FILL OVAL	------------	//
	function fillOval(x:Number,y:Number,
			 width:Number,height:Number){
		mc.lineStyle(thick, color);
		mc.moveTo(x,y+height/2);
		mc.beginFill(fill);
		mc.curveTo(x,y,x+width/2, y);
		mc.curveTo(x+width,y,x+width, y+height/2);
		mc.curveTo(x+width,y+height, x+width/2, y+height);
		mc.curveTo(x,y+height, x, y+height/2);
		mc.endFill();
	}
	//	---------	DRAW CIRCLE-----------	//
	//if argument styleMaker == 22.5 you get a full circle 
	//	66 makes a star like figure
	//	usage :	 drawCircle(radius,x,y,22.5)
	function drawCircle(r:Number,x:Number,y:Number){
		var styleMaker:Number = 22.5;
		mc.moveTo(x+r,y);
		mc.lineStyle(thick, color);
		var style:Number = Math.tan(styleMaker*Math.PI/180);
		for (var angle:Number=45;angle<=360;angle+=45){
		 var endX:Number = r * Math.cos(angle*Math.PI/180);
		 var endY:Number = r * Math.sin(angle*Math.PI/180);
		 var cX:Number	 = endX + r* style * Math.cos((angle-90)*Math.PI/180);
		 var cY:Number	 = endY + r* style * Math.sin((angle-90)*Math.PI/180);
		 mc.curveTo(cX+x,cY+y,endX+x,endY+y);
		}
	}
	// ---------	DRAW FILLED circle, ----------- //
	//if argument styleMaker == 22.5 you get a full circle 
	//	  66 makes a star like figure
	// usage :	fillCircle(radius,x,y,22.5)
function fillCircle(r:Number,x:Number,y:Number){
	var styleMaker:Number = 22.5;
	mc.moveTo(x+r,y);
	mc.lineStyle(thick, color);
	mc.beginFill(fill)
	var style:Number = Math.tan(styleMaker*Math.PI/180);
	for (var angle:Number=45;angle<=360;angle+=45){
	 var endX:Number = r * Math.cos(angle*Math.PI/180);
	 var endY:Number = r * Math.sin(angle*Math.PI/180);
	 var cX:Number	 = endX +
	  r* style * Math.cos((angle-90)*Math.PI/180);
	 var cY:Number	 = endY + 
	 r* style * Math.sin((angle-90)*Math.PI/180);
	 mc.curveTo(cX+x,cY+y,endX+x,endY+y);
	}
	mc.endFill();
	}
	//	----- DRAW helix shape ---	//
	//	if argument styleMaker == 22.5 you get a full circle 
	//	66 makes a star like figure
	//	usage :	 drawCircle(radius,x,y,22.5)
function drawHelix(r:Number,x:Number,y:Number,styleMaker:Number){
	mc.moveTo(x+r,y);
	mc.lineStyle(thick, color);
	var style:Number = Math.tan(styleMaker*Math.PI/180);
	for (var angle:Number=45;angle<=360;angle+=45){
	 var endX:Number = r * Math.cos(angle*Math.PI/180);
	 var endY:Number = r * Math.sin(angle*Math.PI/180);
	 var cX:Number	 = endX + 
	 r* style * Math.cos((angle-90)*Math.PI/180);
	 var cY:Number	 = endY +
	  r* style * Math.sin((angle-90)*Math.PI/180);
	 mc.curveTo(cX+x,cY+y,endX+x,endY+y);
	}
}
	// ---------	DRAW FILLED helix SHAPE, -----------	//
	//if argument styleMaker == 22.5 you get a full circle 
	//	  66 makes a star like figure
	// usage :	fillCircle(radius,x,y,22.5)
function fillHelix(r:Number,x:Number,y:Number,styleMaker:Number){
	mc.moveTo(x+r,y);
	mc.lineStyle(thick, color);
	mc.beginFill(fill)
	var style:Number = Math.tan(styleMaker*Math.PI/180);
	for (var angle:Number=45;angle<=360;angle+=45){
	 var endX:Number = r * Math.cos(angle*Math.PI/180);
	 var endY:Number = r * Math.sin(angle*Math.PI/180);
	 var cX:Number	 = endX + 
	 r* style * Math.cos((angle-90)*Math.PI/180);
	 var cY:Number	 = endY + 
	 r* style * Math.sin((angle-90)*Math.PI/180);
	 mc.curveTo(cX+x,cY+y,endX+x,endY+y);
	}
	mc.endFill();
}

	//	--------------	DRAW GRADIENT SHAPE --------------	//	
	//	this does the same as above only now with a gradient option
	//useage example : 
	//drawGradientShape(140,200,40,22.5,
	//0x0000ff,0x0000ff,100,50,50,50,100,100);
	function drawGradientShape(
							r:Number,x:Number,
							y:Number,styleMaker:Number,
							col1:Number,col2:Number,fa1:Number,fa2:Number,
							matrixX:Number,matrixY:Number,matrixW:Number, matrixH:Number) {
		mc.lineStyle(thick, color);
		mc.moveTo(x+r,y);
		var colors:Array = [col1 ,col2];
		var alphas:Array = [ fa1, fa2 ];
		var ratios:Array = [ 7, 0xFF ];
		var matrix:Object = { matrixType:"box", x:matrixX, y:matrixY, w:matrixW, h:matrixH, r:(45/180)*Math.PI };
		mc.beginGradientFill( "linear", colors, alphas, ratios, matrix );
		var style:Number = Math.tan(styleMaker*Math.PI/180);
		
		for(var angle:Number=45; angle<=360; angle+=45) {
			var endX:Number = r * Math.cos(angle*Math.PI/180);
			var endY:Number = r * Math.sin(angle*Math.PI/180);
			var cX:Number	= endX + r * style * Math.cos((angle-90)*Math.PI/180);
			var cY:Number = endY + r * style * Math.sin((angle-90)*Math.PI/180);
			mc.curveTo(cX+x,cY+y,endX+x,endY+y);
		}
		mc.endFill();
	}
	
	//
	//	----------- GRADIENT RECTANGLE	----------- //
	//gradientRect(0,0,200,200,0x0000ff,0x0000aa,100,100,50,50,100,100)
	function gradientRect(x1:Number, y1:Number, 
						  width:Number, height:Number,
						  col1:Number, col2:Number, fa1:Number, fa2:Number,
						  matrixX:Number, matrixY:Number, matrixW:Number, matrixH:Number) {
		mc.lineStyle(thick, color);
		var colors:Array = [col1 ,col2];
		var alphas:Array = [fa1, fa2];
		var ratios:Array = [7, 0xFF];
		var matrix:Object = {matrixType:"box", x:matrixX, y:matrixY, w:matrixW, h:matrixH, r:(45/180)*Math.PI };
		
		mc.moveTo(x1,y1);
		mc.beginGradientFill("linear", colors, alphas, ratios, matrix);
		mc.lineTo(x1+width, y1);
		mc.lineTo(x1+width, y1+height);
		mc.lineTo(x1, y1+height);
		mc.lineTo(x1, y1);
		mc.endFill();
	}
	
	//	
	//	----	DRAW HEXAGON ----	//
	//
	public function drawHexagon(hexRadius:Number, startX, startY){
		var sideC:Number=hexRadius;
		var sideA:Number = 0.5 * sideC;
		var sideB:Number= Math.sqrt((hexRadius*hexRadius) - (0.5*hexRadius)* (0.5*hexRadius));
		
		mc.lineStyle(thick,color,100)
		mc.moveTo(startX,startY)
		mc.lineTo(startX,sideC+ startY);
		mc.lineTo(sideB+startX,startY+sideA+sideC);
		
		// bottom point
		mc.lineTo(2*sideB + startX , startY + sideC);
		mc.lineTo(2*sideB + startX , startY);
		mc.lineTo(sideB + startX, startY - sideA);
		mc.lineTo(startX, startY);
	};
	//usage would be drawHexagon(sideLength, startX , start Y)
		
	//	
	//	----		fill HEXAGON	----	//
	//
	public function fillHexagon(hexRadius:Number, startX, startY){
		var sideC:Number=hexRadius;
		var sideA:Number = 0.5 * sideC;
		var sideB:Number=Math.sqrt((hexRadius*hexRadius) 
						- (0.5*hexRadius)* (0.5*hexRadius));
		mc.lineStyle(thick,color,100)
		mc.beginFill(fill);
		mc.moveTo(startX,startY)
		mc.lineTo(startX,sideC+ startY);
		mc.lineTo(sideB+startX,startY+sideA+sideC);
		// bottom point
		mc.lineTo(2*sideB + startX , startY + sideC);
		mc.lineTo(2*sideB + startX , startY);
		mc.lineTo(sideB + startX, startY - sideA);
		mc.lineTo(startX, startY);
		mc.endFill();
	};
	
	//usage would be fillHexagon(sideLength, startX , start Y)	
}