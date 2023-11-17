library(ggplot2)
library(gridExtra)
library(dplyr)

# Import Data
data <- read.csv("/～path/coloc_file.csv")

# Get the location of colocalized SNP
rs3864814_position <- data[data$snp == "rs3864814", ]$position

# Sort data based on distance to colocalized SNP position
data <- data %>%
  mutate(distance = abs(position - rs3864814_position)) %>%
  arrange(distance)

# Get the index of colocalized SNP
rs3864814_index <- which(data$snp == "rs3864814")

# Select the 300 SNPs closest to colocalized SNP (150 before and 150 after)
data_nearest_300 <- data[max(1, (rs3864814_index - 150)):(rs3864814_index + 150), ]

# Calculate the maximum -log10(p-value) of GWAS and eQTL data in these SNPs
max_gwasp <- max(-log10(data_nearest_300$gwasp), na.rm = TRUE)
max_eqtlp <- max(-log10(data_nearest_300$eqtlp), na.rm = TRUE)

# Define the color scheme for the plot
color_values <- c("rs3864814" = "plum", "Other" = "darkblue")

# Define color based on r2 value
data_nearest_300 <- data_nearest_300 %>%
  mutate(color = case_when(
    snp == "rs3864814" ~ "plum",
    r2 == 1 ~ "red",
    r2 >= 0.75 ~ "orange",
    r2 >= 0.50 ~ "green",
    r2 >= 0.25 ~ "lightblue",
    TRUE ~ "darkblue"
  ))

# Set uniform margins
uniform_margin <- margin(5.5, 20, 5.5, 20)

# Create a scatter plot for GWAS
gwas_plot <- ggplot(data_nearest_300, aes(x = position, y = -log10(gwasp), color = color)) +
  geom_point() +
  geom_vline(xintercept = rs3864814_position, linetype = "dashed", color = "red") +
  scale_color_identity(name = "r2 with rs3864814") +
  coord_cartesian(ylim = c(0, max_gwasp)) +
  labs(title = "GWAS: Colocalization with STOX1 near rs3864814", y = "-log10(p-value)") +
  theme_minimal() +
  theme(legend.position = "bottom", plot.margin = uniform_margin)

# Create a scatter plot for eQTL
eqtl_plot <- ggplot(data_nearest_300, aes(x = position, y = -log10(eqtlp), color = color)) +
  geom_point() +
  geom_vline(xintercept = rs3864814_position, linetype = "dashed", color = "red") +
  scale_color_identity(name = "r2 with rs3864814") +
  coord_cartesian(ylim = c(0, max_eqtlp)) +
  labs(title = "eQTL: Colocalization with STOX1 near rs3864814", y = "-log10(p-value)") +
  theme_minimal() +
  theme(legend.position = "bottom", plot.margin = uniform_margin)

# Create a plot for Posterior Probability (PP4)
pp4_plot <- ggplot(data_nearest_300, aes(x = position, y = ifelse(snp == "rs3864814", 1, 0), color = color)) +
  geom_point() +
  geom_vline(xintercept = rs3864814_position, linetype = "dashed", color = "red") +
  scale_color_identity(name = "r2 with rs3864814") +
  coord_cartesian() +
  labs(title = "Posterior Probability (PP4) near rs3864814", y = "Posterior Probability") +
  scale_y_continuous(breaks = c(0, 0.25, 0.50, 0.75, 1)) +
  theme_minimal() +
  theme(legend.position = "bottom", plot.margin = uniform_margin)

# Stack three images vertically into one
grid_arranged_plot <- grid.arrange(gwas_plot, eqtl_plot, pp4_plot, ncol = 1)

# Save graphic with adjusted size to show legend
ggsave("COLOC_plot.png", grid_arranged_plot, width = 20, height = 10)
library(ggplot2)
library(gridExtra)
library(dplyr)

# Import Data
data <- read.csv("/Users/zhoujunyu/Desktop/coloc_file.csv")

# Get the location of colocalized SNP
rs3864814_position <- data[data$snp == "rs3864814", ]$position

# Sort data based on distance to colocalized SNP position
data <- data %>%
  mutate(distance = abs(position - rs3864814_position)) %>%
  arrange(distance)

# Get the index of colocalized SNP
rs3864814_index <- which(data$snp == "rs3864814")

# Select the 300 SNPs closest to colocalized SNP (150 before and 150 after)
data_nearest_300 <- data[max(1, (rs3864814_index - 150)):(rs3864814_index + 150), ]

# Calculate the maximum -log10(p-value) of GWAS and eQTL data in these SNPs
max_gwasp <- max(-log10(data_nearest_300$gwasp), na.rm = TRUE)
max_eqtlp <- max(-log10(data_nearest_300$eqtlp), na.rm = TRUE)

# Define the color scheme for the plot
color_values <- c("rs3864814" = "plum", "Other" = "darkblue")

# Define color based on r2 value
data_nearest_300 <- data_nearest_300 %>%
  mutate(color = case_when(
    snp == "rs3864814" ~ "plum",
    r2 == 1 ~ "red",
    r2 >= 0.75 ~ "orange",
    r2 >= 0.50 ~ "green",
    r2 >= 0.25 ~ "lightblue",
    TRUE ~ "darkblue"
  ))

# Set uniform margins
uniform_margin <- margin(5.5, 20, 5.5, 20)

# Create a scatter plot for GWAS
gwas_plot <- ggplot(data_nearest_300, aes(x = position, y = -log10(gwasp), color = color)) +
  geom_point() +
  geom_vline(xintercept = rs3864814_position, linetype = "dashed", color = "red") +
  scale_color_identity(name = "r2 with rs3864814") +
  coord_cartesian(ylim = c(0, max_gwasp)) +
  labs(title = "GWAS: Colocalization with STOX1 near rs3864814", y = "-log10(p-value)") +
  theme_minimal() +
  theme(legend.position = "bottom", plot.margin = uniform_margin)

# Create a scatter plot for eQTL
eqtl_plot <- ggplot(data_nearest_300, aes(x = position, y = -log10(eqtlp), color = color)) +
  geom_point() +
  geom_vline(xintercept = rs3864814_position, linetype = "dashed", color = "red") +
  scale_color_identity(name = "r2 with rs3864814") +
  coord_cartesian(ylim = c(0, max_eqtlp)) +
  labs(title = "eQTL: Colocalization with STOX1 near rs3864814", y = "-log10(p-value)") +
  theme_minimal() +
  theme(legend.position = "bottom", plot.margin = uniform_margin)

# Create a plot for Posterior Probability (PP4)
pp4_plot <- ggplot(data_nearest_300, aes(x = position, y = ifelse(snp == "rs3864814", 1, 0), color = color)) +
  geom_point() +
  geom_vline(xintercept = rs3864814_position, linetype = "dashed", color = "red") +
  scale_color_identity(name = "r2 with rs3864814") +
  coord_cartesian() +
  labs(title = "Posterior Probability (PP4) near rs3864814", y = "Posterior Probability") +
  scale_y_continuous(breaks = c(0, 0.25, 0.50, 0.75, 1)) +
  theme_minimal() +
  theme(legend.position = "bottom", plot.margin = uniform_margin)

# Stack three images vertically into one
grid_arranged_plot <- grid.arrange(gwas_plot, eqtl_plot, pp4_plot, ncol = 1)

# Save graphic with adjusted size to show legend
ggsave("COLOC_plot.png", grid_arranged_plot, width = 20, height = 10)
