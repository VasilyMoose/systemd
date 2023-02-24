#!/bin/bash
mv watchlog /var/log/
cd /etc/sysconfig/

systemctl daemon-reload
systemctl start watchlog.timer
