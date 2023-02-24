yum install epel-release -y && yum install spawn-fcgi php php-climod_fcgid httpd -y

rm -rf /etc/sysconfig/spawn-fcgi
mv /root/systemd/spawn_fcgi/spawn-fcgi /etc/sysconfig/
mv /root/systemd/spawn_fcgi/spawn-fcgi.service /etc/systemd/system/

systemctl daemon-reload
systemctl start spawn-fcgi
