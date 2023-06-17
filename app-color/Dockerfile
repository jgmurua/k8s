# Imagen base
FROM golang:1.16-alpine

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el código fuente al contenedor
COPY . .

# Instalar la herramienta jq
RUN apk --no-cache add jq

# Obtener la dirección IP local y convertirla en un código de color
RUN export BACKGROUND_COLOR=$(hostname -I | awk '{print $1}' | md5sum | awk '{print "#"substr($1, 0, 6)}')

# Utilizar un módulo vendido (vendoring)
RUN go mod init app && go mod vendor

# Establecer la variable de entorno
ENV BACKGROUND_COLOR=$BACKGROUND_COLOR

# Compilar la aplicación usando el módulo vendido
RUN go build -mod=vendor -o main .

# Puerto expuesto por la aplicación
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["./main"]
