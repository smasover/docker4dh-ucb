#!/bin/bash
passtemp=`cat /var/tmp/secrets/mysql-secret.txt`
sed -i "s/password:/password: $passtemp/" /var/tmp/hackfsm/config/database.yml
