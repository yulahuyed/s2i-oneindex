#!/bin/bash

if [ "${DB_USER}" ]
then

sed -i "s/pgsql/$DB_TYPE/g" ${HOME}/public/tt-rss/config.php
sed -i "s/5432/$DB_PORT/g" ${HOME}/public/tt-rss/config.php
sed -i "s/127.0.0.1/$DB_HOST/g" ${HOME}/public/tt-rss/config.php
sed -i "s/Uyhiblog/$DB_USER/g" ${HOME}/public/tt-rss/config.php
sed -i "s/Nyhiblog/$DB_NAME/g" ${HOME}/public/tt-rss/config.php
sed -i "s/Pyhiblog/$DB_PASS/g" ${HOME}/public/tt-rss/config.php
sed -i "s#https://shui.azurewebsites.net/#$SELF_URL_PATH#g" ${HOME}/public/tt-rss/config.php

php -f ${HOME}/public/tt-rss/ttrss-configure-db.php

else
rm ${HOME}/public/tt-rss/config.php
fi


echo "*/5 * * * * php ${HOME}/public/tt-rss/update.php --feeds --quiet" > ${HOME}/public/tt-rss/crontab
nohup ${HOME}/public/tt-rss/supercronic ${HOME}/public/tt-rss/crontab > /dev/null 2>&1 &

# Creates the .env file needs by Laravel using
# The environment variables set both by the system
# and the openshift application (deploy configuration)
env > /opt/app-root/src/.env

# Starts PHP FPM in a non-deamon mode (that is set on configuration)
php-fpm --fpm-config /etc/php7/php-fpm.conf -c /etc/php7/php.ini

# Starts caddy as a deamon using the custom configuration file
caddy -conf /etc/caddy/caddy.conf
