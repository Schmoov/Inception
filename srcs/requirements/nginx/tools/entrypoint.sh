#!/bin/sh

mkdir -p /etc/ssl/private /etc/ssl/certs /etc/nginx/http.d

openssl req \
	-x509 \
	-nodes \
	-newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out $CERTIF \
	-subj "/CN=$DOMAIN"

cat > /etc/nginx/http.d/default.conf <<EOF
server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name $DOMAIN;

    ssl_certificate $CERTIF;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;

    ssl_protocols TLSv1.3;

    root /var/www/html;

    index index.php;

    location ~ \.php\$ { 
            try_files \$uri =404;
            fastcgi_pass wordpress:9000;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        }
}
EOF

exec nginx -g "daemon off;"
