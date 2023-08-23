#!/bin/bash

apt-get update
apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io
read -p "请输入 openai_api_key: " openai_api_key
read -p "请输入访问密码: " password
docker run --restart=always -d -p 80:3000 -e OPENAI_API_KEY="$openai_api_key" -e CODE="$password" yidadaa/chatgpt-next-web
