#!/usr/bin/python3
# -*- coding: utf-8 -*-

import requests
import json
import sys
import os

# 从环境变量中获取LARK_WEBHOOK_URL
lark_webhook_url = os.getenv('LARK_WEBHOOK_URL')

print(lark_webhook_url)

def send_message(color,subject, message):

    payload_message = {
        "msg_type": "interactive",
        "card": {
            "config": {
                "wide_screen_mode": True
            },
            "header": {
                "title": {
                    "tag": "plain_text",
                    "content": subject
                },
                # ใส่สีให้ header (เลือกสีจาก list ข้างต้นได้)
                # red, green, blue, yellow
                "template": color
            },
            "elements": [
                {
                    "tag": "div",
                    "text": {
                        "tag": "lark_md",
                        "content": message
                    }
                }
            ]
        }
    }
    headers = {
       'Content-Type': 'application/json'
    }

    response = requests.request("POST", lark_webhook_url, headers=headers, data=json.dumps(payload_message))
    print(response)
    return response

if __name__ == '__main__':
     t1,t2,t3 = sys.argv[1],sys.argv[2],sys.argv[3]
     send_message(t1,t2,t3)