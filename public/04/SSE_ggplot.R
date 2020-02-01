library(dplyr)
library(ggplot2)
library(latex2exp)
data("AccordPrice")
fit <- lm(Price ~ Mileage, data = AccordPrice)
AccordPrice <- AccordPrice %>%
  mutate(predicted = predict(fit),
         residuals = residuals(fit),
         top_right = Mileage + residuals,
         bottom_right = Mileage + residuals,
         y_bar = mean(Price)
    )


# Residual - Overall
ggplot(AccordPrice, aes(x=Mileage, y=Price)) +  # Set up canvas with outcome variable on y-axis
  theme_bw() +
  geom_point() + # Plot the actual points
  geom_point(aes(x=Mileage, y = predicted), color="blue", size=2) + 
  #geom_point(aes(x = top_right, y = Price), shape = 1, color="white") + 
  #geom_point(aes(x = bottom_right, y = predicted), shape = 1, color="white") +
  geom_smooth(method="lm", se=FALSE, size=0.5) +  
  geom_segment(aes(x=Mileage, y=Price, xend = Mileage, yend = predicted)) +
  #coord_cartesian(xlim = c(0,20), ylim=c(15,35)) + 
  annotate("text",x=4.5, y=27, hjust=1, vjust=0.5,
            label=TeX("$y$"), size=8) +
  annotate("text",x=4.5, y=20, hjust=1, vjust=1,
            label=TeX("$\\hat{y}$"), color="blue", size=8)  


# Residual - ZOOMED
ggplot(AccordPrice, aes(x=Mileage, y=Price)) +  # Set up canvas with outcome variable on y-axis
  theme_bw() +
  geom_point() + # Plot the actual points
  geom_point(aes(x=Mileage, y = predicted), color="blue", size=2) + 
  geom_point(aes(x = top_right, y = Price), shape = 1, color="white") + 
  geom_point(aes(x = bottom_right, y = predicted), shape = 1, color="white") +
  geom_smooth(method="lm", se=FALSE, size=0.5) +  
  geom_segment(aes(x=Mileage, y=Price, xend = Mileage, yend = predicted)) +
  coord_cartesian(xlim = c(0,20), ylim=c(15,35)) + 
  annotate("text",x=4.5, y=27, hjust=1, vjust=0.5,
            label=TeX("$y$"), size=8) +
  annotate("text",x=4.5, y=20, hjust=1, vjust=1,
            label=TeX("$\\hat{y}$"), color="blue", size=8)   


# Squared Residuals
ggplot(AccordPrice, aes(x=Mileage, y=Price)) +  # Set up canvas with outcome variable on y-axis
  theme_bw() +
  geom_point() + # Plot the actual points
  geom_point(aes(x=Mileage, y = predicted), color="blue", size=2) + 
  geom_point(aes(x = top_right, y = Price), shape = 1, color="white") + 
  geom_point(aes(x = bottom_right, y = predicted), shape = 1, color="white") +
  geom_smooth(method="lm", se=FALSE, size=0.5) +  
  geom_segment(aes(x=Mileage, y=Price, xend = Mileage, yend = predicted)) +
  coord_cartesian(xlim = c(0,20), ylim=c(15,35)) + 
  annotate("text",x=4.5, y=27, hjust=1, vjust=0.5,
            label=TeX("$y$"), size=8) +
  annotate("text",x=4.5, y=20, hjust=1, vjust=1,
            label=TeX("$\\hat{y}$"), color="blue", size=8) + 
  geom_segment(aes(x=Mileage, y=Price, yend = Price, xend = top_right), color = "grey", linetype = "dashed") +   geom_segment(aes(x=bottom_right, y=predicted, yend = Price, xend = top_right), color = "grey", linetype = "dashed") + 
   geom_segment(aes(x=Mileage, y=predicted, yend = predicted, xend = bottom_right), color = "lightgrey", linetype = "dashed") +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank())


