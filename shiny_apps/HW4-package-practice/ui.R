library(shiny)
library(bslib)
library(gt)

ui <- fluidPage(
  title = "Differential Expression Explorer",
  theme = bs_theme(bootswatch = "flatly"),
  
  nav_panel(
    "Upload Data",
    card(
      card_header("Upload Your Data Files"),
      card_body(
        p("Please upload both tab-separated data files to begin exploring."),
        fileInput("genes_data",   "Genes data file (limma-voom results):"),
        fileInput("samples_data", "Samples data file (normalised counts):")
      )
    )
  ),
  
  nav_panel(
    "Tab 1: Volcano Plot",
    source("tab_ui_files/tab1_ui.R", local = TRUE)$value
  ),
  
  nav_panel(
    "Tab 2: Top Genes Table",
    source("tab_ui_files/tab2_ui.R", local = TRUE)$value
  )
)
