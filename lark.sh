#!/bin/bash

# read the config.ini
config_file="/usr/lib/zabbix/alertscripts/config.ini"
url=$(grep '^webhook_url' "$config_file" | cut -d'=' -f2)

if [ -z "$1" ]; then
    echo "Usage: $0 <message>"
    exit 1
fi

# function to send a message
send_message() {
    local message="$1"
    local payload="{\"msg_type\": \"text\",\"content\": {\"text\": \"$message\"}}"

    curl -X POST -H "Content-Type: application/json" -d "$payload" $url
}

# get the message from command line argument
text="$1"

# call the function
send_message "$text"
