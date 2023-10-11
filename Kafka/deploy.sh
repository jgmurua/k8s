#!/bin/bash

helm repo add strimzi https://strimzi.io/charts/
helm repo update

kubectl create ns kafka

# write with cat > my-kafka-values.yaml
cat <<EOF > values.yaml
kafka:
  replicas: 3
EOF

helm upgrade kafka strimzi/strimzi-kafka-operator -i -n kafka -f values.yaml

# Kafka cluster
kubectl apply -f https://strimzi.io/examples/latest/kafka/kafka-persistent-single.yaml -n kafka 

sleep 60

# Send and receive messages With the cluster running, run a simple producer to send messages to a Kafka topic (the topic is automatically created):
kubectl -n kafka run kafka-producer -ti --image=quay.io/strimzi/kafka:0.37.0-kafka-3.5.1 --rm=true --restart=Never -- bin/kafka-console-producer.sh --bootstrap-server my-cluster-kafka-bootstrap:9092 --topic my-topic

# And to receive them in a different terminal, run:
kubectl -n kafka run kafka-consumer -ti --image=quay.io/strimzi/kafka:0.37.0-kafka-3.5.1 --rm=true --restart=Never -- bin/kafka-console-consumer.sh --bootstrap-server my-cluster-kafka-bootstrap:9092 --topic my-topic --from-beginning

