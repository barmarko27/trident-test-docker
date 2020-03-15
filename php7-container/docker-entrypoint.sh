#!/bin/sh

if [ "$1" = 'php72crontab' ]; then

	echo "Avvio cron daemon..."

    cron -f &

    sleep 3

	echo "Start PHP 7..."

    php-fpm 

else
  exec "$@"
fi
