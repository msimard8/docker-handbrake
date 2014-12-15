#!/bin/bash

inotifywait -m /watched -e create -e moved_to |
    while read path action file; do
        echo "The file '$file' appeared in directory '$path' via '$action'"
	if [[ $file == *.mkv ]] || [[ $file == *.avi ]]
	   then
	     destinationFileName="${file%.*}.mp4"; 
	     eval "HandBrakeCLI -i '"$file"' -o "/destination/"'"$destinationFileName"' --preset="Universal""
	     rm "$file"
	fi

        # do something with the file
    done
