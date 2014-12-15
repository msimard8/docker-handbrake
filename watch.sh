#!/bin/bash

inotifywait -m /watched -e create -e moved_to |
    while read path action file; do
        echo "The file '$file' appeared in directory '$path' via '$action'"
	if [[ $file == *.mkv ]] || [[ $file == *.avi ]]
	   then
		until ! [[ `lsof -- "$path""$file"` ]]; do
                  echo "file in use"
	          sleep 0.5;
                done 
                echo "file finished copying to directory"
  	        destinationFileName="${file%.*}.mp4"; 
	        eval "HandBrakeCLI -i "/watched/"'"$file"' -o "/destination/"'"$destinationFileName"' --preset="Universal""
   	        rm "/watched/""$file"
	fi
    done
