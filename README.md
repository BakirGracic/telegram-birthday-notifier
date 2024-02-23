# telegram-birthday-notifier

Get Telegram messages for upcoming birthdays

### Requirements
- linux machine
- PHP
- internet
- cron
- 5 mins to set everythig up

### How to REPO
- clone repo `git clone https://github.com/BakirGracic/telegram-birthday-notifier.git`
- add birtdays in birthdays.json in correct JSON syntax (array of objects with name and date string key value pairs) with DD/MM/YYYY format WITHOUT LEADING ZEROS
- customize bot and chat ID alog with custom message from the bot

### How to BOT
- create your bot using BotFather (search online for how to), it will provide bot ID
- get chat ID with your bot with this URL `https://api.telegram.org/bot<BOT_ID_HERE>/getUpdates` (if no big JSON wait a few minutes)

### How to AUTOMATION
- run `crontab -e`
- add cron job for this script with php as executor
- e.x. `0 0 * * * /usr/bin/php /path/to/this/script.php`

### Why this?
- aimed for those who don't remember birth dates very well (like me :P)
- script is very basic and easy to modify, feel free to do such!
