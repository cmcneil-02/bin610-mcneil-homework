# Quick Reference

This Shiny App allows you to interactively explore song data from a Spotify dataset. You can choose an independent variable for the x-axis, filter songs by minimum stream count, and optionally color points by musical mode (Major/Minor).

[Shiny Gallery for Quick Reference](https://shiny.posit.co/r/gallery/)

### Layout description
* Title and description across the top
* Small column (left) with two control inputs:
  1. Drop-down menu to select x-axis variable
  2. Number input to set minimum streams threshold
* Large column (right) for the main scatter plot
* Checkbox below the plot to toggle coloring by mode

### Inputs
The bullets below take the general form:

> shiny Component  |  **variable_name** | optional: args

* selectInput | **x_var** | choices = bpm, danceability, energy, liveness, released_month
* numericInput | **min_streams** | value = 1000, min = 0, max = 4000, step = 100
* checkboxInput | **show_color** | value = TRUE

### Outputs
The bullets below take the general form:

> shiny Component  |  **variable_name**  | (inputs required)  | optional: function used

* plotOutput | **scatterplot** | (df$data, input$show_color, input$x_var, spotify_data, input$min_streams) | create_plot()

### Reactive components and Server

> component type | **variable_name(s)** | Events that trigger 

* reactiveValues | **df$data** | input$min_streams

### Functions and Set up

> **function_name**  |  (inputs)  | purpose

> **create_plot()** | (df, show_color, x_var, full_data, min_streams) | Creates a ggplot scatter plot with streams_mill on y-axis and selected variable on x-axis. Uses custom color scheme for mode (orange for Major, purple for Minor). Includes style points: shows all data with gray points below threshold and a horizontal dashed line at the minimum streams value.

> **get_nice_label()** | (var_name) | Converts variable names to formatted labels for plot axes (e.g., "bpm" becomes "Beats Per Minute")
