---
title: "Logistic Regression - Answers"
author: "SDS 291"
date: "4/6/2020"
output:
  pdf_document:
    toc: yes
  html_document:
    css: ~/Dropbox/3_Smith/SDS291/sds291_site/static/img/labs.css
    highlight: textmate
    theme: journal
    toc: yes
---



We have data from each state (n=50) on their average income, education (% high school, % college, and % advanced degrees completed), political leaning from a 2015 Gallup poll and whether President Trump won that state (1=Win) or not (0=Did not Win) in the 2016 election.


```
## 'data.frame':	50 obs. of  8 variables:
##  $ State   : Factor w/ 50 levels "Alabama ","Alaska ",..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ Abr     : Factor w/ 50 levels "AK","AL","AR",..: 2 1 4 3 5 6 7 8 9 10 ...
##  $ Income  : int  43623 72515 50255 41371 61818 60629 70331 60509 47507 49620 ...
##  $ HS      : num  84.3 92.1 86 84.8 81.8 90.7 89.9 88.4 86.9 85.4 ...
##  $ BA      : num  23.5 28 27.5 21.1 31.4 38.1 37.6 30 27.3 28.8 ...
##  $ Adv     : num  8.7 10.1 10.2 7.5 11.6 14 16.6 12.2 9.8 10.7 ...
##  $ Dem.Rep : int  -17 -17 -1 -7 16 -1 11 6 1 -4 ...
##  $ TrumpWin: int  1 1 1 1 0 0 0 0 1 1 ...
```
 
# Income and Election Outcome
## Plots
Below are two plots exploring the relationship between income and President Trump winning that state.  They are depicting the same pattern; the second "jitters" the data.

![](17-class-exercise_answers_files/figure-latex/unnamed-chunk-2-1.pdf)<!-- --> ![](17-class-exercise_answers_files/figure-latex/unnamed-chunk-2-2.pdf)<!-- --> 

1. Which is the easier graph to understand? Why?

The right plot, with the jittered data makes the patterns more apparent since the points aren't overlaying.

2. What do you conclude from the plot about the relationship between income and the 2016 election results?

The plot depicts a negative relationship between income and the 2016 election results. It is hard to determine the magnitude, but it seems sort of moderately to weak, since there are a number of states with the same average income that President Trump won and didn't win.

## Logistic Model

Let's fit a logistic regression model to these data: $log(\frac{\pi}{1-\pi}) = \beta_0+\beta_1 X_1$

Let's use Income in \$1,000s to make the interpretation a little easier.  Then we re-fit a logistic regression model.


```r
Election16<-Election16 %>% mutate(Income1000s = Income/1000)
m1<-glm(TrumpWin~Income1000s, data=Election16, family=binomial)
summary(m1)
```

```
## 
## Call:
## glm(formula = TrumpWin ~ Income1000s, family = binomial, data = Election16)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -2.2049  -0.7510   0.4074   0.6566   2.5000  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)    
## (Intercept) 11.18186    3.07576   3.635 0.000277 ***
## Income1000s -0.19668    0.05582  -3.523 0.000426 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 67.301  on 49  degrees of freedom
## Residual deviance: 45.923  on 48  degrees of freedom
## AIC: 49.923
## 
## Number of Fisher Scoring iterations: 5
```

3. Write the fitted regression model equation using the output above.

$log(odds) = 11.18186+-0.19668 Income1000s$

4. What is the direction and magnitude of the relationship between the average income and whether Pres. Trump won that state?

The association is negative and slight/shallow slope.

5. Calculate the log(odds) (the book calls this the Empirical Logit), the odds, and the probability of President Trump winning for each of the following income levels.  As a reminder, you can calculate each from the same output.

_Log(odds):_ $$log(odds) = \beta_0+\beta_1 X_1$$
_Odds:_ $$Odds = e^{\beta_0+\beta_1 X_1}$$
_Probability:_ $$\pi = \frac{odds}{1+odds} = \frac{e^{\beta_0+\beta_1 X_1}}{1+e^{\beta_0+\beta_1 X_1}}$$


