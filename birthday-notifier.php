<?php

// Get birthdays data from json file
$data = json_decode(file_get_contents('birthdays.json'), true);

// Check if there is an upcoming birtday
$tomorrow = strtotime("+1 day");
$tomorrow = date("j/n/Y", $tomorrow);
$people = [];
foreach ($data as $item) {
    if($item['date'] == $tomorrow) {
        $people[] = $item['name'];
    }
}

// If no birthdays tomorrow - terminate
if (empty($people)) exit;

// Your custom message from the bot
$message = "Birtdays tomorrow:\n";

// Append people to message
$message = $message . implode(", \n", $people);

// Bot Data
$telegramBotToken = 'YOUR_BOT_TOKEN'; // Your Telegram Bot API token (obtainable from the BotFather via Telegram)
$telegramChatID = 'CHAT_ID'; // Your Bot's Chat ID (see README.md to obtain)

// Send Telegram Message
$telegramApiURL = "https://api.telegram.org/bot$telegramBotToken/sendMessage?chat_id=$telegramChatID&text=" . urlencode($message);
$response = file_get_contents($telegramApiURL);
