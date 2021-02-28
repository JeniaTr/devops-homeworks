#!/bin/bash
clear
# This line prints the average rate for the last 14 values from the file.
#Changes are considered only relative to the Integer part.
#---- All values after - "." do not go to the amount !!!
#---- "|tr '.' ','|" to get a beter result
#jq -r '.prices[][]' quotes.json | grep -oP '\d+\.\d+' | tail -n 14 | awk -v mean=0 '{mean+=$1} END {print mean/14}'

#########################################################################
#declare -A curse
# sed 's/0*$//' - cut all "0" in the end of variables
#
readarray -t curse < <(jq -r '.prices[][]' quotes.json | sed 's/0*$//' | tr '.' ',')

echo ${#curse[@]}

for ((i = 1; i <= ${#curse[@]}; i = i + 2)); do
    curseDate[i - 1]=$(date -d @"${curse[i - 1]}" +%Y-%m-%d)
    curseValue[i - 1]=${curse[i]}
done
unset curse
yearFrom=$(date -d 2016-01-01 +%Y-%m-%d)
month="03"
echo "==========="
echo "Date from: $yearFrom"
echo "Month for: $month"
echo "==========="
# month=$(date -d "$yearFrom" '+%m')
b=0
for ((i = 0; i <= ${#curseDate[@]}; i++)); do
    if [[ ${curseDate[i]} > $yearFrom ]]; then
        {
            curseYear=$(date -d "${curseDate[i]}" '+%y')
            curseMonth=$(date -d "${curseDate[i]}" '+%m')
            if [[ $curseMonth == $month ]]; then
                {
                    # echo $curseMonth
                    # echo $month
                    # echo ${curseDate[i]}

                    ((b++))
                }

            fi

            # echo "${curseDate[i]}"
        }
    fi
done


echo $b




# else
#     {
#         echo "We have not data from this year"
#         exit
#     }

# echo ${#curse[@]}

# echo ${#curseDate[@]}
# echo ${#curseValue[@]}

# echo "${curseDate[@]}"
# echo "${curseValue[@]}"
