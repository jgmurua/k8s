## instalar k3d con chocolatey

```powershell
choco install k3d
```

## crear cluster

```powershell

# vars
$DOCKER_REGISTRY_OWNER=""
$DOCKER_REGISTRY_PASS=""
$DOCKER_REGISTRY_EMAIL=""

k3d cluster create --config k3d.yaml --timeout 300s
# obtener kubeconfig del cluster
k3d kubeconfig get --all > kubeconfig.yaml
# crear secret para dockerhub
kubectl create secret docker-registry dockerhub-secret --docker-server=https://index.docker.io/v1/  --docker-username=$DOCKER_REGISTRY_OWNER --docker-password=$DOCKER_REGISTRY_PASS --docker-email=$DOCKER_REGISTRY_EMAIL --kubeconfig kubeconfig.yaml
```

## ejemplo uso del secret para pull de imagenes

```yaml

apiVersion: batch/v1
kind: Job
metadata:
  name: mi-job
spec:
  template:
    spec:
      imagePullSecrets:
        - name: dockerhub-secret  # Nombre del secreto que creaste
      containers:
        - name: mi-contenedor
          image: jgmurua/hello:latest  # Tu imagen en DockerHub
      restartPolicy: Never

```

## eliminar cluster

```powershell
k3d cluster delete k3s-default
```
