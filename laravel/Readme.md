# Laravel on Docker development environment
docker build -t laravel-develop -f Dockerfile_develop .

# en win imprime el directorio actual en ps1
$pwd = (Get-Location).Path

docker run -p 8080:8000 -v $pwd:/var/www/html -ti laravel-develop bash



# Inside the container
 
laravel new hola-mundo

cd hola-mundo

# test with php artisan serve
php artisan serve --host=0.0.0.0 --port=8000



# crea imagen de la aplicacion
docker build -t laravel-app . --build-arg PROJECT_NAME=hola-mundo --build-arg APP_ENV=production

# crea contenedor de la aplicacion
docker run -p 8080:8000 -e PROJECT_NAME=hola-mundo laravel-app






## lo mismo pero un poco menos practico

# create laravel-production final image
docker build -t laravel-production -f Dockerfile_production .

# copia el contenido de la carpeta hola-mundo en el directorio /var/www/html en el contenedor utilizando docker cp

PROJECT_NAME=hola-mundo

docker container create --name laravel-production -e APP_ENV=production -e PROJECT_NAME=$PROJECT_NAME -p 8080:8000 laravel-production
docker cp $PROJECT_NAME/. laravel-production:/var/www/html/$PROJECT_NAME
docker container start laravel-production 

# create image from container
docker container commit laravel-production laravel-production:latest
docker image tag laravel-production:latest jmurua/laravel-production:latest
docker push jmurua/laravel-production:latest

