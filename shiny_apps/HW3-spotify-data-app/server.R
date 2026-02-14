# load necessary packages
# and source your functions.R file

library(shiny)
library(tidyverse)

source('functions.R')

# this function defines your server logic
server <- function(input, output){
  # you will put your interactions here
  
  # Load the spotify data
  spotify_data <- read.csv("data/spotify.csv")
  
  # reactiveValue for filtered data
  df <- reactiveValues(data = spotify_data)
  
  # Filter data based on minimum streams
  observeEvent(input$min_streams, {
    df$data <- spotify_data %>%
      filter(streams_mill >= input$min_streams)
  })
  
  # Render the scatter plot
  output$scatterplot <- renderPlot({
    # Call our create_plot function
    # Pass the filtered data, color toggle, and x-variable choice
    create_plot(df$data, input$show_color, input$x_var, spotify_data, input$min_streams)
  })
  
}
