#!/bin/bash
#el script se interrumpe si hay un error
set -e 


# este script sirve para migrar mysql a mysql

# db
# MYSQL_DB="db_name"
# # db origen
# MYSQL_HOSTNAME_ORIGEN="localhost"
# MYSQL_USERNAME_ORIGEN="root"
# MYSQL_PASSWORD_ORIGEN=""

# # db destino
# MYSQL_HOSTNAME_DESTINO="localhost"
# mysql_username_destino="root"
# PASSWD_destino=""

# download mysql dump
mysqldump -h $MYSQL_HOSTNAME_ORIGEN  -u $MYSQL_USERNAME_ORIGEN  -p$MYSQL_PASSWORD_ORIGEN --default-character-set=utf8 --protocol=tcp --single-transaction --compress --routines --no-data $MYSQL_DB  --result-file=dump_db_schema_only.sql
mysqldump -h $MYSQL_HOSTNAME_ORIGEN  -u $MYSQL_USERNAME_ORIGEN  -p$MYSQL_PASSWORD_ORIGEN --default-character-set=utf8 --protocol=tcp --single-transaction --compress --order-by-primary --no-create-info $MYSQL_DB  --result-file=dump_db_data_only.sql

sleep 60

#upload mysql dump
mysql -h $MYSQL_HOSTNAME_DESTINO  -u $MYSQL_USERNAME_DESTINO  -p$PASSWD_destino $MYSQL_DB  < dump_db_schema_only.sql
mysql -h $MYSQL_HOSTNAME_DESTINO  -u $MYSQL_USERNAME_DESTINO  -p$PASSWD_destino $MYSQL_DB  < dump_db_data_only.sql

sleep 10
echo "backup mysql ok"

