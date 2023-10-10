#!/bin/bash
MYSQL_ROOT_PASSWORD=root
MYSQL_DATABASE=opencats
MYSQL_USER=opencats
MYSQL_PASSWORD=opencats

# Iniciar MySQL en el fondo
mysqld_safe &

# Esperar a que MySQL esté listo
until mysqladmin ping >/dev/null 2>&1; do
    echo -n "."; sleep 0.5
done

# Configuración de MariaDB y base de datos
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;" && \
mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';" && \
mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'localhost';" && \
mysql -e "FLUSH PRIVILEGES;"

# Iniciar Apache en primer plano
/usr/sbin/apache2ctl -D FOREGROUND
