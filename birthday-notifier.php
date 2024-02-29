<?php

// Bot Data
$telegramBotToken = 'YOUR_BOT_TOKEN'; // Your Telegram Bot API token (obtainable from the BotFather via Telegram)
$telegramChatID = 'CHAT_ID'; // Your Bot's Chat ID (see README.md to obtain)
// Send Telegram Message
function telegramResponse($msg) {
    $telegramApiURL = "https://api.telegram.org/bot$telegramBotToken/sendMessage?chat_id=$telegramChatID&text=" . urlencode($msg);
    $response = file_get_contents($telegramApiURL);
}


// Get birthdays data from json file
$data = json_decode(file_get_contents('birthdays.json'), true);
// Check if there is an upcoming birtday
$tomorrow = strtotime("+1 day");
$tomorrow = date("j/n", $tomorrow);
$people = [];
foreach ($data as $item) {
    if($item['date'] == $tomorrow) {
        $people[] = $item['name'];
    }
}


// If no birthdays tomorrow - terminate
if (empty($people)) {
    telegramResponse("[telegram-birthday-notifier] - No birtdays tomorrow!");
}


// Your custom message from the bot & Append people to message
$message = "[telegram-birthday-notifier] - Birtdays tomorrow:\n" . implode(", \n", $people);
// send message if upcoming bdays
telegramResponse($message);
