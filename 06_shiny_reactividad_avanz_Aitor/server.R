library(shiny)
library(ggplot2)

shinyServer(
  function(input, output, session) {
    # creamos el objeto mi_df
    mi_df <- reactiveValues(df=mpg)
    
    # creamos un observador. 
    # Este observador cambiará el segundo selectInput del ui. Si cambiamos el selectInput 1
    # el selectInput 2 deberá cambiar sus valores. Esto se hará con updateSelectInput
    observeEvent(input$var, {
      x <- input$var
      
      updateSelectInput(session,
                        "values",
                        choices=unique(mpg[x]))
    })
    
    # Creamos otro observador que reaccionará al botón de borrado. Lo que haremos es modificar
    # el data frame. Iremos eliminando las filas  que tomen el valor input$values en la columna input$var. 
    observeEvent(input$borrar, {
      col <- input$var
      value <- input$values
      mi_df$df <- mi_df$df[!(mi_df$df[col]==value),]
    })
    
    # Finalmente realizamos el gráfico de nuestro data frame mediante el paquete ggplot.
    # Escribimos la variable displ en el eje x y la variable cty en la variable y.
    # También colorearemos el gráfico en función de la variable manufacturer.
    output$scatter <- renderPlot({
      req(mi_df$df)
      ggplot(mi_df$df, aes(x=displ,
                         y=cty)) +
        geom_point(aes(color=manufacturer))
    })

    # Mostramos por último el resumen del data frame mpg por pantalla.
    output$summary <- renderPrint({
      
      summary(mi_df$df)
      
    })
    
  })