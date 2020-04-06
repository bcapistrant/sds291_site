#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

library(Stat2Data)
library(ggplot2)
library(magrittr)
library(dplyr)

data(Putts1)
Putts_logistic <- glm(Made ~ Length, data=Putts1, family=binomial)
logodds <- predict(Putts_logistic, data.frame(Length=c(3:7)))
odds <- exp(logodds)
prob <- odds/(1+odds)
Length <- c(3:7)
logit_data <- as.data.frame(cbind(prob,odds,logodds,Length))

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Visualizing Logistic Regression Slope and Intercept Coefficients"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("const",
                  "Intercept:",
                  min = -2,
                  max = 8,
                  value = 3.25684),
      sliderInput("slope",
                  "Slope:",
                  min=-2,
                  max=1,
                  value=-0.56614)
        ),

        # Show a plot of the generated distribution
        mainPanel(fluidRow(
            splitLayout(cellWidths = c("50%", "50%"), plotOutput("distPlot"), plotOutput("logPlot"))
        ))
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        
            length_input <- seq(from=0, to=10, by=0.01)
            logodds_input<- input$const + input$slope*length_range
            prob_input <- exp(logodds_input) / (1+ exp(logodds_input))
            input_data<-data.frame(prob_input,logodds_input,length_input)
            
       dist1<- ggplot(Putts1, aes(x=Length,y=Made)) + 
            geom_point() + geom_jitter(height = 0.025) +
            geom_point(logit_data, aes(x=Length, y=prob), color="orange") +
            geom_smooth(method="glm",method.args=list(family="binomial"), se=FALSE,fullrange=TRUE, color="orange") +
            xlim(1,10) + ylim(0,1)
       dist1 <- dist1 + ggplot(input_data, aes(x=length_input,y=prob_input))  + geom_line(lwd=2, color="black")
       
       dist1
   })
     output$logPlot <- renderPlot({
         
            length_input <- seq(from=0, to=10, by=0.01)
            logodds_input<- input$const + input$slope*length_range
            prob_input <- exp(logodds_input) / (1+ exp(logodds_input))
            input_data<-data.frame(prob_input,logodds_input,length_input)
            
             logplot1 <- ggplot(logit_data, aes(x=Length,y=logodds)) + geom_point(color="orange") +
                            geom_abline(intercept = 3.25684, slope = -0.56614, color="orange")
             logplot1 <- logplot1 + ggplot(input_data, aes(x=length_input,y=logodds_input)) + geom_point(color="black") +
                            geom_abline(intercept = input$const, slope = input$slope, color="black")
                        
             logplot1
   
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
