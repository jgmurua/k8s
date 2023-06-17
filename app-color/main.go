package main

import (
	"html/template"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()

	// Ruta para la página principal
	router.GET("/", func(c *gin.Context) {
		// Obtener el color de fondo de la variable de entorno
		color := os.Getenv("BACKGROUND_COLOR")

		// Renderizar el template con el color
		renderTemplate(c, color)
	})

	router.Run(":80")
}

// Función para renderizar el template con el color
func renderTemplate(c *gin.Context, color string) {
	// Definir el contenido del template
	htmlTemplate := `
		<!DOCTYPE html>
		<html>
			<head>
				<title>Web App con Color Personalizado</title>
			</head>
			<body style="background-color: {{ .Color }};">
				<h1>Página con color personalizado</h1>
			</body>
		</html>
	`

	// Crear el template
	tmpl := template.Must(template.New("index.html").Parse(htmlTemplate))

	// Datos para el template
	data := struct {
		Color string
	}{
		Color: color,
	}

	// Renderizar el template con los datos
	err := tmpl.Execute(c.Writer, data)
	if err != nil {
		c.String(http.StatusInternalServerError, "Error al renderizar el template")
		return
	}
}
