#!/bin/bash
# subea raiz de proyecto
cd ..

#nombre del proyecto
PRJ_NAME="hola-symfony"

# Chequear requerimientos Symfony
#symfony check:requirements

# Crear un nuevo proyecto Symfony
#symfony new $PRJ_NAME --version="7.0.*" --webapp

# Construir la imagen Docker
docker build -t symfony -f ./docker/php/Dockerfile_base --build-arg PROJECT_NAME=$PRJ_NAME .


# Ejecutar el contenedor Docker
docker run -p 8080:8000 symfony 