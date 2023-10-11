# Usa la imagen oficial de Python como base
FROM python:3.8

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Instala las dependencias, incluyendo confluent_kafka
RUN pip install --no-cache-dir confluent-kafka
# Copia el script Python al contenedor
COPY consumer.py .

# Comando para ejecutar el script Python
CMD ["python", "consumer.py"]
