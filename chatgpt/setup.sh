#!/bin/bash

apt-get update
apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
echo | add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io
echo ""
echo ""
read -p "请输入 openai_api_key: " openai_api_key
read -p "请输入访问密码（建议填写，不填默认为无密码）: " password
read -p "请输入访问端口（不填默认为80端口）: " port
port=${port:-80}
docker run --restart=always -d -p $port:3000 -e OPENAI_API_KEY="$openai_api_key" -e CODE="$password" yidadaa/chatgpt-next-web
public_ip=$(curl -s https://ipinfo.io/ip)
echo ""
echo ""
echo "私有 ChatGPT 部署完成"
if [ "$port" -eq 80 ]; then
    echo "访问链接：$public_ip"
else
    echo "访问链接：$public_ip:${port}"
fi
