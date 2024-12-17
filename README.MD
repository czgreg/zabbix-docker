# Zabbix + Grafana ALLINONE （ Minimize Deployment Plan）

## System Configration：
```
system： Debian 12
cpu: 8 core/16 core
memory: 16G/32G
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
url : https://{server_ip}:8443
user: Admin
pwd: zabbix

Grafana
url : https://{server_ip}:3443
user: admin
pwd: admin
```
## Other
```
8955: zabbix server dashboard
```
## Zabbix Proxy
当监控主机和监控项过多时，建议引入Proxy进行分担。Proxy与Server不建议Allinone部署。

## Debian 
```
apt install ufw
export PATH=$PATH:/usr/sbin
ufw status
```
## 自签名证书
```
# 生成自签名证书, ip为终端访问的ip
./scripts/ssl.sh 127.0.0.1

访问http端口默认 8080
访问https端口默认 8443

```
## 快速创建设备组与设备
```
修改 init/devices.txt
python3 init/init.py
```