
#!/bin/bash

if [ -d 'ssl']; then
    cd ssl
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=MA/ST=BENIMALAL-KHNEFRA/L=KHOURIBGA/O=Example/CN=example.com"
else
    mkdir 'ssl'
    cd ssl
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=MA/ST=BENIMALAL-KHNEFRA/L=KHOURIBGA/O=Example/CN=example.com"
fi
