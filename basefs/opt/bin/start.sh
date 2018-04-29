#!/bin/bash

if [ "${OD_ID}" ]
then
sed -i "s/ea2b36f6-b8ad-40be-bc0f-e5e4a4a7d4fa/${OD_ID}/g" ${HOME}/public/oneindex/config.php
sed -i "s/EIVCx5ztMSxMsga18MQ7rmGf9EIP7zv6tfimb0Kp5Uc=/${OD_SECRET}/g" ${HOME}/public/oneindex/config.php
sed -i "s#https://ju.tn/onedrive-login#${OD_URI}#g" ${HOME}/public/oneindex/config.php
fi

if [ "${CACHE_EXPIRE}" ]
then
sed -i "s/=> 3600,/=> ${CACHE_EXPIRE},/g" ${HOME}/public/oneindex/config.php
fi

if [ "${CACHE_REFRESH}" ]
then
sed -i "s/=> 600,/=> ${CACHE_REFRESH},/g" ${HOME}/public/oneindex/config.php
fi


echo "0 * * * * php ${HOME}/public/oneindex/one.php token:refresh" > ${HOME}/public/oneindex/crontab
echo "*/10 * * * * php ${HOME}/public/oneindex/one.php cache:refresh" > ${HOME}/public/oneindex/crontab
nohup ${HOME}/public/oneindex/supercronic ${HOME}/public/oneindex/crontab > /dev/null 2>&1 &

# Creates the .env file needs by Laravel using
# The environment variables set both by the system
# and the openshift application (deploy configuration)
env > /opt/app-root/src/.env

# Starts PHP FPM in a non-deamon mode (that is set on configuration)
php-fpm --fpm-config /etc/php7/php-fpm.conf -c /etc/php7/php.ini

# Starts caddy as a deamon using the custom configuration file
caddy -conf /etc/caddy/caddy.conf
