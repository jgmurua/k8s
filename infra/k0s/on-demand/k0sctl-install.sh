#!/bin/bash

wget "https://github.com/k0sproject/k0sctl/releases/download/v0.13.0-rc.2/k0sctl-linux-x64" 
mv k0sctl-linux-x64 /usr/local/bin/k0sctl && chmod +x /usr/local/bin/k0sctl




terraform init
terraform apply --auto-approve
terraform output -raw k0s_cluster | k0sctl apply --config -
terraform output -raw k0s_cluster | k0sctl kubeconfig --config - > ddd
#ok
#echo $(terraform output -raw k0s_cluster | k0sctl kubeconfig --config - ) >> KUBECONFIGK0S

#terraform destroy --auto-approve


