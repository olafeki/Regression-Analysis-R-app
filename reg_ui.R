
ui <- navbarPage(title = "Regression Analysis",
                 
                 useShinyjs(),
                 
                 ##! HELP UI 
                 tabPanel(title = "Help",
                          fluidPage(
                            
                            h1("Welcome to our regression model HELP page :)", id = "monospaced-title", align= "center"),
                            tags$blockquote(tags$b("Do you know what is regression analysis?", style = "color:#00008B;")),
                            tags$img(src = "data:image/png;base64,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", width = "600px", height = "300px"),
                            tags$div(
                              tags$p("Regression analysis is a statistical technique that analyzes the relationship between a dependent variable and one or more independent variables. Its purpose is to create a model that can predict the value of the dependent variable based on the independent variables. "), 
                              tags$p("There are several types of regression analysis techniques, including linear regression, logistic regression, polynomial regression, and multivariate regression."), 
                              tags$p("Regression analysis involves several steps, including data collection, data cleaning and preparation, model selection, estimation of model parameters, model evaluation, and interpretation of results. It requires knowledge of statistical concepts such as correlation, hypothesis testing, and probability distributions.")
                            ),
                            tags$b("Now you understand what our model is used for now we will talk about types of regression analysis :)"),
                            tags$blockquote(tags$b("Linear regression: ", style = "color:#00008B;")),
                            tags$div(
                              tags$p("By the term itself, you can guess that the model functions along a straight line, where y can be calculated from a linear combination of the input variables x. Linear Regression hypothesis function can be formulated as:"), 
                              tags$img(src = "https://miro.medium.com/v2/resize:fit:640/format:webp/1*fGuU_v7JoXuG55HW9F_2kQ.jpeg",height = "80px"),
                              tags$p("here stores the coefficients/weights of the input features x and is of the exact same dimensionality as x."), 
                              tags$p("With single input and output variable, the method is called simple linear regression while with multiple inputs/features, its called multiple linear regression. For both, our goal would be to find the best fitting line that minimizes the sum of squared errors (SSE) or mean squared error (MSE) between our target variable (y) and our predicted output across all samples."),
                              tags$img(src = "https://miro.medium.com/v2/resize:fit:640/format:webp/1*mgQFzhnbZaQEyVhJRbp7cw.jpeg", width = "300px", height = "100px")
                            ),
                            tags$blockquote(tags$b("First simple linear regression model:", style = "color:#00008B;")),
                            tags$div(
                              tags$p("In a single regression model, there is only one independent variable. The goal of the analysis is to create a model that can predict the value of the dependent variable based on the value of the independent variable."), 
                              tags$p("For example, let's say you're interested in predicting a person's weight based on their height. You could use a single regression model to establish the relationship between height and weight, and then use that model to make predictions about a person's weight based on their height."), 
                              tags$p("To create a single regression model, you need a dataset that includes both the dependent variable (in this case, weight) and the independent variable (in this case, height) for a group of individuals.")
                            ),
                            tags$img(src = "https://editor.analyticsvidhya.com/uploads/56595Screenshot%20(51).png",height = "300px"),
                            tags$blockquote(tags$b("Steps to generate a simple linear model", style = "color:#00008B;")),
                            tags$div(
                              tags$p(tags$b("First: run app")),
                              tags$p(tags$b("Second: Browse for a file in your pc")), 
                              tags$p(tags$b("Third: Select x (independent variable)")),
                              tags$p(tags$b("Fourth: Select y (dependent variable)")),
                              tags$p(tags$b("Finally: press fit model button"))
                            ),
                            tags$div(
                              tags$p("Following these steps the model will generate the equation of the fitted model(estimator for B0 and B1), a scatterplot which explain the fitted model and also some important calculations."), 
                              tags$p("Calculations as: R^2 , r, sxx, sxy, syy, ANOVA table, hypothesis testing and confidence interval(default 95%) for intercept(B0), slope(B1), sigma, mean response and new observation")
                            ),
                            tags$b("Let's explain what are these calculations :)", style = "color:#A52A2A;"),
                            tags$blockquote(tags$b("First coefficients (B0 & B1):", style = "color:#00008B;")),
                            tags$div(
                              tags$p("In a simple regression model, the intercept (b0) and slope (b1) are two important parameters that help us understand the relationship between two variables(x,y). The intercept (b0) represents the starting point of the regression line or the point at which the regression line intersects the y-axis."), 
                              tags$p("The slope (b1) represents the change in the dependent variable (y) for a one-unit change in the independent variable (x). It tells us how much the dependent variable changes on average for each unit increase in the independent variable."),
                              tags$p("we need to find the parameters/coefficients for that best fit line.  If you want to calculate the regression line by hand, it uses a slightly scary formula to find the slope 'B1' and line intercept 'B0'."),
                              tags$img(src = "https://miro.medium.com/v2/resize:fit:1400/format:webp/1*eGsfg40-byoBgD53pFnAgw.jpeg", height = "300px")
                            ),
                            
                            tags$blockquote(tags$b("Second ANOVA table:", style = "color:#00008B;")),
                            tags$div(
                              tags$p("Analysis of Variance (ANOVA) consists of calculations that provide information about levels of variability within a regression model and form a basis for tests of significance."), 
                              tags$p("The basic regression line concept, DATA = FIT + RESIDUAL. The first term is the total variation in the response y, the second term is the variation in mean response, and the third term is the residual value. Squaring each of these terms and adding over all of the n observations gives the equation  SST = SSR + SSE, where SS is notation for sum of squares and T, R, and E are notation for total, regression, and error, respectively."), 
                              
                              tags$p("The first term is the total variation in the response y, the second term is the variation in mean response, and the third term is the residual value. "),
                              tags$p("Squaring each of these terms and adding over all of the n observations gives the equation SST = SSR + SSE, where SS is notation for sum of squares and T, R, and E are notation for total, regression, and error, respectively.") ,
                              tags$p("The sample variance = SST/DFT, the total sum of squares divided by the total degrees of freedom (DFT).") ,
                              tags$p("For simple linear regression, the MSR (mean square regression) = SSR/DFR(1), since the simple linear regression model has one explanatory variable x.") ,
                              tags$p("The corresponding MSE (mean square error) = SSE/DFE, the estimate of the variance about the population regression line^2."),
                              tags$p("The F column provides a statistic for testing the hypothesis. The test statistic is the ratio MSM/MSE, the mean square model term divided
by the mean square error term.  When the MSM term is large relative to the MSE term, then the ratio is large and there is evidence against the null hypothesis."),
                              tags$p("ANOVA table helps to determine whether there is a significant relationship between two variables or not. The table compares the variance explained by the regression model with the variance that cannot be explained by it (residual variance). The F-ratio obtained from this comparison can be used to test whether there is a significant relationship between these variables or not.")
                            ),
                            tags$blockquote(tags$b("Third hypothesis testing:", style = "color:#00008B;")),
                            tags$div(
                              tags$p("Hypothesis testing of the slope (B1) in simple linear regression is a statistical method used to determine whether there is a significant relationship between the independent variable and the dependent variable."), 
                              tags$p("Hypothesis testing of the slope (B1) involves formulating a null hypothesis, estimating the slope of the regression line, calculating a test statistic, and comparing the test statistic to a critical value to determine whether to reject or fail to reject the null hypothesis. The results of hypothesis testing can provide insights into the relationship between the variables and help guide decision-making.")
                            ),
                            tags$blockquote(tags$b("Fourth confidence interval:", style = "color:#00008B;")),
                            tags$div(
                              tags$p("The regression model estimates the slope , intercept, sigma, mean response and new observation, however, the estimated values are not exact, and they may vary if we collect a different sample of data."), 
                              tags$p("Therefore, we need to know how confident we can be that these estimated values are close to the true values of slope and intercept in the population."),
                              tags$p("This is where the confidence interval comes in. It is a range of values that we can be reasonably confident will contain the true value of the population parameter. We provide you with a bar which you can use to choose any percentage of your CI :)")
                            ),
                            tags$blockquote(tags$b("Finally R-squared and r:", style = "color:#00008B;")),
                            tags$div(
                              tags$p("R-squared and small r are both measures of the strength of the relationship between two variables in a regression analysis, but they have different interpretations and uses."), 
                              tags$p("The coefficient of determination, also known as R-squared, is a measure of how well a simple regression model fits a set of data points."), 
                              tags$p("The coefficient of determination is a number between 0 and 1. A low R^2 value means that the regression line does not fit the data well , while A high R^2 value indicates that the regression line fits the data points. In other words, the closer the coefficient of determination is to 1, the better the regression line fits the data."), 
                              tags$p("It tells you how much of the variation in the dependent variable (Y) can be explained by the independent variable (X) in the model."),
                              tags$p("Small r (r) is a correlation coefficient that measures the strength and direction of the linear relationship between two variables. It also ranges from -1 to 1, with higher absolute values indicating a stronger relationship. Unlike R2, which is specific to regression analysis, r can be used to measure relationships between any two continuous variables.") 
                            ),
                            tags$blockquote(tags$b("Second multiple linear regression model:", style = "color:#00008B;")),
                            tags$div(
                              tags$p("In multiple linear regression, there are multiple independent variables that are used to predict the value of a dependent variable. The goal of the analysis is to create a model that can predict the value of the dependent variable based on the values of the independent variables."), 
                              tags$p("For example, let's say you're interested in predicting a person's income based on their level of education and years of work experience. You could use a multiple regression model to establish the relationship between income and both education level and work experience, and then use that model to make predictions about a person's income based on their education level and work experience."), 
                              tags$p("To create a multiple regression model, you need a dataset that includes both the dependent variable (in this case, income) and multiple independent variables (in this case, education level and work experience) for a group of individuals. Multiple regression models can provide insights into the relationships between multiple variables and can be used to make more accurate predictions than single regression models.")
                            ),
                            tags$blockquote(tags$b("Note that: ", style = "color:#00008B;")),
                            tags$div(
                              tags$p(tags$b("The main difference between simple and multiple linear regression in coding is the number of independent variables used to predict the dependent variable. Simple linear regression uses only one independent variable, while multiple linear regression uses two or more independent variables.")),
                              tags$p(tags$b("Also simple linear regression calculations are so easy to implement but multiple linear regression is more complex because it envolve computer vision which means we use matrices in our implementation")), 
                              tags$p(tags$b("But this is our issue to handle you just need to click and try our model easily :)"))
                            ),
                            tags$blockquote(tags$b("Steps to generate a multiple linear model", style = "color:#00008B;")),
                            tags$div(
                              tags$p(tags$b("First: run app")),
                              tags$p(tags$b("Second: Browse for a file in your pc")), 
                              tags$p(tags$b("Third: Select (n)x (independent variable)")),
                              tags$p(tags$b("Fourth: Select y (dependent variable)")),
                              tags$p(tags$b("Finally: press fit model button"))
                            ),
                            tags$div(
                              tags$p("Following these steps the model will generate the equation of the fitted model(estimator for B0 and B(k)), a scatterplot which explain the fitted model and also some important calculations."), 
                              tags$p("Calculations as: R^2 , r, sxx, sxy, syy, ANOVA table, hypothesis testing and confidence interval(default 95%) for intercept(B0), slope(B1), sigma, mean response and new observation")
                            ),
                            tags$b("Let's explain what are these calculations :)", style = "color:#A52A2A;"),
                            tags$div(
                              tags$p("In a multiple regression model, there is only very small difference in explanation than single that a multiple regression model involves calculating multiple regression coefficients (B values) instead of just (B0 or B1) in a single regression model."), 
                              tags$p("But in general most of the explanation of the functions likr anova table and hypothesis testing of the model is the same.")
                            ),
                            tags$blockquote(tags$b("Adjusted R-squared: ", style = "color:#00008B;")),
                            tags$div(
                              tags$p("R-squared is a statistical measure that represents the proportion of variance in the dependent variable that is explained by the independent variables in a regression model. However, R-squared has a tendency to increase as more independent variables are added to the model, even if those variables don't actually improve the model's predictive power. To address this issue, adjusted R-squared (adj) is used in multiple regression models."), 
                              tags$p("Adjusted R-squared takes into account the number of independent variables used in the model, penalizing the addition of unnecessary variables that do not improve the model's overall fit. This results in a more accurate representation of the true explanatory power of the model."), 
                              tags$p("The difference between R^2 and R^2 adj is that R^2 adj is adjusted for the number of independent variables in the model, while R^2 is not. R^2 adj is always lower than R^2, because it accounts for the potential overfitting that can occur when adding more independent variables."), 
                              tags$p("In multiple linear regression, we calculate adjusted R-squared instead of R-squared because it provides a more reliable measure of the model's explanatory power. Using R^2 alone can lead to overestimating the model's accuracy, which can result in poor predictions and unreliable insights. By contrast, adjusted R-squared can help us to identify which independent variables are truly contributing to the model's predictive power, allowing us to build more effective models and make more accurate predictions.")
                            ),
                            tags$blockquote(tags$b("Normal Equation: ", style = "color:#00008B;")),
                            tags$div(
                              tags$p("If we take a residual vector as e =XB - y, then cost function/sum of squared residuals in a vector form will be :"), 
                              tags$img(src = "https://miro.medium.com/v2/resize:fit:1400/format:webp/1*E925ebkvI2mMscur08DThA.jpeg", height = "120px"),
                              tags$p("Now to find the B that minimizes the sum of squared residuals, we need to take the derivative of cost function above with respect to B."), 
                              tags$img(src = "https://miro.medium.com/v2/resize:fit:1270/format:webp/1*xe2QOzhzbZAcVaxYs0eSlg.jpeg", height = "200px")
                            ),
                            tags$blockquote(tags$b("Residual Analysis", style = "color:#00008B;")),
                            tags$b("We can say that residual analysis is the most important step after fiting a model."),
                            tags$b("How can you know that our model is working well? of course it's important that you trust us :) but we can also provide you with evidence that we are on the right route."),
                            tags$div(
                              tags$p("Residual analysis is a technique used to evaluate the fit of a statistical model, such as a linear regression model. After fitting a model, we can use residual analysis to check whether the assumptions of the model are met and whether the model is a good fit for the data."), 
                              tags$p("The primary goal of residual analysis is to check whether the residuals are normally distributed and have constant variance. In a well-fitted model, the residuals should be normally distributed with a mean of zero and constant variance, and there should be no pattern in the residuals."), 
                              tags$p("In the residual plot, if the residuals are randomly scattered around zero with no pattern, then it indicates that the model is a good fit for the data. However, if the residuals have a pattern (such as a U-shape or a curve), it suggests that the modelmay not be a good fit for the data and that there may be some other factors influencing the dependent variable that are not accounted for in the model.")
                            ),
                            tags$img(src = "https://www.researchgate.net/publication/322832910/figure/fig4/AS:609092750041088@1522230436532/The-scatterplot-of-standardized-residuals-against-predicted-values.png", height = "300px"),
                            br(),
                            br(),
                            br(),
                            
                            radioButtons("rb", "pls provide us with your opinion on our model:",
                                         choiceNames = list(
                                           icon("smile"),
                                           icon("angry"),
                                           icon("sad-tear")
                                         ),
                                         choiceValues = list("happy", "angry", "sad"),
                            ),
                            actionButton("click", "send!"),
                            br(),
                            br()
                            
                          )),
                 
                 
                 ##! SIMPLE UI
                 tabPanel(title = "Simple",
                          fluidPage(
                            sidebarLayout(
                              
                              ##! SIMPLE SIDE BAR
                              sidebarPanel(
                                
                                # select file
                                fileInput("select_data", h4("Select Data File")),
                                # select x and y
                                selectInput("xselect", h4("Select x"), choices = names(df), selected = 1),
                                selectInput("yselect", h4("Select y"), choices = names(df), selected = 1),
                                # plot x and y
                                plotOutput('plotxy'),
                                br(),
                                
                                # sigma squared input
                                tags$div(id="divSigma2", numericInput("sigma2",label = "Sigma Squared (if known)",value=NULL,step=0.1)),
                                # sigma unknown checkbox
                                checkboxInput("checkSigma2", "Calculate Variance from data (sigma unknown)", FALSE),
                                br(),
                                br(),
                                
                                # anova checkbox
                                checkboxInput("checkAnova", strong("Construct ANOVA Table"), TRUE),
                                # anova ci slider
                                tags$div(id="divAnova", sliderInput("confAnova", label = "ANOVA Confidence Level", min = 0, max = 100, value = 95)),
                                br(),
                                
                                # b0 ci checkbox
                                checkboxInput("checkB0", strong("CI for B0"), TRUE),
                                # b0 ci slider
                                tags$div(id="divB0", sliderInput("confB0", label = "B0 Confidence Level", min = 0, max = 100, value = 95)),
                                br(),
                                
                                # b1 ci checkbox
                                checkboxInput("checkB1", strong("CI for B1"), TRUE),
                                # b1 ci slider
                                tags$div(id="divB1", sliderInput("confB1", label = "B1 Confidence Level", min = 0, max = 100, value = 95)),
                                br(),
                                
                                # sigma square ci checkbox
                                checkboxInput("checkSigma2CI", strong("CI for Sigma Squared"), TRUE),
                                # sigma square ci slider
                                tags$div(id="divSigma2CI", sliderInput("confSigma2", label = "Sigma Squared Confidence Level", min = 0, max = 100, value = 95)),
                                br(),
                                
                                
                                # mean response ci checkbox
                                checkboxInput("checkMeanResp", strong("CI for Mean Response.."), TRUE),
                                tags$div(id="divMeanResp", 
                                         sliderInput("confMeanResp", label = "Mean Response Confidence Level", min = 0, max = 100, value = 95),
                                         numericInput("x0mean",label = ".. at x0 = ",value=0,step=0.1)),
                                br(),
                                
                                # new observation ci checkbox
                                checkboxInput("checkNewObs", strong("CI for New Observation.."), TRUE),
                                # new observation ci slider and x0 value input 
                                tags$div(id="divNewObs", 
                                         sliderInput("confNewObs", label = "New Observation Confidence Level", min = 0, max = 100, value = 95),
                                         numericInput("x0new",label = ".. at x0 = ",value=0,step=0.1)),
                                br(),
                                br(),
                                
                                # fit model button
                                actionButton("reg", label = "Fit Regression Model"),
                                
                                width = 4
                              ),
                              
                              ##! SIMPLE MAIN PANEL
                              mainPanel(
                                
                                # dataframe
                                tableOutput('table'),
                                em(textOutput("text")),
                                
                                width = 8,
                                style = "overflow-y: scroll;"
                              ),
                              
                            ))),
                 
                 ##! MULTIPLE UI
                 tabPanel(title = "Multiple", fluidPage(
                   sidebarLayout(
                     
                     ##! MULTIPLE SIDE BAR
                     sidebarPanel(
                       # select file
                       fileInput("select_data2", h4("Select Data File")),
                       
                       # x checkboxes
                       uiOutput("checkboxes"),
                       # select y
                       selectInput(inputId = "ycolumn_select",
                                   label = "Select y column:",
                                   choices = NULL, selected = 1),
                       br(),
                       
                       # anova checkbox
                       checkboxInput("checkAnova2", strong("Construct ANOVA Table"), TRUE),
                       # anova ci slider
                       tags$div(id="divAnova2", sliderInput("confAnova2", label = "ANOVA Confidence Level", min = 0, max = 100, value = 95)),
                       br(),
                       br(),
                       
                       # beta checkboxes
                       uiOutput("beta"),
                       # Slider input for B CI alpha
                       sliderInput("alpha", "Choose B CI", min = 0, max = 100, value = 95),
                       br(),
                       br(),
                       
                       # mean response checkbox
                       checkboxInput("checkMeanResp2", strong("CI for Mean Response.."), TRUE),
                       # mean response ci and x0 input
                       tags$div(id="divMeanResp2",
                         sliderInput("confMeanResp2", label = "Mean Response Confidence Level", min = 0, max = 100, value = 95),
                         textInput("x_node", "Enter the matrix value of x_node in the format 'x1,x2,x3,...':", value = "1,2,3")),
                       br(),
                       
                       # new observation checkbox
                       checkboxInput("checkNewObs2", strong("CI for New Observation.."), TRUE),
                       # new observation ci and x0 input
                       tags$div(id="divNewObs2", 
                         sliderInput("confNewObs2", label =" New Observation Confidence Level", min = 0, max = 100, value = 95),
                         textInput("x_node_new", "Enter the matrix value of x_node (for new observation) in the format 'x1,x2,x3,...':", value = "1,2,3")),
                         
                       
                       
                       # fit model button
                       actionButton("reg2", label = "Fit Regression Model "),
                       
                       width = 4
                     ),
                     
                     ##! MULTIPLE MAIN PANEL
                     mainPanel(
                       
                       # dataframe
                       tableOutput('table2'),
                       em(textOutput("text2")),
                       
                       width = 8,
                       style = "overflow-y: scroll;"
                     ))
                   
                 )),
                 inverse = F)
