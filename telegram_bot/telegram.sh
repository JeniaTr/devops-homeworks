#!/bin/bash
token=$(head -1 t.conf)
#chat=$(sed -n 2p t.conf)
chat="${1}"
subject="${2}"
message="${3}"

subject=$(echo "$subject" | sed 's/"/#/g')
message=$(echo "$message" | sed 's/"/#/g')


if [[ $subject =~ 'Problem' ]]; then
        ICON="❗"
elif [[ $subject =~ 'Resolved' ]]
then
        ICON="✔️"
else
        ICON="❓"
fi

message="$ICON $subject\n$message"
curl -X POST -H 'Content-Type: application/json' -d "{\"chat_id\":\"${chat}\",\"text\":\"${message}\"}" https://api.telegram.org/bot"${token}"/sendMessage


#    "Disaster": "🔥",
#    "High": "🛑",
#    "Average": "❗",
#    "Warning": "⚠️",
#    "Information": "ℹ️",
#    "Not classified": "🔘",
#    "OK": "✅",
#    "PROBLEM": "❗",
#    "info": "ℹ️",
#    "WARNING": "⚠️",
#    "DISASTER": "❌",
#    "bomb": "💣",
#    "fire": "🔥",
#    "hankey": "💩",
