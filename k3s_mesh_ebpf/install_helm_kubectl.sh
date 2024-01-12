#!/bin/bash

# Función para verificar si un comando está disponible
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Verificar si helm no está instalado
if ! command_exists helm; then
  echo "Helm no está instalado. Instalando..."
  # Descargar e instalar Helm
  curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
fi

# Verificar si kubectl no está instalado
if ! command_exists kubectl; then
  echo "kubectl no está instalado. Instalando..."
  # Descargar e instalar kubectl
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x kubectl
  sudo mv kubectl /usr/local/bin/
fi

echo "Helm y kubectl están instalados."
