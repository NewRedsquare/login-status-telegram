#!/bin/bash
HOSTNAME1="sh -c 'host $PAM_RHOST' | sed 's/^.* * * * //'"
HOSTNAME_OUTPUT=$(eval "$HOSTNAME1")
CITY="curl ipinfo.io/$PAM_RHOST | jq '.city' | sed 's/\"//g'"
CITY1=$(eval "$CITY")
REGION="curl ipinfo.io/$PAM_RHOST | jq '.region' | sed 's/\"//g'"
REGION1=$(eval "$REGION")
COUNTRY="curl ipinfo.io/$PAM_RHOST | jq '.country' | sed 's/\"//g'"
COUNTRY1=$(eval "$COUNTRY")
ORG="curl ipinfo.io/$PAM_RHOST | jq '.org' | sed 's/\"//g'"
ORG1=$(eval "$ORG")
TOKEN=""
URL="https://api.telegram.org/bot$TOKEN/sendMessage"
CHAT_ID="" # Telegram id from /getUpdates
MESSAGE="*Login Alert*: $(date '+%Y-%m-%d %H:%M:%S %Z')
 username: $PAM_USER
 hostname: $HOSTNAME
 remote host: $PAM_RHOST
 remote hostname : $HOSTNAME_OUTPUT
 city : $CITY1
 region : $REGION1
 country : $COUNTRY1
 ISP : $ORG1
 service: $PAM_SERVICE
 tty: $PAM_TTY"
PAYLOAD="chat_id=$CHAT_ID&text=$MESSAGE&disable_web_page_preview=true&parse_mode=Markdown"
curl -s --max-time 13 --retry 3 --retry-delay 3 --retry-max-time 13 -d "$PAYLOAD" $URL > /dev/null 2>&1 &
