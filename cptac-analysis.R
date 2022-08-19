# histology <- read.csv(file = "/Users/adam/Desktop/glioblastoma-DSP/pbta-histologies.tsv", sep = "\t")
# rna <- readRDS("/Users/adam/Desktop/glioblastoma-DSP/pbta-gene-expression-rsem-tpm.stranded.rds")

data <- read.csv(file = "/Users/adam/Desktop/glioblastoma-DSP/b7h3-cbtn.csv")
rownames(data) <- data[,1]
data <- data[, colnames(data) != "idx"]
data <- t(data)
data <- as.data.frame(data)
data <- arrange(data, desc(Grade == "Unavailable"), Grade)
data[, 4] <- as.numeric(data[, 4]); data[, 5] <- as.numeric(data[, 5])
rna_and_protein <- data[, 4:5]
grade_hm <- Heatmap(t(data[, 2]), name = "Grade")
rna_and_protein_hm <-
  Heatmap(rnaprotein %>% t(),
          name = "B7-H3",
          show_row_dend = FALSE,
          show_column_dend = FALSE,
          show_column_names = FALSE
          )
figure <- grade_hm %v% rna_and_protein_hm
figure