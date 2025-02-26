# Zabbix + Grafana ALLINONE （ Minimize Deployment Plan）

## System Configration：
```
zabbix-server:
system： Debian 12
cpu: 8 core/16 core
memory: 16G/32G
disk：1000G

zabbix-proxy:
system： Debian 12
cpu: 4 core
memory: 8G
disk：100G
```

## Zabbix Server Install
```
apt-get update
apt-get install git -y
git clone https://github.com/czgreg/zabbix-docker.git
cd zabbix-docker/

copy env.server.example .env  # 修改环境变量

./bootstrap.server.sh
```
## Login Url
```
Zabbix
url : https://{server_ip}:8443
user: Admin
pwd: zabbix

服务端需要将该server_ip tcp port 10051端口开放给
```


## Zabbix Proxy Install
```
apt-get update
apt-get install git -y
git clone https://github.com/czgreg/zabbix-docker.git
cd zabbix-docker/

copy env.proxy.example .env  # 修改环境变量

./bootstrap.proxy.sh
```