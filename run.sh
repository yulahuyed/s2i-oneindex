#!/bin/bash

sed -i "s/pgsql/$DB_TYPE/g" /opt/app-root/src/tt-rss/config.php
sed -i "s/localhost/$DB_HOST/g" /opt/app-root/src/tt-rss/config.php
sed -i "s/yhiblog/$DB_USER/g" /opt/app-root/src/tt-rss/config.php
sed -i "s/yhiblog/$DB_NAME/g" /opt/app-root/src/tt-rss/config.php
sed -i "s/yhiblog/$DB_PASS/g" /opt/app-root/src/tt-rss/config.php
sed -i "s/5432/$DB_PORT/g" /opt/app-root/src/tt-rss/config.php
sed -i "s/https:\/\/shui.azurewebsites.net\//$SELF_URL_PATH/g" /opt/app-root/src/tt-rss/config.php


echo "*/5 * * * * php /opt/app-root/src/tt-rss/update.php --feeds --quiet" > /opt/app-root/src/tt-rss/crontab
nohup /opt/app-root/src/tt-rss/supercronic /opt/app-root/src/tt-rss/crontab > /dev/null 2>&1 &
