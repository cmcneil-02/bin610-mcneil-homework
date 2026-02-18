library(quarto)
library(stringr)

# Find all differential expression result files in the data/ directory
# pattern ensures we only match DE files, not the expression matrix files (_expr.csv)
de_files <- list.files("./data/", pattern = "_de\\.csv$")

# Store the count of files so we know how many reports to generate
n <- length(de_files)

# Create the output directory for reports
dir.create("reports", showWarnings = FALSE)

for (i in 1:n) {
  
  # Extract the region tag from the filename using a regex capture group
  # e.g., "AD_superior_frontal_gyrus_de.csv" -> "superior_frontal_gyrus"
  region_tag <- str_match(de_files[i], "AD_(.+)_de\\.csv")[1, 2]
  
  # Convert the region tag to a readable title for the report
  # Replaces underscores with spaces and title-cases each word
  # e.g., "superior_frontal_gyrus" -> "Superior Frontal Gyrus"
  brain_region <- str_replace_all(region_tag, "_", " ") %>%
    str_to_title()
  
  # Build the relative path to pass as the data_path parameter
  data_path <- paste0("data/", de_files[i])
  
  # Build the output filename and full output path
  report_name <- paste0("AD_", region_tag, "_report.html")
  output_name <- paste0("reports/", report_name)
  
  # Render report.qmd with this iteration's parameters
  # execute_params overrides the default params in the YAML
  quarto_render(
    "report.qmd",
    execute_params = list(
      data_path = data_path,
      brain_region = brain_region
    ),
    output_file = report_name
  )
  
  # quarto_render() writes the HTML to the project root by default;
  # move it into the reports/ subdirectory
  file.rename(
    from = report_name,
    to = output_name
  )
}
