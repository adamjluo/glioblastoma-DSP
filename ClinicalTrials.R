# Load packages
library(tidyverse)
library(gt)

# Read CSV file from github
clintrials_df <- read.csv("https://raw.githubusercontent.com/adamjluo/glioblastoma-DSP/main/B7-H3_GBM_Trials.csv")

# Remove periods from column names
colnames(clintrials_df) <- gsub("[.]", " ", colnames(clintrials_df))

# Generate table
gt_tbl <- gt(clintrials_df)

# Apply formatting to table
gt_tbl <-
  gt_tbl %>%
  tab_header(
    title = md("**CLINICAL TRIALS TARGETING B7-H3 IN GLIOBLASTOMA**"),
    subtitle = md("Note: None of these trials have an *\"active\"* status")
  ) %>%
  tab_source_note(
    source_note = md("Source: *ClinicalTrials.gov* with keywords **glioblastoma** and **B7-H3**")
  ) %>%
  opt_align_table_header(
    align = "left"
  ) %>%
  cols_align(
    align = "left"
  ) %>%
  tab_options(
    table.font.names = "Optima",
    table.font.color = "#1e3048",
    table.border.top.style = "none",
    table.border.bottom.style = "solid",
    table.border.bottom.width = px(3),
    table.border.bottom.color = "#1e3048"
  ) %>%
  tab_style(
    style = list(
      cell_text(color = "#2f5375")
    ),
    locations = list(cells_column_labels(), cells_title(), cells_source_notes())
  ) %>%
  opt_all_caps(
    locations = "column_labels"
  )

# Display table in viewer
gt_tbl

