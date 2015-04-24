#!/bin/bash
/etc/init.d/mysql start
# adduser --disabled-password --gecos '' railsusr
# cd /var/tmp; chown -R railsusr hackfsm
su -m railsusr -c /var/tmp/scripts/app-startup2.sh
