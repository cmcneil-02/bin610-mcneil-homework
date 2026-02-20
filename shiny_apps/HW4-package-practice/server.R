library(shiny)
library(tidyverse)
library(gt)
library(bslib)

source('functions.R')

server <- function(input, output, session){
  df <- reactiveValues(
    genes_df   = NULL,
    samples_df = NULL
  )
  
  analysis <- reactiveValues(ready = FALSE)
  
  observeEvent(input$genes_data, {
    df$genes_df <- read.csv((input$genes_data)$datapath, sep = "\t")
    if (!(is.null(df$genes_df) | is.null(df$samples_df))) {
      analysis$ready <- TRUE
    }
  })
  
  observeEvent(input$samples_data, {
    df$samples_df <- read.csv((input$samples_data)$datapath, sep = "\t")
    if (!(is.null(df$genes_df) | is.null(df$samples_df))) {
      analysis$ready <- TRUE
    }
  })
  
  # Tab 1
  source("tab_server_files/tab1.R", local = TRUE)$value
  
  # Tab 2
  source("tab_server_files/tab2.R", local = TRUE)$value
  
  
}
