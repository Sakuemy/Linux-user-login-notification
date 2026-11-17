#!/bin/bash

# Параметры для отправки сообщений в Telegram
BOT_TOKEN="твой_токен_бота"
CHAT_ID="твой_ID_чата"

# Функция для отправки сообщения в Telegram
send_telegram_message() {
    local message=$1
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d chat_id=$CHAT_ID \
        -d text="$message"
}

# Функция для отслеживания входов через /var/log/auth.log
monitor_logins_authlog() {
    tail -Fn0 /var/log/auth.log | while read line; do
        # Отслеживание успешных входов (Accepted)
        if echo "$line" | grep -q "Accepted"; then
            user=$(echo $line | awk '{print $9}')
            ip=$(echo $line | awk '{print $11}')
            timestamp=$(echo $line | awk '{print $1 " " $2 " " $3}')
            message="Пользователь $user вошел на сервер с IP $ip в $timestamp"
            send_telegram_message "$message"
        fi
    done
}

# Запуск функции
monitor_logins_authlog