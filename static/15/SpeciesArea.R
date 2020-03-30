library(tidyverse)
library(Stat2Data)

data("SpeciesArea")

#Original Shape
qplot(y=Species, x=Area, data=SpeciesArea)

#Logged both X and Y
qplot(y=log(Species), x=log(Area), data=SpeciesArea)