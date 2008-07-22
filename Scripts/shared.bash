#!/bin/bash

translateToBuildPath() {
	newPath="$1"
	newPath=${newPath/"$SRCROOT\/Source"/"$BUILD_DIR/source"}
	echo "$newPath"
}

translateToSourcePath() {
	newPath="$1"
	newPath=${newPath/"$BUILD_DIR\/source"/"$SRCROOT/Source"}
	echo "$newPath"
}
