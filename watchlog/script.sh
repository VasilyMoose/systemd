#!/bin/bash
mv watchlog /var/log/
cd /etc/sysconfig/
mv watchlog.sh /opt/
chmod +x /opt/watchlog.sh
 
mv watchlog.timer /etc/systemd/system/
mv watchlog.service /etc/systemd/system/

systemctl daemon-reload
systemctl start watchlog.timer
