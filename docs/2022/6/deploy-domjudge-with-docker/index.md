# Deploy DOMjudge with Docker

## MariaDB

```bash
#! /bin/bash

TOP_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

TAG="10.8.3"

docker run \
    -d \
    --restart=always \
    --hostname=mysql \
    --name=dj-mariadb \
    -e TZ=Asia/Shanghai \
    -e MYSQL_USER=domjudge \
    -e MYSQL_ROOT_PASSWORD=${root password} \
    -e MYSQL_DATABASE=domjudge \
    -e MYSQL_PASSWORD=${password for domjudge user} \
    -p 3306:3306 \
    -v "${TOP_DIR}"/mariadb-data:/var/lib/mysql \
    mariadb:${TAG} \
    --max-connections=1000 \
    --max_allowed_packet=268435456 \
    --innodb_log_file_size=1073741824
```

## DOMserver

```bash
#! /bin/bash

TOP_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

TAG="latest"

docker run \
    --link mariadb:mariadb \
    -d \
    --restart=always \
    -e TZ=Asia/Shanghai \
    -e WEBAPP_BASEURL=/domjudge \
    -e TRUSTED_PROXIES=127.0.0.1,172.17.0.1 \
    -e MYSQL_HOST=mariadb \
    -e MYSQL_DATABASE=domjudge \
    -e MYSQL_USER=domjudge \
    -e MYSQL_PASSWORD=${password for domjudge user} \
    -e MYSQL_ROOT_PASSWORD=${root password} \
    -v "${TOP_DIR}"/data/images/affiliations:/opt/domjudge/domserver/webapp/public/images/affiliations \
    -p 8101:80 \
    --name domserver \
    dup4/domjudge-domserver:"${TAG}"
```

## JudgeHost

```bash
#! /bin/bash

ID="${1}"
DAEMON_ID="${2}"
PASSWORD="${3}"
TAG="latest"

docker run \
    -d \
    --restart=always \
    --privileged \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --name judgehost-"${ID}" \
    --hostname judgedaemon-"${ID}" \
    -e TZ=Asia/Shanghai \
    -e DAEMON_ID="${DAEMON_ID}" \
    -e JUDGEDAEMON_PASSWORD="${PASSWORD}" \
    -e DOMSERVER_BASEURL=http://127.0.0.1/domjudge/ \
    dup4/domjudge-judgehost:"${TAG}"
```
