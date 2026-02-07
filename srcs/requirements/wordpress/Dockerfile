FROM alpine:3.22

RUN apk add --no-cache php-fpm php-mysql curl
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

#RUN mkdir -p /etc/php/fpm-pool.d
COPY ./tools/www.conf /etc/php/fpm-pool.d

COPY ./tools/entrypoint.sh /
#COPY ./tools/wp-config.php /

RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
