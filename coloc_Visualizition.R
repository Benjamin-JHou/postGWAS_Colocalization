install.packages("ggplot2")
library(ggplot2)

# Import Data:
data <- read.csv("your_data_file.csv")

# Mark specific SNPs:
highlight_positions <- data[data$snp %in% c("rs3864814", "rs2081208"), ]$position
range_width <- max(data$position) - min(data$position)
center_position <- mean(highlight_positions)
xlims <- c(center_position - range_width/2, center_position + range_width/2)

# Create scatter plots:
ggplot(data, aes(x = position)) +
  geom_point(aes(y = -log10(gwasp), color = "GWAS")) +
  geom_point(aes(y = -log10(eqtlp), color = "eQTL")) +
  geom_vline(aes(xintercept = highlight_positions), linetype = "dashed") +
  scale_color_manual(values = c("GWAS" = "blue", "eQTL" = "blue")) +
  coord_cartesian(xlim = xlims) +
  labs(title = "Colocalization of rs3864814, rs2081208 with STOX1, RP11-744D4.2",
       y = "-log10(p-value)",
       color = "Dataset") +
  theme_minimal()



