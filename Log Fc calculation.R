library(readr)
library(dplyr)
library(ggplot2)

rawcounts <- read.csv(file.choose(), sep = ",", header = TRUE)
rawcounts

meancounts <- rawcounts %>% 
  mutate(controlmean = N3+N6+N7, treatedmean = C2+C4+CP2) %>% 
  select(Track_id, controlmean, treatedmean)
meancounts

result = meancounts %>% mutate(log2fc=log2(treatedmean/controlmean))
write.csv(result, "result.csv")

result2 = meancounts <- meancounts %>% 
  filter(controlmean>0 & treatedmean>0) %>% 
  mutate(log2fc=log2(treatedmean/controlmean))
meancounts
write.csv(result2, "result2.csv")

upregulated = meancounts %>% filter(log2fc>2)
write.csv(upregulated, "upregulated.csv")

downregulated = meancounts %>% filter(log2fc<(-2))
write.csv(downregulated, "downregulated.csv")

