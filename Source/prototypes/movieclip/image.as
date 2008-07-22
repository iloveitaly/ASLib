/*
Description:
Extends to MovieClip to make dealing with bitmaps/images easier

Usage:
|usage code here

Notes:
**notes**

Version:
1.0

Author:
Michael Bianco

Date:
6/6/07

*/

MovieClip.prototype.scaleTo = function(x, y) {
	// scale the pic if its bigger width wise
	if(this._width > x) {
		var r = x/this._width
		this._width = x;
		this._height *= r;
	}

	// scale the pic if w is bigger
	if(this._height > y) {
		var r = y/this._height;
		this._height = y;
		this._width *= r;
	}
}
