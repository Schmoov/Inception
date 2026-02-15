#!/bin/sh

mariadb-install-db --user=mysql --datadir=/var/lib/mysql

mariadbd --user=mysql --skip-networking &
pid="$!"

# Wait until MariaDB is ready
until mariadb-admin ping --silent; do
    sleep 1
done

# Create database and user
mariadb -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${DB};
CREATE USER IF NOT EXISTS '${DB_USR}'@'%' IDENTIFIED BY '${DB_PWD}';
GRANT ALL PRIVILEGES ON ${DB}.* TO '${DB_USR}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '12345';
FLUSH PRIVILEGES;
EOF

# Stop background server
kill "$pid"
wait "$pid"

# Start MariaDB in foreground (proper Docker behavior)
exec mariadbd --user=mysql
