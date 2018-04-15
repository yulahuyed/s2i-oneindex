#!/bin/bash


sed -i "s/pgsql/$DB_TYPE/g" /opt/app-root/src/public/tt-rss/config.php
sed -i "s/127.0.0.1/$DB_HOST/g" /opt/app-root/src/public/tt-rss/config.php
sed -i "s/Uyhiblog/$DB_USER/g" /opt/app-root/src/public/tt-rss/config.php
sed -i "s/Nyhiblog/$DB_NAME/g" /opt/app-root/src/public/tt-rss/config.php
sed -i "s/Pyhiblog/$DB_PASS/g" /opt/app-root/src/public/tt-rss/config.php
sed -i "s/5432/$DB_PORT/g" /opt/app-root/src/public/tt-rss/config.php
sed -i "s#https://shui.azurewebsites.net/#$SELF_URL_PATH#g" /opt/app-root/src/public/tt-rss/config.php


echo "*/5 * * * * php /opt/app-root/src/tt-rss/update.php --feeds --quiet" > /opt/app-root/src/public/tt-rss/crontab
nohup /opt/app-root/src/public/tt-rss/supercronic /opt/app-root/src/public/tt-rss/crontab > /dev/null 2>&1 &

# Creates the .env file needs by Laravel using
# The environment variables set both by the system
# and the openshift application (deploy configuration)
env > /opt/app-root/src/.env

# Starts PHP FPM in a non-deamon mode (that is set on configuration)
php-fpm --fpm-config /etc/php7/php-fpm.conf -c /etc/php7/php.ini

# Starts caddy as a deamon using the custom configuration file
caddy -conf /etc/caddy/caddy.conf
