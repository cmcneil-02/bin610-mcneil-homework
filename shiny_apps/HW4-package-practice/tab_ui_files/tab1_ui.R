page_sidebar(
  sidebar = sidebar(
    width = 280,
    sliderInput(
      inputId = "logfc_thresh",
      label   = "log2 Fold Change Threshold",
      min     = 0,
      max     = 3,
      value   = 0.58,
      step    = 0.01
    ),
    sliderInput(
      inputId = "pval_thresh",
      label   = "Adjusted P-Value Threshold",
      min     = 0.001,
      max     = 0.1,
      value   = 0.05,
      step    = 0.001
    )
  ),
  card(
    card_header("Volcano Plot"),
    card_body(plotOutput("volcano_plot", height = "500px")),
    full_screen = TRUE
  )
)