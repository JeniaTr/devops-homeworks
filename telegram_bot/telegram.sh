#!/bin/sh
token=$(head -1 t.conf)
chat=$(sed -n 2p t.conf)

echo "$token"
echo "$chat"

subject="$1"
echo "$subject"

message="$2"
echo "$message"
curl -X POST -H 'Content-Type: application/json' -d "{\"chat_id\":\"${chat}\",\"text\":\"${subject}\n${message}\"}" https://api.telegram.org/bot"${token}"/sendMessage

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
