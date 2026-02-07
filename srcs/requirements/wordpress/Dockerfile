FROM alpine:3.22

RUN apk update && apk upgrade
RUN apk add --no-cache \
	php83 \
	php83-cli \
	php83-curl \
	php83-phar \
	php83-json \
	php83-fpm \
	curl
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

#RUN mkdir -p /etc/php/fpm-pool.d
COPY ./tools/www.conf /etc/php/fpm-pool.d

COPY ./tools/entrypoint.sh /
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
