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

      actionButton("mostrar", label="Mostrar la distribución"),
      # quiero cambiar cosas en base a la variable actionButton
      # hueco para una interfaz <- uiOutput
      uiOutput("parametros")
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
    
    n <- isolate(input$tam_muestra)
    distribucion <- isolate(input$distrib)
    
    if (distribucion == "norm") {
      # req comprueba si algo existe
      mean <- isolate(input$mean)
      req(mean)
      sd <- isolate(input$sd)
      req(sd)
      x <- rnorm(n, mean, sd)
    }
    else if (distribucion == "unif") {
      # req comprueba si algo existe
      min <- isolate(input$min)
      req(min)
      max <- isolate(input$max)
      req(max)
      x <- runif(n, min, max)
    }
    else if (distribucion == "pois") {
      # req comprueba si algo existe
      lambda <- isolate(input$lambda)
      req(lambda)
      x <- rpois(n, lambda)
    }
    else if (distribucion == "gamma") {
      # req comprueba si algo existe
      ratio <- isolate(input$ratio)
      req(ratio)
      shape <- isolate(input$shape)
      req(shape)
      x <- rgamma(n, ratio, shape)
    }
    
    
    hist(x)
  })
  
  # dentro del renderUI debemos crear una interfaz
  output$parametros <- renderUI({
    if (input$distrib=="norm") 
      # taglist es una lista de etiquetas. Sirve para poner hijos en renderUI
      tagList(
      numericInput("mean",
                   label="media",
                   value=5),
      numericInput("sd",
                  label="Desviación típica",
                  value=1)
      )
    
    else if (input$distrib == "unif") 
     tagList(
       numericInput("min",
                   label="valor mínimo",
                   value=1),
        numericInput("max",
                  label="valor máximo",
                  value=3)
     )
    else if (input$distrib == "pois") 
      tagList(
        numericInput("lambda",
                     label="valor de lambda",
                     value=2)
      )
    else if (input$distrib == "gamma") 
      tagList(
        numericInput("shape",
                     label="Shape distribución",
                     value=2),
        numericInput("ratio",
                     label="Ratio distribución",
                     value=1)
      )

  })
}

# las llaves son agrupadores de líneas y te devuelve siempre la última linea

# Usamos shinyApp porque estamos usando ui y server en el mismo archivo
shinyApp(ui, server)