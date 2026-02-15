#!/bin/sh

if [ ! -e /etc/.firstrun ]; then
    cat << EOF >> /etc/my.cnf.d/mariadb-server.cnf
[mysqld]
bind-address=0.0.0.0
skip-networking=0
EOF
    touch /etc/.firstrun
fi

mariadb-install-db --user=mysql --datadir=/var/lib/mysql

mariadbd --user=mysql


# Create database and user
mariadb -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${DB};
CREATE USER IF NOT EXISTS '${DB_USR}'@'%' IDENTIFIED BY '${DB_PWD}';
GRANT ALL PRIVILEGES ON ${DB}.* TO '${DB_USR}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '12345';
FLUSH PRIVILEGES;
EOF


exec mysqld_safe
