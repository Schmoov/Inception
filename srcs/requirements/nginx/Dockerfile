FROM alpine:3.22

RUN apk add --no-cache nginx

#COPY html /usr/share/nginx/html
COPY site.conf /etc/nginx/http.d/default.conf 


EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
