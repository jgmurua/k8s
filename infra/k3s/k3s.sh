#!/bin/bash

sudo /usr/local/bin/k3s-uninstall.sh
ip=$(curl http://checkip.amazonaws.com)
curl -sfL https://get.k3s.io | sh -s - server --tls-san $ip
sudo k3s kubectl get node
sudo sed "s/127.0.0.1/$ip/g" /etc/rancher/k3s/k3s.yaml
