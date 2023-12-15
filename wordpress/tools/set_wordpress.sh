#!/bin/bash

cd /var/www/html

if [ ! -e /usr/local/bin/wp ]; then
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
fi

if ! wp core is-installed --allow-root; then
    wp core download --allow-root
fi

# Correct the wp config create command and add --path parameter to specify the WordPress installation path
wp config create --dbname=wordpress --dbuser=faksouss --dbpass=131216 --dbhost=mariadb --allow-root

wp core install --url="http://faksouss.42.fr" --title="Hello" --admin_user="admin" --admin_password="admin" --admin_email="fahdamineksouss@gmail.com" --allow-root

wp user create faksouss fahdamineksouss@gmail.com --role=author --user_pass=131216 --allow-root

rm -f wp-config-sample.php

wp plugin install akismet --allow-root

wp plugin activate akismet --allow-root

wp theme install neve --allow-root

wp theme activate neve --allow-root

# Ensure the directory exists before attempting to modify the PHP configuration
mkdir -p /run/php/

sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf