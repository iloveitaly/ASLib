class com.mab.motion.VectorView extends com.mab.motion.Vector {
	public var target;
	public var propX:String;
	public var propY:String;
	
	function VectorView(t) {
		super(t._x, t._y);

		target = t;
	}
	
	function render() {
		target._x = x;
		target._y = y;
	}
}