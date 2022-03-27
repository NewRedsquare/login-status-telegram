#!/bin/bash
HOSTNAME1="sh -c 'host $PAM_RHOST' | sed 's/^.* * * * //'"
ACCESS_TOKEN=""
URL="https://api.telegram.org/bot$ACCESS_TOKEN/sendMessage"
CHAT_ID="" # Telegram id from /getUpdates
if [[ $PAM_RHOST =~ .*:.* ]] ; then
   REGION=`geoiplookup6 $PAM_RHOST | sed -n '3p' | awk -v N=8 '{print $N}' | sed 's/,//'`
   COUNTRY=`geoiplookup6 $PAM_RHOST | sed -n '1p' | grep ', ' | sed 's/^.*, //'`
   ORG=`geoiplookup6 $PAM_RHOST | sed -n '2p' | sed -n 's/^.*: AS/AS/p'`
else
   REGION=`geoiplookup $PAM_RHOST | sed -n '2p' | awk -v N=7 '{print $N}' | sed 's/,//'`
   COUNTRY=`geoiplookup $PAM_RHOST | sed -n '1p' | grep ', ' | sed 's/^.*, //'`
   ORG=`geoiplookup $PAM_RHOST | sed -n '3p' | sed -n 's/^.*: AS/AS/p'`
fi
MESSAGE="*Login Alert*: $(date '+%Y-%m-%d %H:%M:%S %Z')
 username: $PAM_USER
 hostname: $HOSTNAME
 remote host: $PAM_RHOST
 region : $REGION
 country : $COUNTRY
 ISP : $ORG
 service: $PAM_SERVICE
 tty: $PAM_TTY"
PAYLOAD="chat_id=$CHAT_ID&text=$MESSAGE&disable_web_page_preview=true&parse_mode=Markdown"
curl -s --max-time 13 --retry 3 --retry-delay 3 --retry-max-time 13 -d "$PAYLOAD" $URL > /dev/null 2>&1 &
