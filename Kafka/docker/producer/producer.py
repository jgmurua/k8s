from confluent_kafka import Producer

# Configura el productor
producer = Producer({'bootstrap.servers': 'kafka:9092'})

# Define el tema al que enviarás el mensaje
topic = 'mi-tema'

# Envia el mensaje "Hola Mundo" al tema cada 5 segundos
for i in range(100):
    producer.produce(topic, 'Hola Mundo')
    producer.poll(0.5)

# Espera a que se envíe el mensaje
producer.flush()
print('Mensaje enviado con éxito: "Hola Mundo"')
