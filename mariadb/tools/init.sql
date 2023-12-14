
-- If the database does not exist, create it
CREATE DATABASE IF NOT EXISTS wordpress CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- If the user does not exist, create it
CREATE USER IF NOT EXISTS 'faksouss'@'%' IDENTIFIED BY '131216';

-- Grant privileges
GRANT ALL PRIVILEGES ON mydatabase.* TO 'faksouss'@'%';
FLUSH PRIVILEGES;

-- Set an initial password for the root user (change 'root12345' to a secure password)
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root131216';