```r
Income1000s<-c(40:70)
logodds<-coef(m1)[1]+ (coef(m1)[2]*Income1000s)
m1_data<-as.data.frame(cbind(Income1000s,logodds))
m1_data <- m1_data %>%
  mutate(odds=exp(logodds),
        prob = odds/(1+odds))
```

| Income | \$40,000    | \$50,000     | \$51,000    | \$55,000    |\$60,000    |\$61,000    |  \$70,000   |
|-----|------------|------------|------------|------------|------------|------------|------------|
| Log(odds) | 3.315  |  1.348 | 1.151 | 0.365 | -0.619 | -0.815  |  -2.586 |
| Odds | 27.516  |  3.85 | 3.162 | 1.44 | 0.539 | 0.442  |  0.075 |
| Probability|  0.965  |  0.794 | 0.76 | 0.59 | 0.35 | 0.307  |  0.07 |

6. Plot the values on each of the three plots below.


Log(odds)

![](17-class-exercise_answers_files/figure-latex/unnamed-chunk-5-1.pdf)<!-- --> 

Odds

![](17-class-exercise_answers_files/figure-latex/unnamed-chunk-6-1.pdf)<!-- --> 

Probability

![](17-class-exercise_answers_files/figure-latex/unnamed-chunk-7-1.pdf)<!-- --> 

![](17-class-exercise_answers_files/figure-latex/unnamed-chunk-8-1.pdf)<!-- --> 

7. What is the ratio of odds for President Trump winning a state?

7a. Calculate the ratio the odds of a (theoretical) state with \$51,000 average income to a state with \$50,000 average income.


```r
Odds51<-3.1623911
Odds50<-3.8497399
OR5051<-Odds51/Odds50
OR5051
```

```
## [1] 0.8214558
```



7b. Calculate the ratio the odds of a (theoretical) state with \$61,000 average income to a state with \$60,000 average income.


```r
Odds61<-0.4424431
Odds60<-0.5386085
OR6061<-Odds61/Odds60
OR6061
```

```
## [1] 0.8214558
```


7c. Calculate the OR from the model ($OR = e^{\beta_1}$).  Interpret the odds ratio in a sentence.


```r
exp(coef(m1)[2])
```

```
## Income1000s 
##   0.8214558
```

Each additional \$1,000 average income was associated with 0.82 times the odds of Trump winning in a state. States with \$1,000 higher average income had a lower odds of Trump winning than a state with \$1,000 lower average income.

7d. Did you get the same values from each approach? Why or why not?

Yes. Since we fit the logistic regression model as a linear model on the log(odds) scale, the slope of the line, or the Odds Ratio, is constant, just as a slope was in linear regression.


8. Specify your hypotheses and conduct a test of whether the relationship between average income and President Trump winning a state is statistically signficant at the $\alpha = 0.05$ level.

$H_0: \beta_1 = 0$

$H_0: \beta_1 \ne 0$

We reject the null hypothesis since the test statistic for the relationship between income and Trump winning was below the critical value (-3.523<-1.96) and the associated p-value is below the 0.05 threshold (p<0.001).


9. Calculate the 95% Confidence Interval for the odds ratio of each additional \$1,000 of average income and of Pres Trump winning that state. $t^* = 1.96$


```r
lci<-exp(-0.19668 - (1.96*0.05582))
uci<-exp(-0.19668 + (1.96*0.05582))
CIs<-cbind(lci,uci)
CIs
```

```
##            lci       uci
## [1,] 0.7363224 0.9164271
```

Or get `R` to do it for you:


```r
exp(confint(m1))
```

```
##                   2.5 %       97.5 %
## (Intercept) 366.9418556 7.917787e+07
## Income1000s   0.7232693 9.037885e-01
```


10. Create a binary variable of whether that state had above or below the national average rate of bachelor's degree holders (29.1%) and repeat the steps above in `R`. (A note, these are the averages from these data, rather than from an external source that quoted a higher value.  You might want to dichomoize at the median rather than the mean to avoid some very high/low BA degree states skewing the data, but nonethelesss, this is one approach.)


