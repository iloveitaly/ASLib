#!/bin/bash

#copy all the SWFS to the destination directory

dest=~/Sites/sitehere/

if [ ! -e $dest ]; then
	echo "\"$dest\", does not exist"
	exit 1
fi

cd "$BUILD_DIR"

cp ./main.swf $dest

exit 0