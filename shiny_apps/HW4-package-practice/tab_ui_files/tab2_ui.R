page_sidebar(
  sidebar = sidebar(
    width = 280,
    numericInput(
      inputId = "num_genes_t2",
      label   = "Number of top genes to display:",
      value   = 10,
      min     = 1,
      max     = 50
    )
  ),
  card(
    card_header("Top Differentially Expressed Genes"),
    card_body(gt::gt_output("top_genes_gt")),
    full_screen = TRUE
  )
)