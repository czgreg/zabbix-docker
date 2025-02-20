#!/bin/bash
set -ex

source ./.env

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
echo "ssl create on 127.0.0.1"
/bin/sh ./scripts/ssl.sh 127.0.0.1

# 拉取docker
sudo docker compose -f docker-compose.server.yaml up -d
