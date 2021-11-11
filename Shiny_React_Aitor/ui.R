library(shiny)
library(ggplot2)

# Creamos una variable que nos servirá de utilidad luego
variables <- list("Fair",
                  "Good",
                  "Very Good",
                  "Premium",
                  "Ideal")

shinyUI(
  fluidPage(
    # titlePanel() nos permitirá ponerle título al shiny
    titlePanel("Explorador de diamantes"),
    sidebarLayout(
      sidebarPanel(
        # numericInput() es hijo de sidebarPanel. Este nos permitirá tener un lugar 
        # donde poder meter valores numéricos y así poder cambiar el tamaño de la muestra
        numericInput(inputId="tam",
                     label="Tamaño de la muestra",
                     value=100),
        # selectInput(), que será hermano de numericInput e hijo de sidebarPanel(), nos 
        # permitirá que se abra un desplegable para poder elegir entre las diferentes 
        # opciones de la variable "variables". 
        selectInput(inputId="tipo_cut",
                    label="Filtro de cut",
                    choices=variables)
      ),
      mainPanel(
        # Le ponemos un identificador al plotOutput
        plotOutput(outputId="scatter")
      )
    )
  )
)