# PARTITIONING VARIABILITY
### TOTAL FIGURE
ggplot(AccordPrice, aes(x=Mileage, y=Price)) +  # Set up canvas with outcome variable on y-axis
  theme_bw() +
  geom_point() + # Plot the actual points
  #geom_point(aes(x=Mileage, y = y_bar), color="red", size=1) + 
  #geom_point(aes(x=Mileage, y = predicted), color="blue", size=1) + 
  geom_smooth(method="lm", se=FALSE, size=0.5) +  
  #geom_hline(yintercept=14.27667, color="red") +
  geom_segment(aes(x=3 ,xend=150,y=AccordPrice$y_bar,yend=AccordPrice$y_bar), color="red") +
  #geom_segment(aes(x=Mileage, y=Price, xend = Mileage, yend = 14.27667), color="red", linetype="dashed", size=0.25) +
  annotate("text",x=-.3, y=27, hjust=1, vjust=0.5,
            label=TeX("$y_i$"), size=8) +
  annotate("text",x=-.3, y=20, hjust=1, vjust=0.25,
            label=TeX("$\\hat{y}_i$"), color="blue", size=8) + 
  annotate("text",x=-.3, y=14, hjust=1, vjust=0.5,
            label=TeX("$\\bar{y}$"), color="red", size=8) + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank())

### SSM
ggplot(AccordPrice, aes(x=Mileage, y=Price)) +  # Set up canvas with outcome variable on y-axis
  theme_bw() +
  geom_point() + # Plot the actual points
  #geom_point(aes(x=Mileage, y = y_bar), color="red", size=1) + 
  #geom_point(aes(x=Mileage, y = predicted), color="blue", size=1) + 
  geom_smooth(method="lm", se=FALSE, size=0.5) +  
  #geom_hline(yintercept=14.27667, color="red") +
  geom_segment(aes(x=3 ,xend=150,y=AccordPrice$y_bar,yend=AccordPrice$y_bar), color="red") +
  geom_segment(aes(x=predicted, y=Price, xend = predicted, yend = AccordPrice$y_bar), color="red", linetype="dashed", size=0.25) +
  annotate("text",x=-.3, y=27, hjust=1, vjust=0.5,
            label=TeX("$y_i$"), size=8) +
  annotate("text",x=-.3, y=20, hjust=1, vjust=0.25,
            label=TeX("$\\hat{y}_i$"), color="blue", size=8) + 
  annotate("text",x=-.3, y=14, hjust=1, vjust=0.5,
            label=TeX("$\\bar{y}$"), color="red", size=8) + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank())



#   HIGHLIGHTING CERTAIN POINTS
#   geom_point(data=mydata[10:13, ], aes(x=a, y=b), colour="red", size=5)





ggplot(AccordPrice, aes(x=Mileage, y=Price)) +  # Set up canvas with outcome variable on y-axis
  theme_bw() +
  geom_point() + # Plot the actual points
  geom_point(aes(x=Mileage, y = predicted), color="blue", size=2) + 
  geom_point(aes(x = top_right, y = Price), shape = 1, color="white") + 
  geom_point(aes(x = bottom_right, y = predicted), shape = 1, color="white") +
  geom_smooth(method="lm", se=FALSE, size=0.5) +  
  coord_cartesian(xlim = c(0,20), ylim=c(15,35)) + 
# + expand_limits(y = c(0, 30))
 # Add the predicted values
  geom_segment(aes(x=Mileage, y=Price, xend = Mileage, yend = predicted))  + 
  geom_segment(aes(x=Mileage, y=Price, yend = Price, xend = top_right), color = "grey", linetype = "dashed") + 
   geom_segment(aes(x=bottom_right, y=predicted, yend = Price, xend = top_right), color = "grey", linetype = "dashed") + 
   geom_segment(aes(x=Mileage, y=predicted, yend = predicted, xend = bottom_right), color = "lightgrey", linetype = "dashed") +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank())

+ 
  
  
  geom_segment(aes(x= bottom_right, y=predicted, yend = predicted, xend = bottom_right), color = "orange", linetype = "dashed")
+
  geom_segment(aes(xend = predicted, yend = bottom_right), color = "red", linetype = "dashed")


  geom_segment(aes(xend = top_right, yend = bottom_right))