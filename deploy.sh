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
  NEW_PORT=8082
  OLD_PORT=8081
else
  NEW="blue"
  NEW_PORT=8081
  OLD_PORT=8082
fi

echo "Current: $CURRENT → Deploy: $NEW"

# 새 버전 pull
docker pull $APP:$TAG

# 새 색 컨테이너 업데이트
export TAG=$TAG

docker compose up -d app-$NEW

# 헬스체크
#for i in {1..20}; do
#  if curl -fsS http://:8080/actuator/health >/dev/null; then
#    break
#  fi
#  sleep 3
#done

sudo ln -sf "/etc/nginx/sites-available/app-${NEW}.conf" /etc/nginx/sites-enabled/app.conf
sudo nginx -t
sudo systemctl reload nginx


# old stop
docker compose stop app-$CURRENT

echo "$NEW" > $COLOR_FILE
echo "Deployed → $NEW"