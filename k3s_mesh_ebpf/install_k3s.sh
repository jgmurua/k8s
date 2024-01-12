#!/bin/bash

# Obtener la dirección IP del nodo maestro
export MASTER_IP=$(ip a | grep '192.168' | awk '{print $2}' | cut -f1 -d '/')

# Instalación de k3s
sudo curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-backend=none --no-flannel --node-ip=${MASTER_IP} --node-external-ip=${MASTER_IP} --bind-address=${MASTER_IP} --no-deploy servicelb --no-deploy traefik" sudo sh -

sleep 120