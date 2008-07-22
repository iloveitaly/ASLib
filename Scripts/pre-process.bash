#!/bin/bash

#For this script to work you need the filepp: http://www.cabaret.demon.co.uk/filepp/
#or you could modify the script to use cpp or your favorite preprocesser

#include shared functions
. ./Scripts/shared.bash

srcDest="$BUILD_DIR/source"
srcRoot="$SRCROOT/Source"

removed=0
if [[ ! -e "$srcDest" ]]; then
	#the source directory does not exist/has been removed
	#mark removed true so the script wont terminate if it finds directory
	#structure differences and create the 'build' source directory
	removed=1
	mkdir "$srcDest"
fi

#compare the 'real' source directory with the 'build' source directory
#if there are differences rebuild the directory structure
find "$srcRoot" -type d | while read dir; do
	if [[ "$srcRoot" != "$dir" ]]; then
		dir=`translateToBuildPath "$dir"`
		if ! [[ -e "$dir" && -d "$dir" ]]; then	#check to make sure the directory exists in the 'build' section
			if [[ $removed == 0 ]]; then		#we dont want to remove the directory if it was already removed!
				rm -fr "$srcDest"	#remove the current source directory so we can rebuild it
				#echo "Removed build source directory"
				exit 1 #exit with status 1 so the script will be run again
			fi
			
			mkdir "`translateToBuildPath "$dir"`"
		fi
	fi
done

#process all the actionscript source files
find "$srcRoot" -name "*.as" -or -name "*.actionscript" | while read file; do
	#you can replace the filepp command below with your favorite preprocesser command
	filepp -Dtrace=com.mab.util.debug.trace -DDEBUG=0 "-I/ASLib/prototypes" "-I$srcRoot" "$file" -o "`translateToBuildPath "$file"`"
	
	if [[ $? != 0 ]]; then
		exit $?
	fi
done

exit 0