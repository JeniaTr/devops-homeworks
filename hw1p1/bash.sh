#!/bin/bash
clear
inPID=$1

if [ -z "$inPID" ]; then

    unset appsNames
    appsNames=$(sudo netstat -tunapl | awk '{print $7}' | grep -oP '/\K.*' | sort | uniq)

    echo "Which app to scan:"

    select appName in $appsNames; do
        app=$appName
        break
    done

else
    {
        unset appsPids
        appsPids=$(sudo netstat -tunapl | awk '{print $7}' | awk -F '/' '{print $1}' | sed s/[^0-9]//g | sort | uniq)

        for pidN in $appsPids; do
            if [ "$pidN" == "$inPID" ]; then
                app=$inPID
                break
            fi
        done
        if [ -z "$app" ]; then
            echo "PID dose not exist"
            exit
        fi
    }
fi

echo "$app"
if [ "$app" ]; then
    sudo netstat -tunapl | awk '/'$app'/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort | tail -n5 | grep -oP '(\d+\.){3}\d+' | while read IP; do whois $IP | awk -F':' '/^Organization/ {print $2}'; done
fi
