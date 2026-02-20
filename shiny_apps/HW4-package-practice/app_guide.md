# Quick Reference

This Shiny app allows the user to upload a genes dataset and a samples dataset and explore differential expression results via a volcano plot and a summary table.

[Shiny Gallery for Quick Reference](https://shiny.posit.co/r/gallery/)

### Layout description
This app uses `bslib` for layout and contains two tabs:

* **Tab 1 (Volcano Plot):** User adjusts logFC and adjusted p-value thresholds via sliders; the volcano plot updates to color-code significant genes accordingly.
* **Tab 2 (Top Genes Table):** User selects the number of top genes (by p-value) to display in a formatted `gt` table.

### Inputs
The bullets below take the general form:

> tab | shiny Component  |  **variable_name** | optional: args

* APP | fileInput | **genes_data** | none
* APP | fileInput | **samples_data** | none
* TAB1 | sliderInput | **logfc_thresh** | min = 0, max = 3, value = 0.58, step = 0.01
* TAB1 | sliderInput | **pval_thresh**  | min = 0.001, max = 0.1, value = 0.05, step = 0.001
* TAB2 | numericInput | **num_genes_t2** | value = 10, min = 1, max = 50

### Outputs
The bullets below take the general form:

> tab | Shiny Component  |  **variable_name**  | (inputs required)  | optional: function used

* TAB1 | plotOutput          | **volcano_plot**  | ggplot2
* TAB2 | gt::gt_output       | **top_genes_gt**  | gt::gt()

### Reactive components and Server

> component type | **variable_name(s)** | Events that trigger | data type

* APP | reactiveValues() | **df$genes_df**   | input$genes_data   | dataframe
* APP | reactiveValues() | **df$samples_df** | input$samples_data | dataframe
* APP | reactiveValues() | **analysis$ready**| both file inputs


### Functions and Set up

> **function_name**  |  (inputs)  | purpose

* **make_volcano_df**   | (genes_df, logfc_thresh, pval_thresh) | adds a significance category column for plotting
* **make_volcano_plot** | (volcano_df)                          | builds the ggplot2 volcano plot
* **make_gt_table**     | (genes_df, num_genes)                 | returns a formatted gt table of top n genes
