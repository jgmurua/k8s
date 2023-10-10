FROM ubuntu:22.04

# Argumentos para MySQL/MariaDB
ARG MYSQL_ROOT_PASSWORD=rootpassword
ARG MYSQL_DATABASE=opencats
ARG MYSQL_USER=opencats
ARG MYSQL_PASSWORD=databasepassword
ENV DEBIAN_FRONTEND=noninteractive

# Definir volúmenes para la base de datos y las configuraciones de OpenCATS
VOLUME /var/lib/mysql
VOLUME /var/www/html/opencats/config


ARG OpenCATSUrl="https://github.com/opencats/OpenCATS/releases/download/v0.9.7.2/OpenCATS-v0.9.7.2-FULL.zip"

# Actualizar e instalar dependencias
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y mariadb-server mariadb-client apache2 wget unzip \
    software-properties-common

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf


# Preconfigurar tzdata
RUN echo "tzdata tzdata/Areas select America" > /tmp/preseed.txt && \
    echo "tzdata tzdata/Zones/America select Argentina/Buenos_Aires" >> /tmp/preseed.txt && \
    debconf-set-selections /tmp/preseed.txt && \
    rm /tmp/preseed.txt

# Instalar tzdata y otros paquetes
RUN apt-get update && \
    apt-get install -y tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Añadir PPA para PHP 7.2 e instalarlo
RUN add-apt-repository ppa:ondrej/php -y && \
    apt-get update && \
    apt-get install -y php7.2 php7.2-soap php7.2-ldap php7.2-mysqli \
    php7.2-gd php7.2-xml php7.2-curl php7.2-mbstring php7.2-zip

# Descargar e instalar OpenCATS
WORKDIR /var/www/html
RUN wget -O opencats.zip $OpenCATSUrl && \
    unzip opencats.zip && \
    rm opencats.zip && \
    mv OpenCATS* opencats && \
    chown -R www-data:www-data opencats && \
    chmod -R 770 opencats

# Configurar permisos de directorio
RUN chown www-data:www-data opencats && \
    chown -R www-data:www-data opencats && \
    chmod 770 opencats/attachments && \
    chmod 770 opencats/upload

RUN sed -i 's|/var/www/html|/var/www/html/opencats|' /etc/apache2/sites-available/000-default.conf

# Exponer Apache
EXPOSE 80


# Script de inicio
COPY start.sh /start.sh
RUN chmod +x /start.sh


CMD ["/start.sh"]
