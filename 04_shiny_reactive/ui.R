library(shiny)

# Esto debería poder hacerse en 10 mins (ui + server)
shinyUI(
  fluidPage(
    sidebarLayout(
      sidebarPanel(
        sliderInput(inputId="tam",
                    label="Tamaño de la muestra",
                    max=500,
                    min=2,
                    value=30),
        numericInput(inputId="media",
                     label="Media de la muestra",
                     value=0),
        numericInput(inputId="sdv",
                     label="Desv. típica de la muestra",
                     value=1),
        actionButton("mostrar", 
                     label="Calcular")
      ),
      mainPanel(
        plotOutput(outputId="Histogram"),
        verbatimTextOutput("summary")
      )
    )
  )
)