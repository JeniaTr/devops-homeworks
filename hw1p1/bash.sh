#!/bin/bash
clear
parProsess=$1
parWhoisN=$2
tailN=$3

parrWhois=([1]='Organization' [2]='City' [3]='Country')

if [ -z "$parProsess" ]; then
    {
        unset appsNames
        appsNames=$(sudo netstat -tunapl | awk '{print $7}' | grep -oP '/\K.*' | sort | uniq)

        echo "Which app to scan:"

        select appName in $appsNames; do
            app=$appName
            break
        done

        echo "What fields you want to look:"

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
                break
                ;;
            esac
        done

        echo "Enter max number of ip adresses:"
        read -r tailN

    }
else
    {
        if [[ "$parProsess" =~ ^[0-9]+$ ]]; then
            {
                unset appsPids
                appsPids=$(sudo netstat -tunapl | awk '{print $7}' | awk -F '/' '{print $1}' | sed s/[^0-9]//g | sort | uniq)

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
                appsNames=$(sudo netstat -tunapl | awk '{print $7}' | grep -oP '/\K.*' | sort | uniq)

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
        tailN="10"
    }
fi

echo "Prosess: $app"
if [[ "$app" && "$parWhoisN" && "$tailN" ]]; then

    sudo netstat -tunapl |
        awk '/'"$app"'/ {print $5}' |
        cut -d: -f1 | sort |
        uniq -c | sort |
        tail -n"$tailN" |
        grep -oP '(\d+\.){3}\d+' |
        while read -r IP; do whois "$IP" |
            awk -F':' '/^'"${parrWhois[parWhoisN]}"'/ {print $2}'; done |
        sort | uniq -c

fi
