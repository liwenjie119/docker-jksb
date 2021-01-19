#!/bin/bash
crontab /var/spool/cron/crontabs/root
export >> /root/dockerenv
/etc/init.d/cron restart -D
/usr/sbin/sshd -D
