#!/bin/bash
set -ex

# 更新软件包列表
sudo apt update
# 安装Docker所需依赖包
sudo apt-get -y install ca-certificates curl
# 创建/etc/apt/keyrings目录，并下载Docker的官方GPG密钥到该目录
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# 将Docker仓库添加到系统的软件源列表
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] http://mirrors.aliyun.com/docker-ce/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# 更新软件包列表
sudo apt update
# 安装Docker和DockerCompose
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# 查看docker版本信息
docker -v


# 签证
source ./.env
echo "ssl create on $HOSTNAME"
/bin/sh ./scripts/ssl.sh $HOSTNAME

# 拉取docker
sudo docker compose up -d

check_zabbix() {
    response=$(curl --location --request GET http://localhost:8088/api_jsonrpc.php --header 'Content-Type: application/json' --data '{}' 2>/dev/null)
    error_code=$(echo $response | grep -o '"code":-32600')
    if [[ -n $error_code ]]; then
        return 0
    else
        echo "Waiting for zabbix. Retrying in 5 seconds..."
        return 1
    fi
}

retry=0
while [ $retry -lt 30 ]; do
    if check_zabbix; then
        echo "zabbix is healthy."
        break
    fi
    sleep 5
    ((retry++))
done

if [ $retry -eq 30 ]; then
    echo "zabbix check failed after 30 retries. Exiting."
    exit 1
fi