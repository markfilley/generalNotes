match='[0-9]{4}\.[0-9]{2}\.[0-9]{2}'

myArray=("hello" "2022-2-9" "2023.03.10 CRE" "2023.03.10CRE" "Jan 5 2021" "2023.10-30")

for str in ${myArray[@]}; do
  #echo $str
  if  [[ "$str" =~ $match ]]; then
     echo "$str"
  fi
done

declare -A months
declare -A monthShort
months=(["january"]=1 ["febaruary"]=2 ["march"]=3 ["april"]=4 ["may"]=5 ["june"]=6 ["july"]=7 ["august"]=8 ["september"]=9 ["october"]=10 ["november"]=11 ["december"]=12)
monthShort=(["jan"]=1 ["feb"]=2 ["mar"]=3 ["apr"]=4 ["may"]=5 ["jun"]=6 ["jul"]=7 ["aug"]=8 ["sep"]=9 ["oct"]=10 ["nov"]=11 ["dec"]=12)

echo "JAN=${months['january']}"
echo "JAN=${monthShort['january']}"
echo "JAN=${monthShort['jan']}"


fileName="January, 2023"


justMonth=`echo "January, 2023" | grep '^[^,]*'`

IFS=','
read -ra testMonth <<< "$fileName"

echo "just MONTH $justMonth"
echo "just Month2 ${testMonth[0]}"