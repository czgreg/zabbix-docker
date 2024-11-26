#!/usr/bin/python3
# -*- coding: utf-8 -*-

import requests
import json
import sys


url = "https://open.feishu.cn/open-apis/bot/v2/hook/xxxx-xx-xxx-xxxx"

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

    response = requests.request("POST", url, headers=headers, data=json.dumps(payload_message))
    return response

if __name__ == '__main__':
     text = sys.argv[1]
     send_message(text)