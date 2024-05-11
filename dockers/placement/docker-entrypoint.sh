#!/bin/ash

conf_file='/etc/placement/placement.conf'

echo '[placement_database]' >$conf_file
echo "connection = mysql+pymysql://placement:${PLACEMENT_DB_PASSWORD}@db/placement" >>$conf_file

echo '[api]' >>$conf_file
echo 'auth_strategy = keystone' >>$conf_file

echo '[keystone_authtoken]' >>$conf_file
echo 'www_authenticate_uri = http://keystone:5000' >>$conf_file
echo 'auth_url = http://keystone:5000' >>$conf_file
echo 'auth_type = password' >>$conf_file
echo 'project_domain_name = Default' >>$conf_file
echo 'user_domain_name = Default' >>$conf_file
echo 'project_name = service' >>$conf_file
echo 'username = placement' >>$conf_file
echo "password = ${PLACEMENT_USER_PASSWORD}" >>$conf_file

placement-manage db sync

uwsgi -M --http :8778 --wsgi-file /usr/bin/placement-api \
        --processes 2 --threads 10