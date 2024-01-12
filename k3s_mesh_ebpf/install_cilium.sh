#!/bin/bash
# configura kubectl para que utilice el archivo de configuración de k3s 
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# si existe /etc/rancher/k3s/k3s.yaml, entonces se asume que k3s está instalado y se procede a instalar Cilium
# de lo contrario se espera 1 minuto a que k3s termine de instalarse y luego se evaluá si k3s está instalado

while [ ! -f /etc/rancher/k3s/k3s.yaml ]
do
  echo "Esperando a que k3s termine de instalarse..."
  sleep 60
done

# Comando para agregar el repositorio de Cilium
sudo helm repo add cilium https://helm.cilium.io

# Comando para instalar el paquete Cilium
sudo helm upgrade  -i cilium cilium/cilium --version 1.14.5 \
  --reuse-values \
  --set hubble.relay.enabled=true \
  --set hubble.ui.enabled=true \
  --kubeconfig /etc/rancher/k3s/k3s.yaml \
  --namespace kube-system

sleep 60


# Comando para eliminar las líneas del ConfigMap cilium-config
kubectl -n kube-system get configmap cilium-config -o yaml | \
sed '/ipam: "cluster-pool"/d' | \
sed '/cluster-pool-ipv4-cidr: "10.0.0.0\/8"/d' | \
sed '/cluster-pool-ipv4-mask-size: "24"/d' | \
kubectl apply -f -

sleep 15

# Comando para cambiar el tipo de servicio del Hubble UI a NodePort
kubectl -n kube-system patch service hubble-ui -p '{"spec": {"type": "NodePort"}}'

# Obtener la dirección IP del nodo maestro
MASTER_IP=$(kubectl -n kube-system get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}' | awk '{print $1}')

# Obtener el puerto asignado al servicio Hubble UI
NODE_PORT=$(kubectl -n kube-system get service hubble-ui -o jsonpath='{.spec.ports[0].nodePort}')

# Imprimir la URL del Hubble UI
echo "URL del Hubble UI: http://$MASTER_IP:$NODE_PORT"

