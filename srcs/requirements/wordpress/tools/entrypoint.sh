#!/bin/sh

mkdir -p $WEB_DIR
cd $WEB_DIR
rm -rf *

sed -i 's/^memory_limit\s*=.*/memory_limit = 512M/' /etc/php83/php.ini
wp core download --allow-root
mv wp-config-sample.php wp-config.php

wp config set DB_NAME $DB --allow-root
wp config set DB_USER $DB_USR --allow-root
wp config set DB_PASSWORD $DB_PWD --allow-root

wp core install \
    --url=$DOMAIN \
    --title="$WP_TITLE" \
    --admin_user=$WP_ADMIN_USR \
    --admin_password=$WP_ADMIN_PWD \
    --admin_email=$WP_ADMIN_EMAIL \
    --skip-email \
    --allow-root

wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

wp theme install astra --activate --allow-root
wp plugin install redis-cache --activate --allow-root
wp plugin update --all --allow-root

wp redis enable --allow-root

/usr/sbin/php-fpm83 -F
