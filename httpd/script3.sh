setenforce 0
sed -i '/Listen 80/d' /etc/httpd/conf/httpd.conf


systemctl daemon-reload
systemctl start httpd@httpd1
systemctl start httpd@httpd2
