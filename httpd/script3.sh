setenforce 0
sed -i '/Listen 80/d' /etc/httpd/conf/httpd.conf

cat << EOF > /etc/systemd/system/httpd@.service
[Unit]
Description=The Apache HTTP Server
After=network.target remote-fs.target nss-lookup.target
Documentation=man:httpd(8)
Documentation=man:apachectl(8)

[Service]
Type=notify
EnvironmentFile=/etc/sysconfig/%I
ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND
ExecReload=/usr/sbin/httpd $OPTIONS -k graceful
ExecStop=/bin/kill -WINCH ${MAINPID}
KillSignal=SIGCONT
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

#########################################################

cat << EOF > /etc/sysconfig/httpd1
PORT=8000
PID_FILE=/etc/httpd/run/httpd1.pid
EOF

cat << EOF > /etc/sysconfig/httpd2
PORT=8001
PID_FILE=/etc/httpd/run/httpd2.pid
EOF

cat << EOF > /etc/httpd/conf.d/tmp.conf
Listen ${PORT}
PidFile ${PID_FILE}
EOF
#########################################################
systemctl daemon-reload
systemctl start httpd@httpd1
systemctl start httpd@httpd2
