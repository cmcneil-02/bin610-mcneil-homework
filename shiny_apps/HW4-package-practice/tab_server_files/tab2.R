output$top_genes_gt <- gt::render_gt({
  req(analysis$ready)
  
  make_gt_table(
    genes_df  = df$genes_df,
    num_genes = input$num_genes_t2
  )
})