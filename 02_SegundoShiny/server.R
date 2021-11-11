library(shiny)
library(ggplot2)

# cuidado con las variables input$ejex. La palabra porgramáticamente, importante.
# aes_string() acepta cadenas de texto como variables

shinyServer(
  function(input, output){
    output$subtitulo <- renderText({
      paste0("Este es un gráfico entre la variable ", input$ejex," y la variable ", input$ejey)
      })
    
    output$regresion <- renderPlot({
      base <- ggplot(data = mpg, aes_string(x=input$ejex, y=input$ejey)) +
        geom_point()
      if (input$facet) {
        base +
        facet_wrap(~manufacturer)
      }
      else {
        base
      }
    })
  }
)