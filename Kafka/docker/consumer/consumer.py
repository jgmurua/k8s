from confluent_kafka import Consumer, KafkaError

# Configura el consumidor
consumer = Consumer({
    'bootstrap.servers': 'kafka:9092',
    'group.id': 'mi-grupo',
    'auto.offset.reset': 'earliest'
})

# Suscríbete al tema desde el que quieres recibir mensajes
topic = 'mi-tema'
consumer.subscribe([topic])

# Lee y muestra mensajes
while True:
    msg = consumer.poll(1.0)

    if msg is None:
        continue
    if msg.error():
        if msg.error().code() == KafkaError._PARTITION_EOF:
            print('Llegó al final de la partición')
        else:
            print('Error en el consumidor: {}'.format(msg.error()))
    else:
        print('Mensaje recibido: {}'.format(msg.value()))

# Cierra el consumidor
consumer.close()
