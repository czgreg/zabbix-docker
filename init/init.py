#!/usr/bin/evn python
# -*- coding: utf-8 -*-

import requests
import json
from pathlib import Path

ZABIX_ADD = 'http://127.0.0.1:8080'
url = ZABIX_ADD + '/api_jsonrpc.php'
template_id = 10564

group_name = "NetDevices"
group_netdevices_id = None

PROJECT_DIR = Path(__file__).parent
Devices_path = f"{PROJECT_DIR}/devices.txt"

file = open(Devices_path,'r')
data = file.read()
# 清除空行并按行分割字符串
lines = data.strip().split('\n')

# 创建一个空列表来存储结果
hosts = []

# 每两行为一组，分别为设备名称和 IP 地址
for i in range(0, len(lines), 3):
    if lines[i] and lines[i+1]:  # 判断设备名称和 IP 地址都不为空
        hosts.append([lines[i], lines[i+1]])

file.close()

# print(len(hosts))
# sys.exit()
# user.login
payload = {
    "jsonrpc" : "2.0",
    "method" : "user.login",
    "params" : {
        'username' : 'Admin',
        'password' :'zabbix',
        },
    "auth" : None,
    "id" : 0,
}

headers = {
    'content-type' : 'application/json',
}

req = requests.post(url, json=payload, headers=headers)
auth = req.json()



payload = {
    "jsonrpc": "2.0",
    "method": "hostgroup.create",
    "params": {
        "name": group_name
    },
    "auth" : auth['result'],
    "id" : 0,
}
res2 = requests.post(url, data=json.dumps(payload), headers=headers)
res2 = res2.json()
group_netdevices_id = res2["result"]["groupids"][0]



for i in hosts:
    try:
        host = i[1]            
        name = i[0]              

        #print(desc)
        payload = {
            "jsonrpc": "2.0",
            "method": "host.create",
            "params": {
                "host": host,
                "name":name,
                "interfaces": [
                    {
                        "type": 2,
                        "main": 1,
                        "useip": 1,
                        "ip": host,
                        "dns": "",
                        "port": "161",
                        "details":{
                            "version": 2,
                            "bulk": 1,
                            "community": "public"
                        }
                    }
                ],
                "groups": [
                    {
                        "groupid": group_netdevices_id
                    }
                ],
                "templates": [
                    {
                        "templateid": template_id
                    }
                ]
            },
            "auth" : auth['result'],
            "id" : 2,
        }
        res2 = requests.post(url, data=json.dumps(payload), headers=headers)
        res2 = res2.json()
        print(res2)
    except IndexError:
        break