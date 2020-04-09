---
title: "Logistic Regression"
author: "SDS 291"
date: "April 13, 2020"
output:
  pdf_document: default
  word_document: default
---



We're going to work with the `Whickham` data contains observations about women, and whether they were alive 20 years after their initial observation (`outcome` is a 2 level factor variable - Alive/Dead). You can learn more about these data from the `mosaicData` help feature if you'd like.

Specifically, we're interested in: the association of age, smoking status (smoker), and 20-year survival (outcome: alive (success), dead (reference / failure)).  Bring in the relevant packages and the data (above, from the mosaic package).

# Age and Outcome

![](19-inclasslab_files/figure-latex/unnamed-chunk-2-1.pdf)<!-- --> ![](19-inclasslab_files/figure-latex/unnamed-chunk-2-2.pdf)<!-- --> 



```r
m0<-glm(outcome~age, data=Whickham, family=binomial)
summary(m0)
```

```
## 
## Call:
## glm(formula = outcome ~ age, family = binomial, data = Whickham)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -3.2296  -0.4277   0.2293   0.5538   1.8953  
## 
## Coefficients:
##              Estimate Std. Error z value Pr(>|z|)    
## (Intercept)  7.403126   0.403522   18.35   <2e-16 ***
## age         -0.121861   0.006941  -17.56   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 1560.32  on 1313  degrees of freedom
## Residual deviance:  946.51  on 1312  degrees of freedom
## AIC: 950.51
## 
## Number of Fisher Scoring iterations: 6
```

1. Write the fitted equation and interpret the results (in these units) in light of the question. Be sure to comment on the magnitude and direction of the association.

\vspace{3in}

2. Based on this model, what is the probability that a 60 year old was alive 20 years after the initial survey?

\vspace{3in}

\newpage
# Smoking Status and Outcome (Alive)


```r
Whickham$smoker<-factor(Whickham$smoker, levels=c("Yes", "No"))
Whickham$outcome<-factor(Whickham$outcome, levels=c("Alive", "Dead"))
tally(~ smoker + outcome, margins=FALSE, data=Whickham)
```

```
##       outcome
## smoker Alive Dead
##    Yes   443  139
##    No    502  230
```


3. Calculate the Odds Ratio of non-smokers being alive in 20 years compared to smokers from the table above.
\vspace{3in}


```r
Whickham$smoker<-relevel(Whickham$smoker, ref= "No")
Whickham$outcome<-relevel(Whickham$outcome, ref= "Dead")
m1<-glm(outcome~smoker, data=Whickham, family=binomial)
summary(m1)
```

```
## 
## Call:
## glm(formula = outcome ~ smoker, family = binomial, data = Whickham)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -1.6923  -1.5216   0.7388   0.8685   0.8685  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)    
## (Intercept)  0.78052    0.07962   9.803  < 2e-16 ***
## smokerYes    0.37858    0.12566   3.013  0.00259 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 1560.3  on 1313  degrees of freedom
## Residual deviance: 1551.1  on 1312  degrees of freedom
## AIC: 1555.1
## 
## Number of Fisher Scoring iterations: 4
```

4. Show that you can calculate the coefficient for smoking status from your regression model as you did in #3.

\vspace{3in}

5. Based on your model, what's the probability that a smoker was alive 20 years later?

\vspace{3in}

6. Based on what you know about the risk of death for age and smoking status, do these results make sense? Explain your answer.

\newpage
## Multiple Logistic Regression

```r
m2<-glm(outcome~age+smoker, data=Whickham, family=binomial)
summary(m2)
```

```
## 
## Call:
## glm(formula = outcome ~ age + smoker, family = binomial, data = Whickham)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -3.2795  -0.4381   0.2228   0.5458   1.9581  
## 
## Coefficients:
##              Estimate Std. Error z value Pr(>|z|)    
## (Intercept)  7.599221   0.441231  17.223   <2e-16 ***
## age         -0.123683   0.007177 -17.233   <2e-16 ***
## smokerYes   -0.204699   0.168422  -1.215    0.224    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 1560.32  on 1313  degrees of freedom
## Residual deviance:  945.02  on 1311  degrees of freedom
## AIC: 951.02
## 
## Number of Fisher Scoring iterations: 6
```

7. What is the odds ratio for smokers compared to non-smokers in this model? Interpret in a sentence in the context of this real-world problem.

\vspace{3in}


8. What is the probability of a 60 year old non-smoker being alive 20 years later?

\vspace{3in}


9. What is the probability of a 40 year old smoker being alive 20 years later?

\vspace{3in}


10. What does this model help us to understand about our simple logistic regression estimates above?

\vspace{3in}
