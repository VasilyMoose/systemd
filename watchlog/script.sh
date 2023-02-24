#!/bin/bash
mv /root/systemd/watchlog/watchlog.log /var/log/

mv /root/systemd/watchlog/watchlog.sh /opt/
chmod +x /opt/watchlog.sh
 
mv /root/systemd/watchlog/watchlog.timer /etc/systemd/system/
mv /root/systemd/watchlog/watchlog.service /etc/systemd/system/

systemctl daem/on-reload
systemctl start watchlog.timer
