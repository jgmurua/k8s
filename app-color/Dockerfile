# Stage de construcción
FROM golang:1.20 AS build-stage

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar los archivos de código fuente al contenedor
COPY *.go ./

# Descargar los módulos de Go
COPY go.mod go.sum ./
RUN go mod download

# Establecer la variable de entorno
ENV BACKGROUND_COLOR='#64FE2E'

# Compilar la aplicación
RUN CGO_ENABLED=0 GOOS=linux go build -o main

# Stage de producción
FROM alpine:latest AS production-stage

# Copiar el archivo binario de la etapa de construcción
COPY --from=build-stage /app/main /
ENV GIN_MODE=release
ENV BACKGROUND_COLOR='#64FE2E'
# Puerto expuesto por la aplicación
EXPOSE 80

# Comando para ejecutar la aplicación
CMD ["/main"]
