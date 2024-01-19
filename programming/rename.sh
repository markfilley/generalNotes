#!/bin/bash

dateRegx='[0-9]{4}\.[0-9]{2}\.[0-9]{2}'
searchDir="/mnt/c/Users/markf/OneDrive/Documents/legal/travis/discovery/CREDIT/CHASE 6240"
#echo "$searchDir"
#echo "$PWD"


# searchDir="$PWD"

# Read the split words into an array
# based on space delimiter


# Set slash as the delimiter
IFS='/'
read -ra directoryPath <<< "$searchDir"


# Print each value of the array by using
# the loop
# for val in "${directoryPath[@]}";
# do
#  echo "$val"
# done
indexes="${!directoryPath[@]}"
#echo "INDEXES: $indexes"
currentDir=${directoryPath[-1]}
echo "Current Directory: $currentDir" # last element

count=0
for entry in "$searchDir"/*
do
  read -ra fullFilePath <<< "$entry"
  fileName=${fullFilePath[-1]}
  item=${fullFilePath[-1]}
  echo "FILE NAME: $fileName"
  echo "count: $count"
  # read -ra fullPath <<< "$entry"
  # item=${fullPath[-1]}
  if [[ -d $entry ]]; then
    echo "$fileName is a dir"
  elif [[ -f $entry && ! $entry =~ $dateRegx ]]; then
    echo ""

      if [[ $currentDir =~ "CHASE" ]]; then
        echo "CHASE files"
        extension=${fileName: -3}
        fileDate=${fileName: 0: 8}
        echo "FileDate: $fileDate"
        category=${directoryPath[-2]}
        newFileDate=${fileDate: 0: 4}.${fileDate: 4: 2}.${fileDate: 6: 2}

        newFileName="${newFileDate} ${category} ${currentDir}.${extension}"
        echo "NewFile: $newFileName"
        mv "$entry" "$searchDir"/"$newFileName"
      fi

      if [[ $currentDir =~ "BOA" ]]; then
        echo "BOA files"
        extension=${fileName: -3}
        fileDate=${fileName: 6: -4}
        category=${directoryPath[-2]}
        newFileDate=$(echo $fileDate | tr "-" ".")
        newFileName="${newFileDate} ${category} ${currentDir}.${extension}"
        echo "extension: $extension"
        echo "fileDate: $newFileDate"
        echo "category: $category"
        echo "currentDir: $currentDir"
        echo "NewFile: $newFileName"
        # mv "$entry" "$searchDir"/"$newFileName"
      fi


      if [[ $currentDir =~ "TRUIST" ]]; then
        
        # These file have format April, 2020.pdf make day 01

        # tempFileName=$fileName
        # echo "TRUIST files"
        # echo "Truist fileName: $tempFileName"
        # echo "item: $item"
        extension=${fileName: -3}
        #echo "EXTENSION: $extension"
        fileYear=${fileName: -8: -4}
        #echo "FILE YEAR: $fileYear"
        
        declare -A months
        declare -A monthShort
        months=(["january"]=1 ["febaruary"]=2 ["march"]=3 ["april"]=4 ["may"]=5 ["june"]=6 ["july"]=7 ["august"]=8 ["september"]=9 ["october"]=10 ["november"]=11 ["december"]=12)
        monthShort=(["jan"]=1 ["feb"]=2 ["mar"]=3 ["apr"]=4 ["may"]=5 ["jun"]=6 ["jul"]=7 ["aug"]=8 ["sep"]=9 ["oct"]=10 ["nov"]=11 ["dec"]=12)

        
        IFS=',' read -ra fileSplit <<< "$fileName"
        
        justMonth=${fileSplit[0]}
        echo "just month $justMonth"
        month=`echo $justMonth | awk '{print tolower($0)}'`
        echo "month: $month"
        monthNum=${months[$month]}
        echo "Month num: $monthNum"
        if [[ $monthNum == 10 || $monthNum == 11 || $monthNum == 12 ]]; then
           newFileDate="$fileYear.$monthNum.01"
        else
           newFileDate="$fileYear.0$monthNum.01"
        fi
        category=${directoryPath[-2]}
        newFileName="${newFileDate} ${category} ${currentDir}.${extension}"
        echo "NEW NAME: $newFileName"
        mv "$entry" "$searchDir"/"$newFileName"
      fi
  else
    echo "no matching"
  fi
  ((count+=1))

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

