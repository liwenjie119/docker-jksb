#!/bin/bash
source /etc/profile
crontab /var/spool/cron/crontabs/root
/etc/init.d/cron restart -D
/usr/sbin/sshd -D
