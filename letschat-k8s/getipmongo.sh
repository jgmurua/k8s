#!/bin/bash
# deploy mongodb
kubectl apply -f mongo-deployment.yaml -n letschat
# wait for mongodb to be ready
kubectl wait --for=condition=ready pod -l app=mongo -n letschat --timeout=120s
# expose mongodb
kubectl apply -f mongo-svc.yaml -n letschat

kubectl apply -f letschat-deployment.yaml -n letschat
kubectl apply -f letschat-svc.yaml -n letschat

# si falla el dns, ejecutar el siguiente comando

while [[ $(kubectl get deployment letschat -n letschat -o jsonpath="{.status.unavailableReplicas}") == 1 ]]; do
    echo "letschat deployment is not ready"
    IP_MONGO=$(kubectl get pod -n letschat | grep mongo | awk '{print $1}' | xargs kubectl describe pod -n letschat | grep IP: | awk '{print $2}' | head -n 1)
    kubectl set env deployment/letschat LCB_DATABASE_URI=mongodb://$IP_MONGO/letschat  -n letschat
    sleep 15
done

# set environment variable to avoid registration
kubectl set env deployment/letschat LCB_AUTH_LOCAL_ENABLE_REGISTRATION="false" -n letschat
