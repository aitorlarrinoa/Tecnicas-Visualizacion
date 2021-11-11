library(shiny)
library(ggplot2)
library(mvtnorm)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Plot reactivo"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId="tam",
                        label="Tamaño de la muestra",
                        min=2,
                        max=500,
                        value=30),
            sliderInput(inputId="cor",
                        label="Correlación",
                        min=-1,
                        max=1,
                        value=0,
                        # de cuantos saltos permito el incremento
                        step=0.05),
            actionButton("generate", label="Generar"),
            actionButton("add", label="Añadir un punto")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput(outputId="dist",
                      #para recoger clicks utilizamos lo siguiente:
                      click="addclick"#addclick es el nombre que le quiero dar
                      # hover=... se dispara cuando pasas el ratón por encima.
                      )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    # reactiveVal, me va a permitir modificar posteriormente el valor que tiene.
    #reactiveVal es cuando solo usamos uno y reactiveValues es para cuando usamos varios.
    # cajón donde puedo guardar las cosas que quiera.
    miscosicas <- reactiveValues()
    
    observeEvent(input$generate, {
        sigma <- matrix(c(1, input$cor, input$cor, 1), nrow=2)
        miscosicas$df <- data.frame(rmvnorm(input$tam, sigma=sigma, method="chol"))
    })
    
    # Este segundo observador va a añadir un nuevo dato al data frame. 
    observeEvent(input$add, {
        #rbind concatena data frames por filas
        miscosicas$df <- rbind(miscosicas$df, runif(2, min=-2, max=2))
    })
    # tenmos dos observadores que modifican el mismo data frame, esto solo es posible con 
    # reactiveValues()
    
    observeEvent(input$addclick, {
        #rbind concatena data frames por filas
        miscosicas$df <- rbind(miscosicas$df, c(input$addclick$x, input$addclick$y))
    })
    
    #df <- reactive({
        # Aquí calculamos una distribución bivariada
    #    sigma <- matrix(c(1, input$cor, input$cor, 1), nrow=2)
    #    data.frame(rmvnorm(input$tam, sigma=sigma, method="chol"))
    #})

    output$dist <- renderPlot({
        req(miscosicas$df)
        ggplot(miscosicas$df) +
            geom_point(aes(x=X1, y=X2))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
