yum install epel-release -y && yum install spawn-fcgi php php-climod_fcgid httpd -y

systemctl daemon-reload
systemctl start spawn-fcgi
