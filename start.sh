#!/bin/bash
./root/env
crontab /var/spool/cron/crontabs/root
/etc/init.d/cron restart -D
/usr/sbin/sshd -D
