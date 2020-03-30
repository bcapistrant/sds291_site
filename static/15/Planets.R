library(tidyverse)
Planets<-read.csv(url("https://sds291.netlify.com/15/Planets.csv"))

qplot(x=Distance, y=Year, data=Planets)

Planets <- Planets %>%
	mutate(newyear=Year^(2/3))

qplot(x=Distance, y=newyear, data=Planets)


# Now You Try

# 1. Year vs. Distance



# 2.log(Year) vs. Distance



# 3.Year vs. log(Distance)



# 4.log(Year) vs. log(Distance)