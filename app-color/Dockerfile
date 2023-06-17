# Imagen base
FROM golang:1.20 AS build-stage

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el código fuente al contenedor
COPY *.go ./

# Obtener la dirección IP local y convertirla en un código de color
RUN export BACKGROUND_COLOR=$(hostname -I | awk '{print $1}' | md5sum | awk '{print "#"substr($1, 0, 6)}')

# Download Go modules
COPY go.mod go.sum ./
RUN go mod download

# Establecer la variable de entorno
ENV BACKGROUND_COLOR=$BACKGROUND_COLOR

# Compilar la aplicación usando el módulo vendido
RUN CGO_ENABLED=0 GOOS=linux go build -o main

# Puerto expuesto por la aplicación
EXPOSE 80

# Comando para ejecutar la aplicación
CMD ["./main"]
