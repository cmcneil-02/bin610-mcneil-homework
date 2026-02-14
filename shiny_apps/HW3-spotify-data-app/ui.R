# Build your UI page here

ui <- fluidPage(
  # App title and description
  h1("Visualizing Spotify Data"),
  p("In this Shiny App, we will interactively explore song data from a spotify data set. You will be able to choose an independent variable using a drop-down menu, remove songs under a certain minimum streams value, and use a checkbox to color the songs by mode."),
  
  br(),
  
  # Controls above the plot (side-by-side)
  fluidRow(
    # Left: Dropdown for x-axis variable
    column(6,
           selectInput("x_var",
                       "Choose your independent variable:",
                       choices = list("Beats-per-minute" = "bpm",
                                      "Danceability" = "danceability",
                                      "Energy" = "energy",
                                      "Liveness" = "liveness",
                                      "Released Month" = "released_month"))
    ),
    
    # Right: Number input for minimum streams filter
    column(6,
           numericInput("min_streams",
                        "Filter by this minimum number of streams:",
                        value = 1000,
                        min = 0,
                        max = 4000,
                        step = 100)
    )
  ),
  
  # Plot takes full width
  fluidRow(
    column(12,
           plotOutput("scatterplot", height = "600px")
    )
  ),
  
  # Checkbox below the plot
  fluidRow(
    column(12,
           checkboxInput("show_color",
                         "Check to color by mode",
                         value = TRUE)
    )
  )
)