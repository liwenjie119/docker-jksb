#!/bin/bash
/etc/init.d/cron start -D
crontab /var/spool/cron/crontabs/root
env >> /root/dockerenv
/usr/sbin/sshd -D
