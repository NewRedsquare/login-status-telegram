# login-status-telegram
Monitoring of all login attempts to your server ( Requires PAM)

# Features!

  - With PAM integration, sends a message via telegram
  - Extra infos like country, region, approximative city, and hostname ( the IP of course !)

### Installation

First, do
```sh
$ git clone https://github.com/NewRedsquare/login-status-telegram.git
$ cd login-status-telegram
$ chmod +x telegram_bot.sh
$ cp telegram_bot.sh /usr/local/bin/
```

You will need to configure the `TOKEN` and the `CHAT ID` , see [here](https://core.telegram.org/bots) for the token. For chat id, talk with [userinfobot](https://t.me/userinfobot) and send `/start`. Copy the ID.

Finally, add `session optional pam_exec.so type=open_session seteuid /usr/local/bin/telegram_bot.sh` in the file `/etc/pam.d/common-session` . Like this, EVERY login attempt ( from ssh, and any other method ) will be sent to telegram.

Notice the flag `optional`, in case of failure of this script , the authentication will not be blocked. Change it if desired.


For example :
![telegram_exemple](https://github.com/NewRedsquare/login-status-telegram/blob/master/example.jpg)

### Todos

 - If there are issues :D

License
----

GPLv3
