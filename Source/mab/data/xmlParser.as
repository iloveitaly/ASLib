/*
 Class: com.mab.data.xmlParser
 
 Description:
 Class to easily parse XML documents. This is the equivilent to the PHP version of this class.
 
 Requires <XML> class additions.
 
 Usage:
 Any subclasses can choose to implement any of the following functions:
 
 |function dataHandler(data);
 |function attributeHandler(attribs);
 |function startTagHandler(tagName);
 
 Use the var <curr_tag> to determine where you want to put the data when <dataHandler> is called.
 <curr_tag> is always uppercase. You can also implement the function <startTagHandler>, which will
 be called everytime the parser encounters a new opening tag.
 
 The subclass of this class can also implement a function "xmlParserDone" that will be called BEFORE the parser
 dispatches the "xmlParserDone" event. Do not register the subclass to listen for the "xmlParserDone" event, simply overide
 the method itself.
 
 
 |var xmlFile = new XML();
 |xmlFile.onLoad = function() {
 |	 var parser = new foodParser();
 |	 parser.parseXML(this);
 |}
 
 xmlFile.load("foodList.xml");
 
 
 
 Author:
 Michael Bianco, http://developer.mabwebdesign.com/
 
 Date:
 12/24/04
 */

 /*
  *Node number constants:
  *******************************************
  * 1		ELEMENT_NODE
  * 2		ATTRIBUTE_NODE
  * 3		TEXT_NODE
  * 4		CDATA_SECTION_NODE
  * 5		ENTITY_REFERENCE_NODE
  * 6		ENTITY_NODE
  * 7		PROCESSING_INSTRUCTION_NODE
  * 8		COMMENT_NODE
  * 9		DOCUMENT_NODE
  * 10		DOCUMENT_TYPE_NODE
  * 11		DOCUMENT_FRAGMENT_NODE
  * 12		NOTATION_NODE
  *******************************************
  */


class com.mab.data.xmlParser {
	/*
	 Variable: curr_tag
	 String. The current tag that is being parser
	 
	 Variable: _document_root
	 The root XMLNode of the XML document being parsed
	 
	 Variable: curr_tag
	 Uppercase string representing the tag the xmlParser is currently parsing
	 */

	private var _document_root:XMLNode;
	private var _xml:XML;
	private var _count:Number = 1;
	private var _wasZero:Boolean = false;
	public var curr_tag:String;
	
	/*
	 Function: xmlParser
	 Constructor function, inits broadcaster
	 */
	function xmlParser() {
		super();
		this.initBroadcaster();
	}
	
	/*
	 Function: parseXML
	 Starts the parsing of the XML document
	 
	 Parameters:
		xmlob - the XML object to be processed
	 */
	public function parseXML(xmlob:XML) {
		_xml = xmlob;

		_document_root = _xml;

		_startParse();
	}
	
	private function _startParse() {
		if(_document_root.nodeType == 1) {
			_recursiveParse(_document_root); //start the recursive parsing
		} else {
			trace("Error parsing xml document [_startParse()]")
		}
	}
	
	/*
	 Function: _recursiveParse
	 Function that is applied to every xmlElement in the XMLob.
	 If attributes are found then the attributes array are passed to the attributeHandler(). If the node contains child nodes, then the child
	 nodes are proccessed. Note: child nodes are determined by the hasChildNodes() in the xml.as prototypes i created.
	 If the node contains data AND child nodes, only the child nodes are proccessed. For example:
	 |<root>
	 |	Some Text
	 |	<anode>Data in a node</anode>
	 |</root>
	 the "Some Text" will NOT be considered data. When the parser is done is will dispatch a "xmlParserDone" event.
	 
	 Parameters:
		xmlob - a xmlelement to be processed
	 */
	private function _recursiveParse(xmlob):Void {
		_count--;
		
		if(xmlob.nodeName != undefined) {//if we have a valid tagname assign it to the curr_tag
			curr_tag = xmlob.nodeName.toUpperCase();
			startTagHandler(curr_tag);
        }
		
		if(xmlob.attributes) {//if the node has attributes send it to the processer
			attributeHandler(xmlob.attributes);
		}
				
		if(xmlob.hasChildNodes()) {//if the node has child nodes
			_count += xmlob.childNodes.length;
			
			for(var a = 0; a < xmlob.childNodes.length; a++) {
				_recursiveParse(xmlob.childNodes[a]);
			}
			
		} else if(!xmlob.hasChildNodes() && xmlob.get_content()) //if the xml object has no child nodes
			dataHandler(xmlob.get_content()); //give the data to the dataHandler()

		if(_count == 0 && !_wasZero) {
            xmlParserDone();
			dispatchEvent({type:"xmlParserDone"});
			_wasZero = true;
		}
	}
	
	/*
	 Function: dataHandler
	 Overide this function in your subclasses. This function is called everytime data is found in the XML document.
	 The data parameter is a string with the data that was found in the XML document
	 
	 Function: attributeHandler
	 Overide this function in your subclasses. This function is called everytime the parser comes across attributes in the XML document.
	 
	 Function: startTagHandler
	 Overide this function in your subclasses. This function is called everytime the parser encounters a new tag to start parsing.
	 
	 Function: xmlParserDone
	 Overide this function in your subclasses. This is called when the parser completes parsing
	 */
	function dataHandler(data){}
	function attributeHandler(attribs){}
	function startTagHandler(name:String){}
	function xmlParserDone(Void){}
}