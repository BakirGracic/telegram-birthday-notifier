#!/bin/bash

# Load configuration file
source settings.conf

# Download the birthdays file
birthdays_file=$(mktemp)
curl -s "$BIRTHDAYS_FILE_URL" > "$birthdays_file"

# Calculate Tagret Date
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

# Telegram Message Creation
if [[ ${#upcoming_birthdays[@]} -gt 0 ]]; then
    message=$(IFS=$'\n'; echo "${upcoming_birthdays[*]}")
else
    message="🎂 No birthdays in $NOTIFY_DAYS_BEFORE days!"
fi

# Telegam Message Send
curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
     -d chat_id="$TELEGRAM_CHAT_ID" \
     -d text="$message" > /dev/null 2>&1
