#!/bin/bash
/etc/init.d/cron start -D
crontab /var/spool/cron/crontabs/root
/usr/sbin/sshd -D
