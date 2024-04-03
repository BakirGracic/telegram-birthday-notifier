#!/bin/bash

# Execution date with script name
date_for_errs=$(date +"%d/%m/%Y %H:%M:%S")
EXEC_DATE="[${date_for_errs} - main.sh] -> "

# Get script directory
exec_script_path=$(realpath "$0")
EXEC_DIR=$(dirname "$exec_script_path")

# Load configuration file
source "${EXEC_DIR}/settings.conf"

# Check if the configuration file was loaded successfully
if [ $? -ne 0 ]; then
    echo "${EXEC_DATE} Unable to load configuration file settings.conf"
    exit 1
fi

# Download the birthdays file
birthdays_file=$(mktemp)
if ! curl -s "$BIRTHDAYS_FILE_URL" > "$birthdays_file"; then
    echo "${EXEC_DATE} Failed to download birthdays file from $BIRTHDAYS_FILE_URL"
    exit 1
fi

# Calculate tagret date
target_date=$(date -d "+$NOTIFY_DAYS_BEFORE days" +%d/%m)

# Identify upcoming birthdays
upcoming_birthdays=()
while read -r line; do
    birth_date=$(echo "$line" | cut -d '-' -f2)
    birth_date="${birth_date::-5}"

    # Check if birthday is within notification period
    if [[ "$birth_date" == "$target_date" ]]; then
        name=$(echo "$line" | cut -d '-' -f1)
        current_year=$(date +%Y)
        birth_year="${line: -4}"
        age=$(( current_year - birth_year )) 
        upcoming_birthdays+=("🎂 In $NOTIFY_DAYS_BEFORE days $name will be $age years old!")
    fi
done < "$birthdays_file"

# Remove the temporary file
rm "$birthdays_file"

# Make final Telegram message
if [[ ${#upcoming_birthdays[@]} -gt 0 ]]; then
    message=$(IFS=$'\n'; echo "${upcoming_birthdays[*]}")
else
    message="🎂 No birthdays in $NOTIFY_DAYS_BEFORE days!"
fi

# Send final Telegram message
if ! curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
     -d chat_id="$TELEGRAM_CHAT_ID" \
     -d text="$message" > /dev/null 2>&1; then
    echo "${EXEC_DATE} Failed to send Telegram message"
    exit 1
fi

# Success Message
echo "${EXEC_DATE} Successful!"
