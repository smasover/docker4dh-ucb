#!/bin/bash
/etc/init.d/mysql start
su -m railsusr -c /var/tmp/scripts/app-startup2.sh
