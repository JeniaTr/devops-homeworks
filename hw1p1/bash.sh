#!/bin/bash
clear
parProsess=$1
parWhoisN=$2
tailN=$3

parrWhois=([1]='Organization' [2]='City' [3]='Country')

if [ -z "$parProsess" ]; then
    {
        echo -e "\n Script will display only user processes \n"

        unset appsNames
        appsNames=$(netstat -tunapl | awk '{print $7}' | grep -oP '/\K.*' | sort | uniq)

        echo -e "\nWhich app to scan:"

        select appName in $appsNames; do
            app=$appName
            break
        done

        echo -e "\n What fields you want to look:"

        select parr in "${parrWhois[@]}"; do
            case $parr in
            "Organization")
                parWhoisN="1"
                break
                ;;

            "City")
                parWhoisN="2"
                break
                ;;

            "Country")
                parWhoisN="3"
                break
                ;;

            *)
                echo "Invalid entry."
                exit
                ;;
            esac
        done

        echo -e "\nEnter max number of ip adresses:"
        read -r tailN

    }
else
    {
        if [[ "$parProsess" =~ ^[0-9]+$ ]]; then
            {
                unset appsPids
                appsPids=$(netstat -tunapl | awk '{print $7}' | awk -F '/' '{print $1}' | sed s/[^0-9]//g | sort | uniq)

                for pid in $appsPids; do
                    if [ "$pid" == "$parProsess" ]; then
                        app=$parProsess
                        break
                    fi
                done

                if [ -z "$app" ]; then
                    echo "There is no process with PID: $parProsess"
                    exit
                fi
            }
        else
            {
                unset appsNames
                appsNames=$(netstat -tunapl | awk '{print $7}' | grep -oP '/\K.*' | sort | uniq)

                for appN in $appsNames; do
                    if [ "$appN" == "$parProsess" ]; then
                        app=$parProsess
                        break
                    fi
                done

                if [ -z "$app" ]; then
                    echo "There are no processes with this Name: $parProsess"
                    exit
                fi
            }
        fi
    }
fi

if ! [[ "$tailN" =~ ^[0-9]+$ ]]; then
    {
        tailN=100
        echo -e "\nYou entered invalid number of ip-s to scan it veal be default -- $tailN \n"
    }
else
    {
        if [[ "$tailN" -gt 100 ]]; then
            {
                tailN=100
                echo -e "\nMaximum is 100 ip-s to scan. You entered bigger number. It will be maximum default -- $tailN \n"
            }
        fi
    }
fi

echo -e "Prosess: $app \n"
if [[ "$app" && "$parWhoisN" && "$tailN" ]]; then

    netstat -tunapl |
        awk '/'"$app"'/ {print $5}' |
        cut -d: -f1 | sort |
        uniq -c | sort |
        tail -n"$tailN" |
        grep -oP '(\d+\.){3}\d+' |
        while read -r IP; do whois "$IP" |
            awk -F':' '/^'"${parrWhois[parWhoisN]}"'/ {print $2}'; done |
        sort | uniq -c

fi
