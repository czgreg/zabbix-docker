#!/bin/bash
baseshell=$(cd $(dirname $0)/..;pwd)


if [ ! -d "$baseshell/ssl" ]; then
  echo "Creating ssl folder..."
  mkdir "$baseshell/ssl"
  echo "ssl folder created successfully."
else
  echo "ssl folder already exists."
fi


#变量定义
IP=$1
#生成证书配置文件
cat > ${baseshell}/ssl/ssl.cnf << EOF
distinguished_name = req_distinguished_name
x509_extensions = v3_req
prompt = no
[req_distinguished_name]
C = CN
ST = GD
L = GZ
O = EDGE
OU = BASE
CN = $IP
[v3_req]
keyUsage = critical, digitalSignature, keyAgreement
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[ alt_names ]
DNS.1 = $IP
DNS.2 = 8.8.8.8
IP.1 = $IP
EOF

#生成crt和key证书
echo "Generating crt..."
openssl req -x509 -nodes -days 9999 -newkey rsa:2048 -keyout ${baseshell}/ssl/ssl.key -out ${baseshell}/ssl/ssl.crt -config ${baseshell}/ssl/ssl.cnf -sha256
echo "crt generated successfully."

echo "Generating dhparam.pem..."
openssl dhparam -out ${baseshell}/ssl/dhparam.pem 2048
echo "dhparam.pem generated successfully."

chmod -R 777 ${baseshell}/ssl
