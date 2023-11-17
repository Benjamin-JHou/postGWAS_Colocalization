library("coloc")
library(dplyr)

# Import Phenotype 1 (GWAS) data：
gwas <- read.table(file="/Users/zhoujunyu/Desktop/GWAS.txt", header=T);

# Import Phenotype 2 (eQTL) data:
eqtl <- read.table(file="/Users/zhoujunyu/Desktop/eQTL.txt", header=T);

# Merging GWAS and eQTL data

merged_data <- merge(gwas, eqtl, by="rs_id")

# Colocalization analysis
result <- coloc.abf(
  dataset1 = list(
    snp = merged_data$rs_id,             
    pvalues = merged_data$pval_nominal.x,  
    beta = log(merged_data$OR),          
    type = "cc",                  
    s = 0.33,                  
    N = 50000                     
  ),
  dataset2 = list(
    snp = merged_data$rs_id,             
    pvalues = merged_data$pval_nominal.y,  
    type = "quant",               
    N = 10000                     
  ),
  MAF = merged_data$MAF                
)

# Screen for colocalized sites
library(dplyr)
need_result=result$results %>% filter(SNP.PP.H4 > 0.8)

