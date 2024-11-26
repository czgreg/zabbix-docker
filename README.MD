# Zabbix + Grafana ALLINONE （ Minimize Deployment Plan）

## System Configration：
```
system： Debian 12
cpu: 4 core/8 core
memory: 8G/16G
disk：500G
```

## Install
```
apt-get update
apt-get install git -y
git clone https://github.com/czgreg/zabbix-docker.git
cd zabbix-docker/
./bootstrap.sh
```
## Url
```
Zabbix
url : http://{server_ip}:8080
user: Admin  
pwd: zabbix

Grafana
url : http://{server_ip}:3000
user: admin  
pwd: admin
```
## Other
```
8955: zabbix server dashboard
```

## Zabbix Feishu Alert
zabbix环境安装python
```
docker exec --privileged -u root -it zabbix-server /bin/bash
apt-get update
apt-get install -y python3 python3-pip
pip install requests
```