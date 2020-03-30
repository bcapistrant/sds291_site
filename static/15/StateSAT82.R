library(tidyverse)

StateSAT82<-read.csv(url("https://sds291.netlify.com/15/StateSAT82.csv"))

#Linear model

## Scatterplot
qplot(x=Takers, y=SAT, data=StateSAT82)

## Linear Model
mod1<-lm(SAT~Takers, data=StateSAT82)
plot(mod1, which=1)

# Quadratic Model

## Model

### Method 1 - Make new column/variable
StateSAT82 <- StateSAT82 %>%
	mutate(Takers_Sq=Takers^2)
quadmod_method1 <- lm(SAT~Takers+Takers_Sq, data=StateSAT82)
summary(quadmod_method1)
plot(quadmod_method1, which=1)

### Method 2 - Add Directly into Model (should get the same answer as Method 1)
quadmod_method2 <- lm(SAT~Takers+I(Takers^2), data=StateSAT82)
summary(quadmod_method2)
plot(quadmod_method2, which=1)

## Plot the Quadratic Fit

qplot(x=Takers, y=SAT, data=StateSAT82) + 
  stat_smooth(method = "lm", formula=y ~ x + I(x^2), se=FALSE)


