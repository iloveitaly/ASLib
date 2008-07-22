/**
 *@description: types the text in the textfield and makes it look like a typewriter
 *@param: str, the string to type in
 *@param: ms, number representing the amount of miliseconds from each letter type
 **/
TextField.prototype.typeWriter = function(str:String, ms:Number):Void {
	this.isTyping = true;
	var me = this;
	var i = 0;
	this.__twinter = setInterval(function() {
		me.text = str.substring(0, i);
		i++;
		if (i > str.length) {
			me.isTyping = false;
			me.dispatchEvent({type:"onTypeWriterEnd"});
			clearInterval(me.__twinter);
		}
		
		//updateAfterEvent();
	}, ms);	
};

TextField.prototype.typeOut = function(ms:Number):Void {
	this.isTyping = true;
	var me = this;
	var i = me.text.length;
	
	this.__tointer = setInterval(function() {
		if (i == -1) {
			me.text = "";
			me.dispatchEvent({type:"onTypeWriterOut"});
			me.isTyping = false;
			clearInterval(me.__tointer);
		} else {			
			me.text = me.text.substring(0, i);
			i--;
			//updateAfterEvent();
		}
	}, ms);
}

TextField.prototype.killTyping = function(d:Boolean):Void {
	if(d) //if true dispatch done event
		this.dispatchEvent({type:"onTypeWriterOut"});
	clearInterval(this.inter);
	this.isTyping = false;
}

ASSetPropFlags(Object.TextField, null, 1);