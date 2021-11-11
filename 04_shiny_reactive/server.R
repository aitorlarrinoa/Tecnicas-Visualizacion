library(shiny)

shinyServer(
  function(input, output) {
    
    # creamos un observador, que lo único que va a hacer es observar
    # cada vez que le doy al botón calcular, se me ejecuta por consola "HOLA"
    
    # puedo usar también observeEvent
    # esto es útil para si por ejemplo quiero que pase algo cuando yo puslse
    # el botón.
    observeEvent(input$mostrar, {
      # showNotification nos muestra un mensaje en pantalla cada vez que pulsamos el botón
      showNotification("Has calculado una nueva distribución")
    })
    # si yo tengo más de un observador, puedo usar la variable priority para definir qué observador
    # va primero. Más alta prioridad antes se ejecuta.
    
    
    # reactive me va a permitir compartir código para diferentes outputs
    # Las llaves lo que van a hacer es devolver la última línea, luego, 
    # fuera, le llamo x para asignarlo al rnorm
    # lo que está dentro de unas llaves se queda dentro, no puede salir fuera.
  
    # si hacemos eventreactive (solo reactivamos lo que se ponga al principio),
    # se le quita el isolate y el input$mostrar
    # además, deberemos colocar el input$mostrar como input a la función
    # eventReactive()
    x <- eventReactive(input$mostrar, {
      #input$mostrar
      #isolate(rnorm(input$tam, mean=input$media, sd = input$sdv))
      rnorm(input$tam, mean=input$media, sd = input$sdv)
    })
    # x se convierte en una función
    output$Histogram <- renderPlot({
      
      hist(x())
  })
    # renderPrint() sirve como renderText. Es un tipo de renderText que devuelve de 
    # forma directa el resultado que aparece en consola.
    output$summary <- renderPrint({
      
      summary(x())
      
    })
    
})