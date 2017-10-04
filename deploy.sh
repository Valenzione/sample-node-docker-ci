#!/bin/bash
docker build -t valenzione/sample-node .
docker push valenzione/sample-node

ssh  -i ~/.ssh/identity snyderino@35.202.98.145 << EOF
docker pull valenzione/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi valenzione/sample-node:current || true
docker tag valenzione/sample-node:latest valenzione/sample-node:current
docker run -d --net app --restart always --name web -p 80:80 valenzione/sample-node:current
EOF
