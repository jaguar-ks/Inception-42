#!/bin/bash

# Specify the WordPress installation path
wordpress_path="/var/www/html/"

cd "$wordpress_path"

# Check if wp-cli is installed
if [ ! -e /usr/local/bin/wp ]; then
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
fi

# Check if WordPress is installed
if ! wp core is-installed --allow-root --path="$wordpress_path"; then
    # Download WordPress if not installed
    wp core download --allow-root --path="$wordpress_path"
fi

# Check if wp-config.php exists
if [ ! -e "${wordpress_path}wp-config.php" ]; then
    # Create wp-config.php with database details
    wp config create --dbname=wordpress --dbuser=faksouss --dbpass=131216 --dbhost=mariadb --allow-root --path="$wordpress_path"
fi

# Check if wp-config.php is created successfully
if [ -e "${wordpress_path}wp-config.php" ]; then
    # Install WordPress
    wp core install --url="http://faksouss.42.fr" --title="Hello" --admin_user="admin" --admin_password="admin" --admin_email="fahdamine59@gmail.com" --allow-root --path="$wordpress_path"

    # Create a user
    wp user create faksouss fahdamine59@gmail.com --role=author --user_pass=131216 --allow-root --path="$wordpress_path"

    # Remove wp-config-sample.php
    rm -f "${wordpress_path}wp-config-sample.php"

    # Install and activate plugins
    wp plugin install akismet --allow-root --path="$wordpress_path"
    wp plugin activate akismet --allow-root --path="$wordpress_path"

    # Install and activate theme
    wp theme install neve --allow-root --path="$wordpress_path"
    wp theme activate neve --allow-root --path="$wordpress_path"

    # Ensure the directory exists before attempting to modify the PHP configuration
    mkdir -p /run/php/
else
    echo "Error: 'wp-config.php' not found. Please check if the wp config create command was successful."
fi

sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

/usr/sbin/php-fpm7.3 -F