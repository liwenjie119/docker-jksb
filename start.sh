#!/bin/bash
env >> /etc/default/locale
crontab /var/spool/cron/crontabs/root
/etc/init.d/cron restart -D
/usr/sbin/sshd -D
