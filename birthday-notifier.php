<?php

// Send Telegram Message
function telegramResponse($msg) {
    $telegramBotToken = 'YOUR_BOT_TOKEN';
    $telegramChatID = 'CHAT_ID';

    $telegramApiURL = "https://api.telegram.org/bot$telegramBotToken/sendMessage?chat_id=$telegramChatID&text=" . urlencode($msg);
    $response = file_get_contents($telegramApiURL);
}


// Get birthdays data from json
$data = json_decode(file_get_contents('birthdays.json'), true);

// Check if there is an upcoming birtday
$tomorrow = date("j/n", strtotime("+1 day"));
$people = [];
foreach ($data as $item) {
    if($item['date'] == $tomorrow) {
        $people[] = $item['name'];
    }
}


// If no birthdays tomorrow - terminate
if (empty($people)) {
    telegramResponse("[telegram-birthday-notifier] - No birtdays tomorrow!");
    exit;
}


// Your custom message from the bot & Append people to message
$message = "[telegram-birthday-notifier] - Birtdays tomorrow:\n" . implode(", \n", $people);
// send message if upcoming bdays
telegramResponse($message);
exit;
