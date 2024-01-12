#!/bin/bash
search_dir="/mnt/c/Users/markf/OneDrive/Documents/legal/travis/discovery/CREDIT/BOA 9809"
echo "$search_dir"
echo "$PWD"
# Set space as the delimiter
IFS='/'

# Read the split words into an array
# based on space delimiter
read -ra newarr <<< "$search_dir"


# Print each value of the array by using
# the loop
for val in "${newarr[@]}";
do
 echo "$val"
done
indexes="${!newarr[@]}"
echo "INDEXES: $indexes"
lastindex=${indexes[-1]}
echo "LAST: $lastindex"

for entry in "$search_dir"/*
do
  if [[ -d $entry ]]; then
    # echo "$entry is a dir"
  elif [[ -f $entry ]]; then
    # echo "$entry is a file"


  fi
done