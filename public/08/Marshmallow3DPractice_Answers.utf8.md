---
title: "SLR/2D into MLR/3D - Part 2"
author: "SDS 291, Spring 2020"
date: "2/19/2020"
output:
  html_document:
    css: "~/Dropbox/3_Smith/SDS291/sds291_site/static/img/labs.css"
    highlight: textmate
    theme: journal
    toc: true
---



<table class="table" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:right;"> marshmallow </th>
   <th style="text-align:right;"> height </th>
   <th style="text-align:right;"> length </th>
   <th style="text-align:right;"> width </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> -0.8 </td>
   <td style="text-align:right;"> 1.5 </td>
   <td style="text-align:right;"> 3.6 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 5.0 </td>
   <td style="text-align:right;"> 2.4 </td>
   <td style="text-align:right;"> 2.3 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1.5 </td>
   <td style="text-align:right;"> 3.3 </td>
   <td style="text-align:right;"> 3.5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 7.0 </td>
   <td style="text-align:right;"> 3.3 </td>
   <td style="text-align:right;"> 2.7 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 1.6 </td>
   <td style="text-align:right;"> 1.8 </td>
   <td style="text-align:right;"> 2.5 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 5.5 </td>
   <td style="text-align:right;"> 3.0 </td>
   <td style="text-align:right;"> 1.8 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 4.8 </td>
   <td style="text-align:right;"> 3.9 </td>
   <td style="text-align:right;"> 3.2 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 7.1 </td>
   <td style="text-align:right;"> 3.5 </td>
   <td style="text-align:right;"> 3.8 </td>
  </tr>
</tbody>
</table>

# Plot the data points.

Use the variable names literally -- let one edge of the brownie be the axis for length, the other the width, and y is the height (how where on the toothpick the marshmallow should go).

What are the range of units of length and width? Of Height?  Use these ranges thoughtfully in the next step.

1. Either put the marshmallows on fist and then put the toothpick where it should be for its values of width and length; or do the opposite order (place all toothpicks, then put marshmallows on)

# Imagine where the regression line would go?

1. Describe the relationship between x1 and y. Is the slope positive or negative, steep or shallow?

1. Describe the relationship between x2 and y. Is the slope positive or negative, steep or shallow?

# Fit the regression plane

1. Tear off a rectangle of parchment paper roughly the size of the brownie.

1. Put it through the toothpicks -- ie, poke holes through the paper -- so it best fits the data points (best = mean zero of the residuals).

You may have to move and replace some marshmallows...

# Visualize what "controlling for" means


```
## glX 
##   1
```

preserve523ee98f77b2beab


<!-- # Connecting the 2D with 3D -->

<!-- 1. Can you move the 3D box around to the point that it depicts (something very close to) the 2D / simple relationship between Mileage and Price? -->

<!-- 1. How does the quantitative value of the slope parameter(s) correspond to the visual? From the numeric output, would you have expected a steep or a shallow slope? Is that what you see visually? -->

<!-- 1. How is the numerical concept of "controlling for" expressed visually? -->

<!-- 1. What will the residuals look like in the 3D model? -->

# Connecting to the numeric data


```
## 
## Call:
## lm(formula = height ~ length + width)
## 
## Residuals:
##       1       2       3       4       5       6       7       8 
## -0.2856  1.1529 -2.6330  1.5500 -0.3408 -0.7003 -1.4028  2.6595 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)  
## (Intercept)   1.3196     3.8672   0.341   0.7468  
## length        2.5529     0.8943   2.855   0.0356 *
## width        -1.5840     1.1102  -1.427   0.2130  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.02 on 5 degrees of freedom
## Multiple R-squared:  0.6456,	Adjusted R-squared:  0.5038 
## F-statistic: 4.553 on 2 and 5 DF,  p-value: 0.07479
```

<img src="Marshmallow3DPractice_Answers_files/figure-html/unnamed-chunk-2-1.png" width="672" /><img src="Marshmallow3DPractice_Answers_files/figure-html/unnamed-chunk-2-2.png" width="672" />
