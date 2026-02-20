output$volcano_plot <- renderPlot({
  req(analysis$ready)
  
  volcano_df <- make_volcano_df(
    genes_df     = df$genes_df,
    logfc_thresh = input$logfc_thresh,
    pval_thresh  = input$pval_thresh
  )
  
  make_volcano_plot(volcano_df)
})