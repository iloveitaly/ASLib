/*
 *@class: xmlProtos
 *@author: Michael Bianco, http://mabwebdesign.com/
 *@date: 11/17/04
 *@version: 1.0
 */

/**
 *@description: gets the text content (I.E. textNode content) of the node
 *@returns: false when it cant find a textnode, the value of the textnode when if finds a text node
 **/
XMLNode.prototype.get_content = function() {
	if(this.nodeType == 1) {
		if(this.firstChild.nodeType == 3) {
			return this.firstChild.nodeValue;
		}
	}
	return false;
}

/**
 *@description: sets the textnode content
 *@param: content, the content you want the textnode to be
 *@returns: true on success, false on failure
 **/
XMLNode.prototype.set_content = function(content) {
	if(this.nodeType == 1) {
		if(this.firstChild.nodeType == 3) {
			this.firstChild.nodeValue = content;
			return true;
		} else {
			return false;
		}
	}
	return false;
}

/**
 *@description: checks if the XMLNode has any children, if the node has only a TextNode child, then it is not considered
 *to have childnodes
 *@returns: true if the XMLNode has children, false if it doesn't
 **/
XMLNode.prototype.hasChildNodes = function() {
	if(!this.childNodes) { //if the XMLNode doesn't have any child nodes return false
		return false;
	} else if(this.childNodes.length==1) { //if he only has one
		if(this.firstChild.nodeType==1) { //if its a xmlnode element object
			return true;  
		} else if(this.firstChild.nodeType==3) { //if its a text node
			return false; 
		}
	} else if(this.childNodes.length>1) { //if it has more than one child node
		return true; 
	}
}

//sets all xml objects to ignore whitespace
XML.prototype.ignoreWhite = true;