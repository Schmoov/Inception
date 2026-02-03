FROM alpine:3.22

RUN apk add --no-cache php82-fpm 

COPY wordpress /var/www/html

EXPOSE 9000

CMD ["php-fpm82", "-F"]

