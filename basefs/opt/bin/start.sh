#!/bin/bash

php-fpm --fpm-config /etc/php7/php-fpm.conf -c /etc/php7/php.ini

caddy -conf /etc/caddy/caddy.conf