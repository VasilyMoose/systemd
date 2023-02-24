#!/bin/bash
setenforce 0
sed -i '/Listen 80/d' /etc/httpd/conf/httpd.conf
cp /root/systemd/httpd/httpd@.service /etc/systemd/system
cp /root/systemd/httpd/tmp.conf /etc/httpd/conf.d/tmp.conf
cp /root/systemd/httpd/httpd{1,2} /etc/sysconfig
systemctl enable --now httpd@httpd1.service
systemctl enable --now httpd@httpd2.service
