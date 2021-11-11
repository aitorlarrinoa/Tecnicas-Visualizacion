library(shiny)

variables <- list("Gaussiana" = "norm", "Uniforme" = "unif", "Poisson" = "pois", "Gamma" = "gamma")

ui <- fluidPage(
  titlePanel("Shiny con Isolate"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId="tam_muestra",
                  label="Tamaño muestral",
                  min=5,
                  max=500,
                  value=42
      ),
      selectInput(inputId="distrib",
                  label="Distribución",
                  choices=variables,
                  selected = "norm"
      ),
      actionButton("mostrar", label="Mostrar la distribución")
    ),
    mainPanel(
      plotOutput(
        outputId="hist" 
      )
    )
  )
)

# cuando yo pulse el botón, quiero que se recargue el plot. Sino no.


server <- function(input, output){
  output$hist = renderPlot({
    # de esta forma, si pulso el botón cambia la distribución
    input$mostrar
    # aislamos ahora el input$tam_muestra, para que no se cambie. Sólamente se cambiará cuando le de al
    # botón
    
    rdistribucion <- switch(isolate(input$distrib),
                            "norm"=rnorm,
                            "unif"=runif,
                            "pois"=rpois,
                            "gamma"=rgamma)
    
    if (rdistribucion == rnorm | rdistribucion == runif) {
      x <- rdistribucion(isolate(input$tam_muestra))
    }
    else if (rdistribucion == rpois) {
      x <- rdistribucion(isolate(input$tam_muestra), lambda=4)
    }
    else {
      x <- rdistribucion(isolate(input$tam_muestra), shape=4)
    }
    
    hist(x)
  })
}

# Usamos shinyApp porque estamos usando ui y server en el mismo archivo
shinyApp(ui, server)