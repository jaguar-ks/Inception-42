#!/bin/bash

adduser $FTP_USER  --disabled-password

mkdir -p /home/$FTP_USER/ftp

mkdir -p /var/run/vsftpd/empty

mkdir -p /home/$FTP_USER/ftp/test

cp /etc/vsftpd.conf /etc/vsftpd.conf.bak

mv /vsftpd.conf /etc/vsftpd.conf

echo "$FTP_USER:$FTP_PSW" | chpasswd &> /dev/null

chown "$FTP_USER:$FTP_USER" /home/fahd/ftp/test

chmod +x /etc/vsftpd.conf

echo $FTP_USER | tee -a /etc/vsftpd.userlist &> /dev/null

vsftpd /etc/vsftpd.conf