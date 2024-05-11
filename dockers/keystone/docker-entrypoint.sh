#!/bin/ash

echo '[database]' >/etc/keystone/keystone.conf
echo "connection = mysql+pymysql://keystone:${KEYSTONE_DB_PASSWORD}@db/keystone" >>/etc/keystone/keystone.conf
echo '[token]' >>/etc/keystone/keystone.conf
echo 'provider = fernet' >>/etc/keystone/keystone.conf

keystone-manage db_sync
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

keystone-manage bootstrap --bootstrap-password ${ADMIN_PASSWORD} \
  --bootstrap-admin-url http://keystone:5000/v3/ \
  --bootstrap-internal-url http://keystone:5000/v3/ \
  --bootstrap-public-url http://localhost:5000/v3/ \
  --bootstrap-region-id RegionOne

httpd -D FOREGROUND
