library(dplyr)
library(circlize)
library(ComplexHeatmap)


data <- read.csv(file = "/Users/adam/Desktop/glioblastoma-DSP/b7h3-cbtn.csv")


rownames(data) <- data[,1]
data <- data[, colnames(data) != "idx"]
data <- t(data)
data <- as.data.frame(data)
data <- filter(data, Diagnosis %in% c("Low-grade glioma/astrocytoma", "High-grade glioma/astrocytoma"))
data <- arrange(data, desc(Grade == "Unavailable"), Grade)
data[, 4] <- as.numeric(data[, 4]); data[, 5] <- as.numeric(data[, 5])

colors <- structure(c("#E41A1C", "#FF7F00", "#FFFF33", "#4DAF4A", "#377EB8", "#984EA3", "#A65628"), names = unique(data$Grade))
grade_hm <- Heatmap(t(data[, 2]), name = "Grade", col = colors)
colors <- structure(c("#56A5EC", "#0C090A"), names = unique(data$`Survival status`))
survival_hm <- Heatmap(t(data[, 3]), name = "Survival status", col = colors)


rna_and_protein <- data[, 4:5]
rna_and_protein_hm <-
  Heatmap(rna_and_protein %>% t(),
          name = "B7-H3 expression",
          col = colorRamp2(c(-4, 0, 4), c("#AAF0D1", "white", "#F70D1A")),
          show_row_dend = FALSE,
          show_row_names = TRUE,
          row_names_side = "left",
          row_names_rot = 90,
          row_names_centered = TRUE,
          show_column_dend = FALSE,
          show_column_names = FALSE
          )
figure <- grade_hm %v% survival_hm %v% rna_and_protein_hm

# Plot heat map
figure

