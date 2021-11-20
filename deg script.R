library(DESeq2)
rawcounts <- read.csv(file.choose(), sep = ",", header = TRUE)
rawcounts

metadata <- read.csv(file.choose(), sep = ",", header = TRUE)
metadata

row.names(metadata)
rawcountsRN <- data.frame(rawcounts, row.names=1)
head(rawcountsRN)

metadataRN <- data.frame(metadata, row.names=1)
head(metadataRN)

row.names(metadataRN)
row.names(rawcountsRN)

dds <- DESeqDataSetFromMatrix(countData=round(rawcountsRN), 
                              colData=metadataRN, 
                              design=~Treatment)
dds
sizeFactors(dds)
dds <- DESeq(dds)

res <- results(dds, tidy=TRUE)
res <- tbl_df(res)
res

