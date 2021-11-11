library(shiny)
library(ggplot2)

# Creamos una lista de variables. Estas serán las posteriores opciones que tendremos 
# en el primero de los selectInput
variables <- list(
  "manufacturer",
  "trans",
  "class")


shinyUI(
  fluidPage(
    # Ponemos título al shiny
    titlePanel("Shiny con reactividad avanzada. Aitor Larrinoa"),
    sidebarLayout(
      sidebarPanel(
        # selectInput() es hijo de sidebarPanel. Este nos permitirá tener un desplegable
        # en el cual podremos elegir de entre las variables antes mencionadas.
        selectInput(inputId="var",
                    label="Elige variable",
                    choices=variables),
        # Creamos otro selectInput(), es decir, un hermano del anterior selectInput(). 
        # Este selectInput() nos permitirá elegir de entre las diferentes opciones que nos 
        # da la variable del anterior selecInput().
        # i.e. si en el primer selectInput() tenemos la variable manufacturer, en este segundo 
        # desplegable, nos deberán aparecer las opciones: audi, chevrolet, dodge, ford, honda,
        # hyundai, jeep, land rover, etc.
        
        # Inicialmente lo inicializaremos a unique(mpg["manufacturer"]) porque "manufacturer"
        # será la opción por defecto, pero después los valores deberán ir cambiando en función
        # del valor que tome el primer selectInput(). Para que esto ocurra y funcione adecuadamente,
        # haremos uso de una función nueva en el archivo server. La función será updateSelectInput().
        selectInput(inputId="values",
                    label="Elige un valor para eliminar",
                    choices=unique(mpg["manufacturer"])),
        # Creamos el botón que posteriormente nos servirá de borrado.
        actionButton("borrar", 
                     label="Borrar subconjunto")

      ),
      mainPanel(
        # Le ponemos un identificador al plotOutput
        plotOutput(outputId="scatter"),
        # Le ponemos un identificador al verbatimTextOutput. Este será necesario para mostrar el 
        # resumen del dataset que nos pide el ejercicio.
        verbatimTextOutput("summary")
      )
    )
  )
)