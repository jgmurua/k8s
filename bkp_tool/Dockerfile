# Utiliza una imagen base de Ubuntu
FROM ubuntu:22.04

# Actualiza los paquetes disponibles e instala MySQL Client
RUN apt-get update && apt-get install -y mysql-client && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copia el script al directorio /backup
COPY backup_script.sh /backup/backup_script.sh

# Establece el directorio de trabajo en /backup
WORKDIR /backup

# Permite que el script se ejecute como un archivo ejecutable
RUN chmod +x backup_script.sh

# Comando predeterminado al ejecutar el contenedor
CMD ["./backup_script.sh"]
