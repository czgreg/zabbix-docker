# Zabbix + Grafana ALL IN ONE 最小化部署方案

## 软硬件配置：
System： Debian 12
cpu: 4核/8核
ram: 8G/16G
硬盘：500G


## 安装步骤

apt-get update
apt-get install git -y
git clone https://github.com/czgreg/zabbix-docker.git
cd zabbix-docker/
./bootstrap.sh

## Url
Zabbix
url : http://{server_ip}:8080
user: Admin  
pwd: zabbix

Grafana
url : http://{server_ip}:3000
user: admin  
pwd: admin

## Other

8955: zabbix server dashboard