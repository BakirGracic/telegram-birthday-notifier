#!/bin/bash

# Get user input for execution time
echo -n "Enter the daily execution time (minutes): "
read -r execution_mins
echo -n "Enter the daily execution time (hours): "
read -r execution_hrs

# Get the absolute path of the setup.sh script
script_path=$(realpath "$0")
script_dir=$(dirname "$script_path")

# Verify if crontab exists, create if not 
if ! crontab -l > /dev/null 2>&1; then
    echo "Crontab does not exist. Creating a new crontab."
    crontab -u "$USER" /dev/null
fi

# Add Cron Job
if (crontab -l 2>/dev/null; echo "$execution_mins $execution_hrs * * * /usr/bin/sh >> $script_dir/telegram-birthday-notifier.sh") | crontab -; then
    echo "Cron job added! telegram-birthday-notifier.sh will execute daily at $execution_hrs:$execution_mins"
else
    echo "Error: Failed to add cron job. Please check permissions and try again."
fi
