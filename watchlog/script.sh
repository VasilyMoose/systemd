#!/bin/bash
mv watchlog /var/log/
cd /etc/sysconfig/
cat << EOF > watchlog
#!/bin/bash
# Configuration file for my watchlog service
# Place it to /etc/sysconfig

# File and word in that file that we will be monit
WORD="ALERT"
LOG=/var/log/watchlog.log
EOF

##########################################################

cd /opt/
cat << EOF > watchlog.sh
#!/bin/bash

WORD=$1
LOG=$2
DATE=`date`

if grep $WORD $LOG &> /dev/null
then
        logger "$DATE: I found word, Master!"
else
        exit 0
fi
EOF

chmod +x /opt/watchlog.sh

############################################################
cd /etc/systemd/system/
cat << EOF > watchlog.timer

[Unit]
Description=Run watchlog script every 30 second

[Timer]
# Run every 30 second
OnUnitActiveSec=30
Unit=watchlog.service

[Install]
WantedBy=multi-user.target
EOF
##########################################################
cat << EOF > watchlog.service
[Unit]
Description=My watchlog service

[Service]
Type=oneshot
EnvironmentFile=/etc/sysconfig/watchlog
ExecStart=/opt/watchlog.sh $WORD $LOG
EOF
##########################################################

systemctl daemon-reload
systemctl start watchlog.timer
