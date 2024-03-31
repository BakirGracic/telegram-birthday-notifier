# telegram-birthday-notifier

Get Telegram messages for upcoming birthdays!

### Requirements
- linux machine running 24/7 with cron jobs
- telegram bot
- secret GitHub Gist with birtdays

### Steps
- clone repo in user's home directory on your linux machine by running `git clone https://github.com/BakirGracic/telegram-birthday-notifier.git`
- get inside the new directory by running `cd telegram-birtday-notifier`
- edit config by running `nano settings.conf`
- run installer and input parameters by running `chmod +x installer.sh` and then `./installer.sh`
- all set!

### How to BOT
- create your bot using BotFather (search online for tutorial) and save provided bot token
- send random message to your bot and get chat ID with your bot token from this URL `https://api.telegram.org/bot<BOT_ID_HERE>/getUpdates`

### Formats
- you can create a secret (i.e. private) GitHub Gist and store birtdates there (make sure to link RAW text URL)
- syntax `NAME SURNAME-dd/mm/yyyy`
- unlimited name words separated with spaces, then dash, then date in dd/mm/yyyy format

### Why this?
- aimed for those who don't remember birthdays very well (like me :P)
- script is very basic and easy to modify, feel free to do such!
