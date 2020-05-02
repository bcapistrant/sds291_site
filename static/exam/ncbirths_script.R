library(openintro)
library(tidyverse)
data("ncbirths")

ncbirths2 <- ncbirths %>%
  mutate(lowCode = if_else(lowbirthweight=="low",1,
                     if_else(lowbirthweight=="not low",0,NA_real_))) %>%
  select(lowCode, lowbirthweight, weeks, visits, marital) %>%
  filter(complete.cases(.))

 
write.csv(ncbirths2, file="~/Dropbox/3_Smith/SDS291/sds291_site/static/exam/291-2ndExam.csv")