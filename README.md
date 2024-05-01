# telegram-birthday-notifier

Get Telegram messages for upcoming birthdays!

### Requirements
- linux machine running 24/7 with cron jobs
- telegram bot
- secret GitHub Gist with birtdays

### Steps (Repo)
- clone repo in user's home directory on your linux machine by running `git clone https://github.com/BakirGracic/telegram-birthday-notifier.git`
- get inside the new directory by running `cd telegram-birthday-notifier`
- copy config example with `cp settings.example.conf settings.conf`
- edit config by running `nano settings.conf`
- make scripts executable with `chmod +x installer.sh && chmod +x main.sh`
- run installer and input parameters with `./installer.sh`

### Steps (BOT)
- create your bot using BotFather (search online for tutorial) and save provided bot token
- send random message to your bot and get chat ID with your bot token from this URL `https://api.telegram.org/bot<BOT_ID_HERE>/getUpdates`

### Steps (Gist)
- create a secret (i.e. private) GitHub Gist and store birtdates there
- make sure to link RAW contents of Gist (use only part until "/raw/" (inclusive))
- syntax `NAME SURNAME-dd/mm/yyyy` (can add more names like middlenames, just separate with space)

### Why This?
- aimed for those who don't remember birthdays very well (like me :P)
- script is very basic and easy to modify, feel free to do such!

### Cleanup
- remove repo folder by going into it, then running  `cd .. && rm -rf telegram-birthday-notifier`
- remove cron job entry with `crontab -e`, it should look something like: `0 9 * * * /root/telegram-birthday-notifier/main.sh >> /root/telegram-birthday-notifier/logfile.log 2>&1`
