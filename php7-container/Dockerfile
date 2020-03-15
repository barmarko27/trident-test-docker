FROM nanoninja/php-fpm:7.3.2

RUN apt-get update && apt-get install -y build-essential libz-dev

RUN pecl channel-update pecl.php.net

RUN docker-php-ext-install gettext opcache intl bcmath sockets calendar dba exif sockets wddx sysvsem sysvshm sysvmsg

RUN apt-get update && apt-get install -y libssh-dev

RUN docker-php-ext-enable memcached gettext opcache intl bcmath sockets calendar dba exif sockets wddx sysvsem sysvshm sysvmsg

COPY www.conf /usr/local/etc/php-fpm.d/www.conf

#INSTALLING COMPOSER

RUN apt-get update && \
    apt-get install -y --no-install-recommends git zip

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

# INSTALLING CRONTAB

RUN apt-get update && apt-get install -y cron 

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod 755 /docker-entrypoint.sh

RUN sed -i "s/127.0.0.1:9000/127.0.0.1:9002/g" /usr/local/etc/php-fpm.d/www.conf.default

RUN sed -i "s/127.0.0.1:9000/127.0.0.1:9002/g" /usr/local/etc/php-fpm.d/www.conf

RUN sed -i "s/listen = 9000/listen = 9002/g" /usr/local/etc/php-fpm.d/zz-docker.conf

RUN echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/www.conf

RUN echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.conf.default

EXPOSE 9002

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["php72crontab"]

