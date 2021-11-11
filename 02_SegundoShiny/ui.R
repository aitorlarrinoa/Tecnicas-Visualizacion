library(shiny)
library(ggplot2)

variables <- list(
  "engine displacement, in litres"="displ",
  "number of cylinders"="cyl",
  "city miles per gallon"="cty",
  "highway miles per gallon"="hwy")

# documentación shiny en internet para los tipos de inputs
shinyUI(
  fluidPage(
    titlePanel("shiny 2: Regresión lineal con las variables de mpg"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId="ejex",
          label="Elección de la variable X",
          choices=variables
        ),
        selectInput(
          inputId="ejey",
          label="Elección de la variable Y",
          choices=variables
        ),
        checkboxInput("facet", label="Faceteo por fabricante")
      ),
      mainPanel(
        textOutput("subtitulo"),
        plotOutput(
          outputId="regresion"
        )
      )
    )
  )
)
