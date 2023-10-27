#!/bin/bash


# crea secreto con las credenciales de la base de datos asi se cargan en las variables de entorno
kubectl create secret generic mysql-backup-secret && \
   --from-literal=MYSQL_DB=your_db_name && \
   --from-literal=MYSQL_HOSTNAME_ORIGEN=your_origin_db_hostname && \
   --from-literal=MYSQL_USERNAME_ORIGEN=your_origin_db_username && \
   --from-literal=MYSQL_PASSWORD_ORIGEN=your_origin_db_password && \
   --from-literal=MYSQL_HOSTNAME_DESTINO=your_destiny_db_hostname && \
   --from-literal=MYSQL_USERNAME_DESTINO=your_destiny_db_username && \
   --from-literal=MYSQL_PASSWORD_DESTINO=your_destiny_db_password

# crea el job
kubectl create -f backup_job.yaml
