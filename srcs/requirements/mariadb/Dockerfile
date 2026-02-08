FROM alpine:3.22

RUN apk add --no-cache mariadb

COPY ./tools/entrypoint.sh /

RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
