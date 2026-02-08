#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadbd --initialize-insecure --user=mysql --datadir=/var/lib/mysql
    mariadbd --user=mysql --datadir=/var/lib/mysql --skip-networking &
    MYSQL_PID=$!
    sleep 2
    mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS $DB;
CREATE USER IF NOT EXISTS '$DB_USR'@'%' IDENTIFIED BY '$DB_PWD';
GRANT ALL PRIVILEGES ON $DB.* TO '$DB_USR'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '12345';
FLUSH PRIVILEGES;
EOF

    kill $MYSQL_PID
    wait $MYSQL_PID
fi

exec mariadbd --user=mysql --datadir=/var/lib/mysql
