# Function to create the scatter plot
create_plot <- function(df, show_color, x_var, full_data, min_streams) {
  
  # Get nice labels for axes
  x_label <- get_nice_label(x_var)
  y_label <- "Streams (millions)"
  
  # Create base plot with all data from full_data (for style points)
  # This keeps all points visible, but grays out those below threshold
  p <- ggplot() +
    # Add points below threshold in gray
    geom_point(data = full_data %>% filter(streams_mill < min_streams),
               aes(x = .data[[x_var]], y = streams_mill),
               color = "gray70",
               alpha = 0.6,
               size = 2) +
    # Add horizontal line at the minimum threshold
    geom_hline(yintercept = min_streams, 
               linetype = "dashed", 
               color = "gray50",
               alpha = 0.7)
  
  # Add points above threshold with conditional coloring
  if (show_color) {
    # Color by mode using custom color scheme
    p <- p +
      geom_point(data = df,
                 aes(x = .data[[x_var]], y = streams_mill, color = mode),
                 size = 2,
                 alpha = 0.8) +
      scale_color_manual(values = c("Major" = "orange2", "Minor" = "purple2"),
                         name = "Mode")
  } else {
    # Use black points when color is not checked
    p <- p +
      geom_point(data = df,
                 aes(x = .data[[x_var]], y = streams_mill),
                 color = "black",
                 size = 2,
                 alpha = 0.8)
  }
  
  # Add labels and theme
  p <- p +
    labs(x = x_label, y = y_label) +
    theme_minimal() +
    theme(
      plot.title = element_text(size = 14, face = "bold"),
      axis.title = element_text(size = 12),
      legend.position = "right"
    ) +
    # Set static axis limits based on full data
    ylim(0, max(full_data$streams_mill, na.rm = TRUE) * 1.05) +
    xlim(min(full_data[[x_var]], na.rm = TRUE) * 0.95,
         max(full_data[[x_var]], na.rm = TRUE) * 1.05)
  
  return(p)
}

# Helper function to convert variable names to nice labels
get_nice_label <- function(var_name) {
  labels <- list(
    "bpm" = "Beats Per Minute",
    "danceability" = "Danceability",
    "energy" = "Energy",
    "liveness" = "Liveness",
    "released_month" = "Released Month"
  )
  
  return(labels[[var_name]])
}