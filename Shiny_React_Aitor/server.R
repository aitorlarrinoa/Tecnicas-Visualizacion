library(shiny)
library(ggplot2)
library(dplyr)

shinyServer(
  function(input, output){
    # Dado que tenemos que realizar un gráfico, hacemos uso de renderPlot().
    output$scatter <- renderPlot({
    # asignamos n a input$tam y tipo a input$tipo_cut
    n <- input$tam 
    tipo <- input$tipo_cut
    # Utilizamos dplyr para filtrar por tipo de calidad del diamante.
    # Después tomamos un subconjunto del data frame diamonds de tamaño n.
    # Al data frame resultante lo llamamos "x"
    x <- diamonds %>% 
        filter(cut==tipo) %>% 
        sample_n(size=n)
    # Finalmente hacemos el gráfico de puntos del data frame x donde el eje x será el
    # precio del diamante y el eje y será el peso.
    ggplot(x, aes(x=price, y=carat)) +
      # Además, le añadiremos color en función del color del diamante
      geom_point(aes(color=color))
    })
  }
)

