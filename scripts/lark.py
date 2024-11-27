#!/usr/bin/python3
# -*- coding: utf-8 -*-

import requests
import json
import sys
import os

# 从环境变量中获取LARK_WEBHOOK_URL
lark_webhook_url = os.getenv('LARK_WEBHOOK_URL')

print(lark_webhook_url)

def send_message(message):
    payload_message = {
       "msg_type": "text",
       "content": {
           "text": message
         }
    }
    headers = {
       'Content-Type': 'application/json'
    }

    response = requests.request("POST", lark_webhook_url, headers=headers, data=json.dumps(payload_message))
    print(response)
    return response

if __name__ == '__main__':
     text = sys.argv[1]
     send_message(text)