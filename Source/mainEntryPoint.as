import com.mab.util.debug;
import com.mab.drawing.shapeMaker;

class mainEntryPoint {
	static function main() {
		var str = "ok";
		com.mab.util.debug.trace(str.split("|").length)
		var bla = {h:1};
		//debug.trace("hi");
		//debug.dumpObject(bla);
		
//		shapeMaker.makeEmptyCircle({_x:0, _y:0, thickness:20, color:0xFF00FF, radius:100}, _root, "Sdfsdf");
		shapeMaker.makeEmptyCircle({_x:2, _y:2, color:0x00aa00, thickness:6, radius:96}, _root, "whiteBorder")._alpha = 50;
		shapeMaker.makeEmptyCircle({_x:0, _y:0, color:0xcccccc, thickness:2, radius:100}, _root, "grayBorder")._alpha = 50;;
		shapeMaker.makeCircle({_x:5, _y:5, color:0xFF00FF, radius:93}, _root, "largeImageMask"); 

	}
}