```r
Election16<-Election16 %>%
  mutate(Bach_Avg=as.factor(if_else(BA>=29,"Above","Below")))
Election16$Bach_Avg <- relevel(Election16$Bach_Avg, ref="Below")

Election16 %>%
  ggplot(aes(y=TrumpWin, x=Bach_Avg)) + geom_jitter(width=0.1, height=0.05) 
```

![](17-class-exercise_answers_files/figure-latex/unnamed-chunk-14-1.pdf)<!-- --> 

```r
#another way to look at this is with a boxplot -- it will give you a solid line to indicate where most of the distribution is
Election16 %>%
  ggplot(aes(y=TrumpWin, x=Bach_Avg)) + geom_boxplot()
```

![](17-class-exercise_answers_files/figure-latex/unnamed-chunk-14-2.pdf)<!-- --> 

We see from the visual that being in a state that has higher than average rates of bachelor's degree holders is negatively associated with Trump winning those states.


```r
library(mosaic)
tally(TrumpWin~Bach_Avg, data=Election16)
```

```
##         Bach_Avg
## TrumpWin Below Above
##        0     2    18
##        1    26     4
```

```r
tally(TrumpWin~Bach_Avg, margins=TRUE, format = "proportion", data=Election16)
```

```
##         Bach_Avg
## TrumpWin      Below      Above
##    0     0.07142857 0.81818182
##    1     0.92857143 0.18181818
##    Total 1.00000000 1.00000000
```

```r
#
library(gmodels)
with(Election16, CrossTable(TrumpWin, Bach_Avg,
prop.r=FALSE, prop.chisq=FALSE, prop.t=FALSE))
```

```
## 
##  
##    Cell Contents
## |-------------------------|
## |                       N |
## |           N / Col Total |
## |-------------------------|
## 
##  
## Total Observations in Table:  50 
## 
##  
##              | Bach_Avg 
##     TrumpWin |     Below |     Above | Row Total | 
## -------------|-----------|-----------|-----------|
##            0 |         2 |        18 |        20 | 
##              |     0.071 |     0.818 |           | 
## -------------|-----------|-----------|-----------|
##            1 |        26 |         4 |        30 | 
##              |     0.929 |     0.182 |           | 
## -------------|-----------|-----------|-----------|
## Column Total |        28 |        22 |        50 | 
##              |     0.560 |     0.440 |           | 
## -------------|-----------|-----------|-----------|
## 
## 
```

## Models

```r
m2_2016<-glm(TrumpWin~Bach_Avg, data=Election16, family=binomial)
summary(m2_2016)
```

```
## 
## Call:
## glm(formula = TrumpWin ~ Bach_Avg, family = binomial, data = Election16)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -2.2974  -0.6335   0.3850   0.3850   1.8465  
## 
## Coefficients:
##               Estimate Std. Error z value Pr(>|z|)    
## (Intercept)     2.5649     0.7338   3.495 0.000473 ***
## Bach_AvgAbove  -4.0690     0.9187  -4.429 9.46e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 67.301  on 49  degrees of freedom
## Residual deviance: 35.272  on 48  degrees of freedom
## AIC: 39.272
## 
## Number of Fisher Scoring iterations: 5
```

```r
#This code combines the odds ratios and the 95% CIs into three columns (OR, lower CI, Upper CI) for each of the terms in the model (here, just the intercept and the slope)
results_2016<-exp(cbind(coef(m2_2016), confint(m2_2016)))
```

```
## Waiting for profiling to be done...
```

```r
results_2016
```

```
##                                2.5 %      97.5 %
## (Intercept)   13.00000000 3.88861865 80.69732730
## Bach_AvgAbove  0.01709402 0.00208761  0.08559716
```

