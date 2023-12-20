#!/bin/bash

cat << EOF > init.sql
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PSW}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_R_PSW}';
FLUSH PRIVILEGES;
EOF

service mysql start

mysql < init.sql

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
