/*
 Class: com.mab.data.dbFlashDecode
 */

class com.mab.data.dbFlashDecode {
	private var dbData;
	private var columnNames;
	
	private var columnSep = "##";
	private var rowSep = "||";
	
	function dbFlashDecode() {
		super();
		dbData = [];
	}
	
	function decode(str, varName) {
		var tempArray = str.split(rowSep);
		for(var a = 0; a<tempArray.length; a++) {
			decodeRow(tempArray[a], varName);
		}
	}
	
	function decodeRow(str, varName) {
		if(varName) {
			var tempArray = str.split(columnSep);
			for(var a = 0; a<tempArray.length; a++) {
				var tempOb = {};
				trace(tempArray[a]);
				tempOb[columnNames[a]] = tempArray[a]
				dbData.push(tempOb);
			}
		} else {
			dbData.push(str.split(columnSep));
		}
	}
}