A state with more than the national average of bachelor's degree holders (i.e., a more highly educated state) has 0.017 times the odds of Trump winning the state than a state with less than the national average of bachelor degree holders. We are 95% confident that the true relationship between having above average amount of bachelor's degree holders, compared to below average, and odds Trump winning is between 0.002 and 0.086.  We can reject the null hypothesis ($H_0: \beta_1 = 0$ and $H_A: \beta_1 \ne 0$) and conclude that the association between a state having an above average number of bachelor degree holders had significantly lower odds of Trump winning than a state with below average bachelor's degree holders, as evidenced by the large test statstic (-4.429 < -1.96) and the small p-value (9.46e-06, which is below our threshold of 0.05).

# Recreating the above with the Elections 2008 data 

The `Election16` data is in version 2.0 of the Stat2Data package, which isn't yet on the server in the Stat2Data package. You could practice with the `Election08` data, with the same variables based on the 2008 election.


```r
data("Election08")
Election08<-Election08 %>%
  mutate(Bach_Avg=as.factor(if_else(BA>=27.14,"Above","Below")),
    Income1000s = Income/1000)
Election08$Bach_Avg <- relevel(Election08$Bach_Avg, ref="Below")
```

#Obama Winning and Income

```r
Election08 %>%
  ggplot(aes(y=ObamaWin, x=Income)) + geom_jitter(width = 0.1, height=0.05)
```

![](17-class-exercise_answers_files/figure-latex/unnamed-chunk-18-1.pdf)<!-- --> 

```r
m1_2008<-glm(ObamaWin~Income1000s, data=Election08, family=binomial)
summary(m1_2008)
```

```
## 
## Call:
## glm(formula = ObamaWin ~ Income1000s, family = binomial, data = Election08)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -2.3433  -0.7976   0.1329   0.6866   1.8124  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)    
## (Intercept) -12.4251     3.7522  -3.311 0.000928 ***
## Income1000s   0.3494     0.1050   3.328 0.000874 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 69.737  on 50  degrees of freedom
## Residual deviance: 48.867  on 49  degrees of freedom
## AIC: 52.867
## 
## Number of Fisher Scoring iterations: 5
```

```r
#This code combines the odds ratios and the 95% CIs into three columns (OR, lower CI, Upper CI) for each of the terms in the model (here, just the intercept and the slope)
results1_2008<-exp(cbind(coef(m1_2008), confint(m1_2008)))
results1_2008
```

```
##                                 2.5 %      97.5 %
## (Intercept) 4.016472e-06 8.491176e-10 0.002563891
## Income1000s 1.418252e+00 1.185437e+00 1.799879223
```

#Obama Winning and Bachelor's Degrees

```r
Election08 %>%
  ggplot(aes(y=ObamaWin, x=Bach_Avg)) + geom_jitter(width = 0.1, height=0.05)
```

![](17-class-exercise_answers_files/figure-latex/unnamed-chunk-19-1.pdf)<!-- --> 

```r
m2_2008<-glm(ObamaWin~Bach_Avg, data=Election08, family=binomial)
summary(m2_2008)
```

```
## 
## Call:
## glm(formula = ObamaWin ~ Bach_Avg, family = binomial, data = Election08)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -1.9479  -0.9895   0.5701   0.5701   1.3777  
## 
## Coefficients:
##               Estimate Std. Error z value Pr(>|z|)   
## (Intercept)    -0.4595     0.3687  -1.246  0.21268   
## Bach_AvgAbove   2.1941     0.7267   3.019  0.00253 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 69.737  on 50  degrees of freedom
## Residual deviance: 58.289  on 49  degrees of freedom
## AIC: 62.289
## 
## Number of Fisher Scoring iterations: 4
```

```r
#This code combines the odds ratios and the 95% CIs into three columns (OR, lower CI, Upper CI) for each of the terms in the model (here, just the intercept and the slope)
results2_2008<-exp(cbind(coef(m2_2008), confint(m2_2008)))
results2_2008
```

```
##                             2.5 %    97.5 %
## (Intercept)   0.6315789 0.2981381  1.285685
## Bach_AvgAbove 8.9722222 2.3993648 44.638041
```
