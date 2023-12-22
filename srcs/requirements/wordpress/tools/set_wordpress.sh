#!/bin/bash

# Specify the WordPress installation path
wordpress_path="/var/www/html/"

mkdir -p $wordpress_path

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
    wp config create --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PSW} --dbhost=${DB_HOST} --allow-root --path="$wordpress_path"
fi

# Check if wp-config.php is created successfully
if [ -e "${wordpress_path}wp-config.php" ]; then
    # Install WordPress
    wp core install --url="https://${DOMAIN_NAME}" --title="Hello" --admin_user=${WP_ADMINE_USR} --admin_password="lol131216" --admin_email=${WP_ADMINE_USR_EMAIL} --allow-root --path="$wordpress_path"

    # Create a user
    wp user create ${WP_USR} ${WP_USR_EMAIL} --role=author --user_pass=sus131216 --allow-root --path="$wordpress_path"

    # Remove wp-config-sample.php
    rm -f "${wordpress_path}wp-config-sample.php"

    # Install and activate plugins
    wp plugin install akismet --allow-root --path="$wordpress_path"
    wp plugin activate akismet --allow-root --path="$wordpress_path"
    wp plugin install redis-cache --activate --allow-root  --path="$wordpress_path"
    wp plugin update --all --allow-root  --path="$wordpress_path"
    wp config set WP_REDIS_HOST redis --add --allow-root --path="$wordpress_path"
    wp config set WP_REDIS_PORT 6379 --add --allow-root  --path="$wordpress_path"
    wp config set WP_CACHE true --add --allow-root  --path="$wordpress_path"
    wp redis enable --allow-root  --path="$wordpress_path"

    # Install and activate theme
    wp theme install neve --allow-root --path="$wordpress_path"
    wp theme activate neve --allow-root --path="$wordpress_path"

    # Ensure the directory exists before attempting to modify the PHP configuration
    mkdir -p /run/php/
    sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf
else
    echo "Error: 'wp-config.php' not found. Please check if the wp config create command was successful."
fi


/usr/sbin/php-fpm7.3 -F