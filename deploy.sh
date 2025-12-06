#!/bin/bash
set -e

APP=jywon1128/dummy-app
TAG=$1
COLOR_FILE=./color

if [ ! -f $COLOR_FILE ]; then
  echo "blue" > $COLOR_FILE
fi

CURRENT=$(cat $COLOR_FILE)
if [ "$CURRENT" = "blue" ]; then
  NEW="green"
else
  NEW="blue"
fi

echo "Current: $CURRENT → Deploy: $NEW"

# 새 버전 pull
docker pull $APP:$TAG

# 새 색 컨테이너 업데이트
TAG=$TAG docker compose up -d app-$NEW

# nginx 스위치
if [ "$NEW" = "green" ]; then
  sed -i 's/server app-blue/# server app-blue/' nginx.conf
  sed -i 's/# server app-green/server app-green/' nginx.conf
else
  sed -i 's/server app-green/# server app-green/' nginx.conf
  sed -i 's/# server app-blue/server app-blue/' nginx.conf
fi

docker restart nginx

# old stop
docker compose stop app-$CURRENT

echo "$NEW" > $COLOR_FILE
echo "Deployed → $NEW"