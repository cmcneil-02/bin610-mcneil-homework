library(tidyverse)
library(gt)

# Adds a 'significance' category column used to color the volcano plot
make_volcano_df <- function(genes_df, logfc_thresh, pval_thresh) {
  genes_df %>%
    mutate(
      significance = case_when(
        adj.P.Val < pval_thresh & logFC >  logfc_thresh ~ "Up",
        adj.P.Val < pval_thresh & logFC < -logfc_thresh ~ "Down",
        TRUE                                            ~ "NS"
      )
    )
}

# Builds the volcano plot from the annotated dataframe
make_volcano_plot <- function(volcano_df) {
  ggplot(
    data = volcano_df,
    aes(x = logFC, y = -log10(adj.P.Val), color = significance)
  ) +
    geom_point(alpha = 0.5, size = 1.2) +
    scale_color_manual(
      values = c("Up" = "firebrick", "Down" = "steelblue", "NS" = "grey60")
    ) +
    labs(
      x     = "log2 Fold Change",
      y     = "-log10(Adjusted P-Value)",
      color = "Significance"
    ) +
    theme_bw() +
    theme(
      legend.position = "top",
      legend.title    = element_text(face = "bold")
    )
}


# Builds a formatted gt table for the top n genes by p-value
make_gt_table <- function(genes_df, num_genes) {
  genes_df %>%
    filter(adj.P.Val < 0.05, abs(logFC) > 0.58) %>%
    arrange(P.Value) %>%
    slice(1:num_genes) %>%
    select(SYMBOL, GENENAME, logFC, AveExpr, P.Value, adj.P.Val) %>%
    gt() %>%
    tab_header(
      title    = "Top Differentially Expressed Genes",
      subtitle = paste("Showing top", num_genes, "genes by p-value")
    ) %>%
    fmt_scientific(columns = c(P.Value, adj.P.Val), decimals = 2) %>%
    fmt_number(columns = c(logFC, AveExpr), decimals = 3) %>%
    data_color(
      columns = logFC,
      method  = "numeric",
      palette = c("steelblue", "white", "firebrick")
    ) %>%
    cols_label(
      SYMBOL    = "Gene",
      GENENAME  = "Gene Name",
      logFC     = "log2FC",
      AveExpr   = "Avg. Expr.",
      P.Value   = "P-Value",
      adj.P.Val = "Adj. P-Value"
    ) %>%
    tab_options(table.width = pct(100))
}