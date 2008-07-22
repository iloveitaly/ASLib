#!/bin/bash

. ./Scripts/shared.bash

#------------------------------- Config Settings -------------------------------

swf="./main.swf"					#the swf to open after compiling
swfOut=""							#for the -out option, leave empty ("") if you dont want to use -out
swfplayer="Flash Player"			#the application to open the swf with
mtasc=/Applications/mtasc/mtasc		#the mtasc binary path
mtascStd=/Applications/mtasc/std	#the std directory of mtasc
mtascError=./.mtascerror			#path to a temporary error file DO NOT REMOVE
showWarnings=1						#show warnings from mtasc
noErrorProcessing=1					#if theres an error just output it. Useful when your not using preprocessing

#--------------------------------------------------------------------------------

#------------------------------- MTASC Compile -----------------------------------

"$mtasc" \
./mainEntryPoint.as \
-main -version 8 -header 500:500:30 \
-cp $mtascStd -cp ./Source \
-pack ./com/mab/audio -pack ./com/mab/data -pack ./com/mab/drawing -pack ./com/mab/loading -pack ./com/mab/motion \
-pack ./com/mab/ui -pack ./com/mab/util -pack ./com/mab/ui/scrolling \
-swf $swf 2> $mtascError #throw the errors into a file for now
mtascExit=$?
#---------------------------------------------------------------------------------

if [[ $noErrorProcessing == 1 ]]; then
	if [[ $mtascExit == 0 ]]; then #no errors
		if [[ $showWarnings  == 1 ]]; then
			cat "$mtascError"
		fi
		
		open -a "$swfplayer" $swf
		
		exit $mtascExit
	else #error
		cat "$mtascError"
		exit $mtascExit
	fi
fi

if [[ $? != 0 ]]; then
	#if there is more than one line of error messages
	if [[ `wc -l "$mtascError" | sed 's/[^0-9]//g'` != 1 ]]; then
		cat "$mtascError"
		exit 1
	fi
	
	error=`cat "$mtascError"`	#grab the stored error message from the file
	origError=$error			#make a copy of the error message for future use
	
	#class not found error. Just exit with the error message
	if echo "$error" | fgrep -q "(unknown) : type error class not found :"; then	
		echo "$error"
		exit 1
	fi
	
	#extract the line number from the error message
	errorFile=`echo "$error" | grep -o -E '^.*:[0-9]+:'`
	errorLineNum=`echo "$errorFile" | egrep -o '[0-9]+:$'`
	errorLineNum=${errorLineNum:0:${#errorLineNum}-1}
	
	#get the path that the error
	errorFile=${errorFile%:*:}

	#create a new error message using the 'real' path of the file
	error="`translateToSourcePath "$error"`"

	#create a reference to the 'real' file
	realFile=${error/:*/} #strip all characters after the ':' char

	#the line of the error in the preprocessed file
	errorLine=`sed -n ${errorLineNum}p "$errorFile"`	#the error line for the preprocessed file

	#figure out the difference in lines in the files and modify the error statement
	if expr "`cat "$realFile" | wc -l`" = "`cat "$errorFile" | wc -l`" > /dev/null \
	&& expr "`fgrep -nx "$errorLine" "$realFile" | sed 's/:*//'`" = "$errorLineNum"; then
		#then the files are exactly the same, output the original error message and exit
		echo "$origError"
		exit 1
	else
		if fgrep -q "$errorLine" "$realFile"; then
			#get the line number of $errorLine in the original source files
			#then replace the old line number in the error message with the newly found one
			#Then output the error and exit
			newErrorLine=`fgrep -nx "$errorLine" "$realFile" | grep -o '[^:]*'`
			echo "$error" | sed -E "s/:[0-9]+/:$newErrorLine/"
			exit 1
		else
			#then the line was not found in the original source file which means the line that contains an error must be the pre-processed source
			#so output the original error message to let the user figure out the pre-processing error
			echo "$origError"
			exit 1
		fi
	fi
	
	echo "Uncaught exception! Please report!"
	exit 1
else
	if [[ ! -z `cat "$mtascError"` && $showWarnings == 1 ]]; then
		cat "$mtascError"
	fi
	
	if [[ -z $swfOut ]]; then
		open -a "$swfplayer" $swf
	else
		open -a "$swfplayer" $swfOut
	fi
    exit 0
fi