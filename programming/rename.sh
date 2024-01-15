#!/bin/bash

dateRegx='[0-9]{4}\.[0-9]{2}\.[0-9]{2}'
searchDir="/mnt/c/Users/markf/OneDrive/Documents/legal/travis/discovery/CREDIT/BOA 9809"
echo "$searchDir"
echo "$PWD"
# Set space as the delimiter
IFS='/'

# searchDir="$PWD"

# Read the split words into an array
# based on space delimiter
read -ra directoryPath <<< "$searchDir"


# Print each value of the array by using
# the loop
for val in "${directoryPath[@]}";
do
 echo "$val"
done
indexes="${!directoryPath[@]}"
echo "INDEXES: $indexes"
currentDir=${directoryPath[-1]}
echo "LAST: $currentDir"

for entry in "$searchDir"/*
do
  read -ra fullFilePath <<< "$entry"
  fileName=${fullFilePath[-1]}
  echo "FILE NAME $fileName"
  read -ra fullPath <<< "$entry"
  item=${fullPath[-1]}
  if [[ -d $entry ]]; then
    echo "$item is a dir"
  elif [[ -f $entry && ! $entry =~ $dateRegx ]]; then
    if [[ $currentDir =~ "BOA"]]; then  
      extension=${item: -3}
      fileDate=${item:6:-4}
      category=${directoryPath[-2]}
      newFileDate=$(echo $fileDate | tr "-" ".")
      newFileName="${newFileDate} ${category} ${currentDir}.${extension}"
      cp "$entry" "$searchDir"/"$newFileName"
    if [[ $currentDir =~ "TRUIST "]]; then  
      extension=${item: -3}
      fileYear=${item:-8:-4}
      print "FILE YEAR: $fileYear"
      
      month= $fileName | [\s\S]*?(?=,)

      category=${directoryPath[-2]}
      newFileDate=$(echo $fileDate | tr "-" ".")
      newFileName="${newFileDate} ${category} ${currentDir}.${extension}"
      cp "$entry" "$searchDir"/"$newFileName"
  fi
done

# x=valid

# if [ "$x" = "valid" ]; then
#   echo "x has the value 'valid'"
# fi

# dir=$PWD
# echo "DIR: $dir"
# if [[ "$dir" = "/home/mark/generalNotes/programming" ]]; then
#    echo "EQUALS"
# fi

