#!/bin/bash
# https://medium.com/@ebrar/single-node-k3s-installation-with-cilium-and-hubble-f4cbaacd9176

# Llamar al script para instalar herramientas eBPF
bash ebpf_tools_install.sh

# Llamar al script para instalar Helm y kubectl
bash install_helm_kubectl.sh

# Llamar al script para instalar k3s
bash install_k3s.sh

# Llamar al script para instalar Cilium
bash install_cilium.sh
