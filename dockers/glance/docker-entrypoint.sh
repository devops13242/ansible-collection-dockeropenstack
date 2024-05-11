#!/bin/ash

conf_file='/etc/glance/glance-api.conf'

echo '[database]' >$conf_file
echo "connection = mysql+pymysql://glance:${GLANCE_DB_PASSWORD}@db/glance" >>$conf_file

echo '[keystone_authtoken]' >>$conf_file
echo 'www_authenticate_uri = http://keystone:5000' >>$conf_file
echo 'auth_url = http://keystone:5000' >>$conf_file
echo 'auth_type = password' >>$conf_file
echo 'project_domain_name = Default' >>$conf_file
echo 'user_domain_name = Default' >>$conf_file
echo 'project_name = service' >>$conf_file
echo 'username = glance' >>$conf_file
echo "password = ${GLANCE_USER_PASSWORD}" >>$conf_file

echo '[paste_deploy]' >>$conf_file
echo 'flavor = keystone' >>$conf_file

echo '[DEFAULT]' >>$conf_file
echo 'enabled_backends=fs:file' >>$conf_file

echo '[glance_store]' >>$conf_file
echo 'default_backend = fs' >>$conf_file

echo '[fs]' >>$conf_file
echo 'filesystem_store_datadir = /var/lib/glance/images/' >>$conf_file

echo '[oslo_limit]' >>$conf_file
echo 'auth_url = http://keystone:5000' >>$conf_file
echo 'auth_type = password' >>$conf_file
echo 'user_domain_id = default' >>$conf_file
echo 'username = glance' >>$conf_file
echo 'system_scope = all' >>$conf_file
echo "password = ${GLANCE_USER_PASSWORD}" >>$conf_file
echo "endpoint_id = ${GLANCE_ENDPOINT_ID}" >>$conf_file
echo 'region_name = RegionOne' >>$conf_file

glance-manage db_sync

/usr/bin/glance-api