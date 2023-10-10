# opencats - OpenCATS is a free and open-source applicant tracking system.
## this is an intent to deploy opencats as a monolithic application on docker
### this is a work in progress

´´´bash
docker build -t opencats .
docker run -d \
  -v /ruta/en/tu/host/mysql:/var/lib/mysql \
  -v /ruta/en/tu/host/opencats/config:/var/www/html/opencats/config \
  -p 80:80 \
  opencats
´´´