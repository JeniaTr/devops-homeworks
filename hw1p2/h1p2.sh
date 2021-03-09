#!/bin/bash
#########################################################################
# rm quotes.json
curl -s https://yandex.ru/news/quotes/graph_2000.json > ./quotes.json
clear
readarray -t curse < <(jq -r '.prices[][]' quotes.json)
echo ${#curse[@]}

for ((i = 1; i <= ${#curse[@]}; i = i + 2)); do
    #DATA
    # curseDate[i - 1]=$(date -d @"$(echo "${curse[i - 1]}" | rev | cut -c 4- | rev) " +%Y-%m-%d)
    # OR
    tempData=$(echo "${curse[i - 1]}" | rev | cut -c 4- | rev)
    curseDate[i - 1]=$(date -d @"$tempData" +%Y-%m-%d)
    #VALUE
    curseValue[i - 1]=${curse[i]}
done

# #---------Test Data Convert---------------
# echo ${#curseDate[@]}
# echo ${#curseValue[@]}

# # echo "${curseDate[@]}"

# unset i

# for i in "${!curseDate[@]}"; do
#     if [[ "$(date -d "${curseDate[i]}" +%Y-%m)" == "2016-03" ]]; then
#         echo "${curseDate[i]}"
#         echo "${curseValue[i]}"
#     fi
# done
# exit
# #---------/Test Data Convert---------------

unset curse
startYear=$(date -d 2005-01-01 +%Y-%m-%d)
checkMonth="03"

echo "==========="
echo "Date from: $startYear"
echo "Month for: $checkMonth"
echo "==========="

declare -A max
declare -A min

for i in "${!curseDate[@]}"; do
    if [[ "$startYear" < "${curseDate[i]}" ]]; then
        {
            itMonth=$(date -d "${curseDate[i]}" '+%m')

            if [[ "$itMonth" == "$checkMonth" ]]; then
                {
                    itYear="$(date -d "${curseDate[i]}" '+%Y')"

                    if ! [ ${min[$itYear]+_} ]; then
                        {
                            min[$itYear]=${curseValue[i]}
                            max[$itYear]=${curseValue[i]}
                        }
                    fi

                    if [[ ${curseValue[i]} > ${max[$itYear]} ]]; then
                        {
                            max[$itYear]=${curseValue[i]}
                        }
                    fi

                    if [[ ${curseValue[i]} < ${min[$itYear]} ]]; then
                        {
                            min[$itYear]=${curseValue[i]}
                        }
                    fi
                }

            fi

        }
    fi
done

# ##########
# echo "=========== TEST MIN MAX ON YEAR============="
# for year in "${!max[@]}"; do
#     echo "$year"
#     echo "${max[$year]}"
#     echo "${min[$year]}"
#     echo "--------------------------------------"
# done
# echo "=========== /TEST MIN MAX ON YEAR============="
# exit
# ##########

declare -A volatail

for year in "${!max[@]}"; do
    volatail[$year]=$(awk 'BEGIN{print '"${max[$year]}"' - '"${min[$year]}"'}' | tr ',' '.')

    # ########### Test Volatail Calculation ############
    # echo "----------"
    # echo "$year"
    # echo "${volatail[$year]}"
    # ########### /Test Volatail Calculation ############
done

for year in "${!volatail[@]}"; do
    if [[ $minVolatail = "" ]]; then
        minVolatail=${volatail[$year]}
        targetYear=$year
    fi

    if [[ ${volatail[$year]} < $minVolatail ]]; then
        {
            minVolatail=${volatail[$year]}
            targetYear=$year

        }
    fi
done

echo "---------------------"
echo "Year of min volatail"
echo "$targetYear"
echo
echo "Min volatail:"
echo "$minVolatail"
