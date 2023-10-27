# 🌟 postGWAS_Colocalization
We provided a step-by-step guide for performing colocalization analysis using the coloc package in R.
![Image text](https://user-images.githubusercontent.com/147773802/278616135-d925301d-3a2e-4d90-9e77-13345ce4b8bb.png)
## 📥 Importing Data

### 🧬 Import Phenotype 1 (GWAS) data
```r
gwas_data <- read.table("path_to_gwas_data.txt", header=TRUE, sep="\t")
```
- ⚠️ Replace path_to_gwas_data.txt with the path to the correct GWAS dataset.

### 🧪 Import Phenotype 2 (eQTL) data

```r
eqtl_data <- read.table("path_to_eqtl_data.txt", header=TRUE, sep="\t")
```
- ⚠️ Replace path_to_eqtl_data.txt with the path to the correct eQTL dataset.

### 🔄 Merging GWAS and eQTL data
Before performing the analysis, ensure that the datasets are merged based on the SNP IDs.
```r
merged_data <- merge(gwas_data, eqtl_data, by="SNP_ID")
```
Replace SNP_ID with the appropriate column name for SNP identifiers if it's different in datasets.

### 📊 Performing Colocalization Analysis
With the datasets imported and merged, performing the colocalization analysis.
```r
library(coloc)

results <- coloc.abf(dataset1=list(beta=merged_data$beta_GWAS, varbeta=merged_data$varbeta_GWAS, pvalues=merged_data$pvalue_GWAS, type="quant trait", N=sample_size_gwas),
                     dataset2=list(beta=merged_data$beta_eQTL, varbeta=merged_data$varbeta_eQTL, pvalues=merged_data$pvalue_eQTL, type="quant trait", N=sample_size_eqtl))
```
- ⚠️ Columns "pvalue_GWAS" and "pvalue_eQTL" contain the p-values for GWAS and eQTL respectively
- ⚠️ Replace sample_size_gwas and sample_size_eqtl with the actual sample sizes for the correct GWAS and eQTL studies, respectively.

# 🔍 Interpreting Results

The coloc.abf function outputs posterior probabilities for each of the five hypotheses (H0 to H4). In general, a high posterior probability for H4 suggests that the GWAS and eQTL signals colocalize, indicating that they are likely driven by the same causal variant.

# 📚 Resources for Colocalization Analysis

Below are some essential resources and datasets for performing colocalization analysis:

## 🌐 eQTLs from 37 datasets

This resource consolidates eQTL data from 37 different datasets, encompassing a total of 31,684 individuals. It provides a rich collection of eQTLs that can be utilized for various genomic studies including colocalization analysis.

[eQTLgen datasets](http://www.eqtlgen.org/eqts.html)

## 📊 GTEx Datasets

The Genotype-Tissue Expression (GTEx) project provides a wide variety of datasets spanning multiple versions (from v6 to v8). These datasets are invaluable for studying the relationship between genetic variations and tissue-specific gene expression.

[GTEx Portal datasets](https://www.gtexportal.org/home/datasets)

## 📦 `coloc` R Package

The `coloc` package for R is an essential tool for performing colocalization analysis. It allows researchers to test for shared causal variants between two phenotypes, using summary data.

[ `coloc` GitHub Repository & Documentation](https://chr1swallace.github.io/coloc)


