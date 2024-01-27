df = NULL
df2 = NULL
x = NULL
y = NULL


server <- function(input, output, session){
  
  ##! HELP SERVER
  observeEvent(input$click, {
    shinyalert("Thank you for your feedback!")
  })
  
  
  ##! SIMPLE SERVER
  
  # observe when any data file is uploaded
  observeEvent(input$select_data, {
    
    # get file location
    loc = (input$select_data)[['datapath']]
    
    tempdf = NULL
    
    # try to read data, show error notification if invalid file type
    tryCatch(
      expr={
        tempdf <- read_data(loc)
      },
      error=function(e) {
        showNotification(paste("Error Reading Data.",e), type='error',duration = 10)
      }
    )
    
    # if read_data didn't return a dataframe, stop
    if(is.null(tempdf)){
      return()
    }
    
    df <<- tempdf
    
    # update x and y choices with data column names
    updateSelectInput(session, "xselect",choices = names(df))
    updateSelectInput(session, "yselect",choices = names(df))
    
    # show first 70 rows
    n = 70
    if(nrow(df) < 70){
      n = nrow(df)
    }
    output$text <- renderText(paste("\tshowing ", n," of ", nrow(df), " rows"))
    output$table <- renderTable(head(df,70))
    
    # plot x and y to help pick the regression features
    output$plotxy <- renderPlot({
      xtemp = input$xselect
      ytemp = input$yselect
      plot(x=df[[xtemp]],y=df[[ytemp]],xlab=xtemp,ylab=ytemp)})
  })
  
  
  # observe when 'sigma2 unknown' checkbox is checked, and hide sigma2 input box
  observeEvent(input$checkSigma2, {
    
    checked = input$checkSigma2
    
    if(!input$checkSigma2){
      showElement(id="divSigma2")
    } else {
      hideElement(id="divSigma2")
    }
    
  })
  
  # observe when 'calculate anova' checkbox is checked, and show anova confidence level slider
  observeEvent(input$checkAnova, {
    
    checked = input$checkAnova
    
    if(checked){
      showElement(id="divAnova")
    } else {
      hideElement(id="divAnova")
    }
    
  })
  
  # observe when 'calculate B0 CI' checkbox is checked, and show B0 confidence level slider
  observeEvent(input$checkB0, {
    
    checked = input$checkB0
    
    if(checked){
      showElement(id="divB0")
    } else {
      hideElement(id="divB0")
    }
    
  })
  
  # observe when 'calculate B1 CI' checkbox is checked, and show B1 confidence level slider
  observeEvent(input$checkB1, {
    
    checked = input$checkB1
    
    if(checked){
      showElement(id="divB1")
    } else {
      hideElement(id="divB1")
    }
    
  })
  
  # observe when 'calculate sigma2 CI' checkbox is checked, and show sigma2 confidence level slider
  observeEvent(input$checkSigma2CI, {
    
    checked = input$checkSigma2CI
    
    if(checked){
      showElement(id="divSigma2CI")
    } else {
      hideElement(id="divSigma2CI")
    }
    
  })
  
  # observe when 'calculate mean response CI' checkbox is checked, and show mean response confidence level slider
  observeEvent(input$checkMeanResp, {
    
    checked = input$checkMeanResp
    
    if(checked){
      showElement(id="divMeanResp")
    } else {
      hideElement(id="divMeanResp")
    }
    
  })
  
  # observe when 'calculate new observation CI' checkbox is checked, and show new observation confidence level slider
  observeEvent(input$checkNewObs, {
    
    checked = input$checkNewObs
    
    if(checked){
      showElement(id="divNewObs")
    } else {
      hideElement(id="divNewObs")
    }
    
  })
  
  # observe when 'fit regression model' button is clicked
  observeEvent(input$reg, {
    
    # check if user selected data
    if(is.null(df)){
      showNotification("Please Select Data File First", type='error')
      return()
    }
    
    # get selected x and y col names
    x <<- input$xselect
    y <<- input$yselect
    
    # check if selected columns are numeric
    if(!(is.numeric(df[[x]]) & is.numeric(df[[y]]))){
      showNotification("X and Y must be numeric", type='error')
      return()
    }
    
    # check if sigma is known
    sigma2 = input$sigma2
    sigma2Known = !input$checkSigma2
    
    if(sigma2Known & is.na(sigma2)){
      sigma2Known = FALSE
      showNotification("No value provided for Sigma Squared. Estimate was calculated from data", type='warning')
    }
    
    
    # get boolean values for what the user wants to calculate
    calcAnova = input$checkAnova
    calcConfB1 = input$checkB1
    calcConfB0 = input$checkB0
    calcConfSigma2 = input$checkSigma2CI
    calcMeanResp = input$checkMeanResp
    calcNewObs = input$checkNewObs
    
    
    # create data frame with x and y features
    regData = data.frame(x=df[[x]],y=df[[y]])
    
    # remove NAs from data to avoid errors
    tryCatch(
      expr={
        na.fail(regData)
      },
      error=function(e) {
        regData <<- na.exclude(regData)
        showNotification("Rows with NA values will be ignored while fitting the model", type='warning')
      }
    )
    
    model = fit_model_linreg(regData, sigma2 = input$sigma2, anova = calcAnova, confAnova = input$confAnova,
                             calcCIB0 = calcConfB0, confB0 = input$confB0, calcCIB1 = calcConfB1, confB1 = input$confB1,
                             calcCISigma2 = calcConfSigma2, confSigma2 = input$confSigma2,
                             calcCIMeanResp = calcMeanResp, confMeanResp = input$confMeanResp, x0Mean = input$x0mean,
                             calcCINewObs = calcNewObs, confNewObs = input$confNewObs, x0New = input$x0new)
    
    
    # print model to user
    if(model[['b0']] < 0){
      sign = ''
    }
    else {
      sign = '+'
    }
    
    output$title <- renderText(
      paste('Fitted Model: Y = ', model[['b1']], 'X ', sign, ' ', model[['b0']])
    )
    
    # plot fitted model
    output$plotModel <- renderPlot({
      plot(x=df[[x]],y=df[[y]],xlab=x,ylab=y)
      abline(a=model[['b0']], b=model[['b1']],col='red2',lwd=3)
    })
    
    # print correlation coefficient (to determine model efficiency) and other calculations
    output$calc <- renderText(
      paste("R2 = ", model[['r2']], " <br> <b> [Model covers ", model[['r2']]*100,"% of the data] </b> <br> ", 
            "r = ", model[['r']], " <br><br> Sxx = ", linreg::calculateSXX(regData), " <br> Sxy = ",
            linreg::calculateSXY(regData), " <br> Syy = ", linreg::calculateSYY(regData))
    )
    
    # print anova table and anova result
    output$anovaTitle <- renderText({
      if(calcAnova){
        paste('Anova Table with ', input$confAnova, '% CI' )
      }
    })
    
    output$anovaResult1 <- renderDataTable({
      if(calcAnova){
        cbind(rownames(model[['anova_table']]), model[['anova_table']])
      }
    }, options = list(
      info = 0,
      searching = 0,
      ordering = 0,
      paging = 0,
      autoWidth=0)
    )
    
    output$anovaResult2 <- renderText({
      if(calcAnova){
        paste("Fc = ", model[['fc']], "<br>", 
              ifelse(model[['reject_h0']],'Reject H0 <br> B1 != 0','Do not reject H0 <br> B1 = 0'))
      }
    })
    
    
    # print b0 CI
    output$b0CI <- renderText({
      if(calcConfB0){
        paste(model[['b0_ci']])
      }
    })
    
    # print b1 CI
    output$b1CI <- renderText({
      if(calcConfB1){
        paste(model[['b1_ci']])
      }
    })
    
    # calculate sigma2 CI
    output$Sigma2CI <- renderText({
      if(calcConfSigma2){
        paste(model[['sigma2_ci']])
      }
    })
    
    # calculate mean response CI
    output$meanRespCI <- renderText({
      if(calcMeanResp){
        paste(model[['mean_response_ci']])
      }
    })
    
    # calculate new observation CI
    output$newObsCI <- renderText({
      if(calcNewObs){
        paste(model[['new_observation_ci']])
      }
    })
    
    
    # show all previous calculations in new window
    showModal(
      modalDialog(
        div (
          h4(strong(textOutput('title'))),
          plotOutput('plotModel'),
          br(),
          htmlOutput('calc'),
          br(),
          strong(textOutput('anovaTitle')),
          dataTableOutput('anovaResult1'),
          htmlOutput('anovaResult2'),
          br(),
          textOutput('b0CI'),
          textOutput('b1CI'),
          textOutput('Sigma2CI'),
          br(),
          textOutput('meanRespCI'),
          textOutput('newObsCI'),
          
          style = "font-size:110%"
        ), size = "l", easyClose = TRUE
      )
    )
    
  })
  
  
  ##! MULTIPLE SERVER
  
  
  # observe when any data file is uploaded
  observeEvent(input$select_data2, {
    
    # get file location
    loc2 = (input$select_data2)[['datapath']]
    
    tempdf2 = NULL
    
    # try to read data, show error notification if invalid file type
    tryCatch(
      expr={
        tempdf2 <- read_data(loc2)
      },
      error=function(e) {
        showNotification(paste("Error Reading Data.",e), type='error',duration = 10)
      }
    )
    
    # if read_data didn't return a dataframe, stop
    if(is.null(tempdf2)){
      return()
    }
    df2 <<- tempdf2
    
    
    # show first 70 rows
    n = 70
    if(nrow(df2) < 70){
      n = nrow(df2)
    }

    output$text2 <- renderText(paste("\tshowing ", n," of ", nrow(df2), " rows"))
    
    output$table2 <- renderTable(head(df2,70))
    #update y selected matnsi4
    
    updateSelectInput(session, "ycolumn_select",choices = names(df2))
    
    
    data<-reactive(df2 <<- tempdf2)
    
    output$checkboxes <- renderUI({
      num_cols <- ncol(data())
      checkboxGroupInput("cols", "features:", choices = colnames(data()))
    })
    
    y<<-input$ycolumn_select 
    
    
    
    
  })
  
  observeEvent(input$cols,{
    output$beta <- renderUI({
      ch = paste0('b', seq(0, length(input$cols)))
      checkboxGroupInput("index", "Choose Beta",choices = ch) 
    })
  })
  
  
  observeEvent(input$x_node, {
    numbers <- c(1)
    # Convert the input to a character string
    substrings <- strsplit(input$x_node, ",")[[1]]           
    
    # Split the input string into a vector of substrings
    substrings1 <- c(substrings)
    
    # Convert each substring to a numeric value
    numbers <<- c(numbers, as.numeric(substrings1))
  })
  
  observeEvent(input$x_node_new, {
    numbers_new <- c(1)
    # Convert the input to a character string
    substrings_new=strsplit(input$x_node_new, ",")[[1]]           
    
    # Split the input string into a vector of substrings
    substrings1_new=c(substrings_new)
    
    # Convert each substring to a numeric value
    numbers_new <<- c(numbers_new,as.numeric(substrings1_new))
  })
  
  
  observeEvent(input$reg2, {
    
    # check if user selected data
    if(is.null(df2)){
      showNotification("Please Select Data File First", type='error')
      return()
    }
    
    if(length(input$cols)==0){
      showNotification("Please Select At Least One X feature", type='error')
      return()
    }
    
    allNum = TRUE
    for(i in input$cols){
      if(!is.numeric(df2[[i]])){
        allNum = FALSE
        break
      }
    }
    if(!is.numeric(df2[[input$ycolumn_select]])){
      allNum = FALSE
    }
    
    if(!(allNum)){
      showNotification("X and Y must be numeric", type='error')
      return()
    }
    
    if((length(numbers) != length(input$cols)+1)&input$checkMeanResp2){
      showNotification("Invalid X0 Values For Mean Response. Wrong Vector Length.", type='error')
      return()
    }
    
    if((length(numbers_new) != length(input$cols)+1)&input$checkNewObs2){
      showNotification("Invalid X0 Values For New Observation. Wrong Vector Length.", type='error')
      return()
    }
    
    if(!is.numeric(numbers)&input$checkMeanResp2){
      showNotification("Invalid X0 Values For Mean Response. Enter Numbers Only.", type='error')
      return()
    }
    
    if(!is.numeric(numbers_new)&input$checkNewObs2){
      showNotification("Invalid X0 Values For New Observation. Enter Numbers Only.", type='error')
      return()
    }
    
    #   data <- reactive({
    #    if (is.null(df2[[input$cols]]) ){
    #      return(numeric(0)) # Return an empty numeric vector if df2 is NULL
    #    } else {
    #      df2[, input$cols, drop = FALSE] # Subset the data frame based on the selected columns
    #    }
    #   })
    
    # create data frame for x values and another for y values TO SELECT THEM
    
    data<-reactive({
      df2[,input$cols , drop =FALSE ]
    })
    
    y<<-df2[[input$ycolumn_select]]
    
    xregData = data()
    yregdata=data.frame(y)
    
    index <- as.numeric(substr(input$index,2,2))
    
    model2 = fit_model_cvreg(xregData, yregdata, anova = input$checkAnova2, confAnova = input$confAnova2,
                             confB = input$alpha, indexB=index,confMean=input$confMeanResp2, numbers=numbers,
                             calcCIMeanResp = input$checkMeanResp2, calcCINewObs = input$checkNewObs2,
                             confNew=input$confNewObs2,numbers_new = numbers_new)
    
    
    output$mtitle <- renderText({
      paste('Y = ' , modelToString(model2[['B']]))
    })
    
    #print correlation coefficient (to determine model efficiency) and other calculations
    output$mcalc <- renderText(
      paste("R2 Adjusted = ", model2[['R2Adj']])
    )
    
    X=constructX(xregData)
    Y=constructY(yregdata)
    E=regular_error(X,Y)
    D=standard_error(X,Y,E=E,B=model2[['B']])
    R=student_error(X,Y,E=E,B=model2[['B']],inv_XT_X=model2[['Inv_XT_X']])
    
    plot_data = data.frame(
      Studentized_Residuals = R[,1],
      Regular_Residuals = E, 
      Standardized_Residuals = D[,1],
      Y_i = Y
    ) 
    
    output$residual1 <- renderPlot({
      
      ggplot(plot_data, aes(x = Y_i)) +
        geom_point(aes(y = Standardized_Residuals), color = "red") +
        ylab("Standardized Residuals (Di)") +
        xlab("Observation (Yi)") +
        ggtitle("Standardized Residual Analysis Plot") +
        theme(plot.title = element_text(hjust = 0.5))+
        geom_hline(yintercept = 3,size=1.5, linetype = "dashed", color = "orange") +
        geom_hline(yintercept = -3,size=1.5, linetype = "dashed", color = "orange")

    })
    
    output$residual2 <- renderPlot({
      
      ggplot(plot_data, aes(x = Y_i)) +
        geom_point(aes(y = Regular_Residuals, color = 'Regular Error'),show.legend = TRUE) +
        geom_point(aes(y = Standardized_Residuals, color = 'Standard Error'),show.legend = TRUE) +
        geom_point(aes(y = Studentized_Residuals, color = 'Student Error'),show.legend = TRUE) +
        geom_hline(yintercept = 3,size=1.5, linetype = "dashed", color = "orange") +
        geom_hline(yintercept = -3,size=1.5, linetype = "dashed", color = "orange") +
        ylab("Residuals") +
        xlab("Observation (Yi)") +
        ggtitle("Residual Analysis Plot") +
        theme(plot.title = element_text(hjust = 0.5))+
        scale_color_manual(
          name='Residuals',
          values=c('Regular Error'='blue', 'Standard Error'='red', 'Student Error'='green'))
      
      
    })
    
    
    
    output$xtxmatrix <- renderTable(model2[['XT_X']],digits=3,colnames=FALSE)
    output$xtxinvmatrix <- renderTable(model2[['Inv_XT_X']],digits=7,colnames=FALSE)
    
    # print anova table and anova result
    output$manovaTitle <- renderText({
      if(input$checkAnova2){
        paste('Anova Table with ', input$confAnova2, '% CI')
      }
    })
    
    output$manovaResult1 <- renderDataTable({
      if(input$checkAnova2){
        cbind(rownames(model2[['anova_table']]), model2[['anova_table']])
      }
    }, options = list(
      info = 0,
      searching = 0,
      ordering = 0,
      paging = 0,
      autoWidth=0)
    )
    
    output$manovaResult2 <- renderText({
      if(input$checkAnova2){
        paste("Fc = ", model2[['fc']], "<br>", 
              ifelse(model2[['reject_h0']],'Reject H0 <br> at least one of B != 0','Do not reject H0 <br> All B = 0'))
      }
    })
    
    
    output$ciB <- renderText({
      paste(model2[['ciB']], "<br>")
    })
    
    output$ciMean <- renderText({
      paste("<br><br>",model2[['ciMean']])
    })
    
    output$ciNew <- renderText({
      paste("<br>",model2[['ciNew']])
    })
    
    
    
    showModal(
      modalDialog(
        div (
          h3(strong(textOutput('mtitle'))),
          br(),
          plotOutput('residual1'),
          plotOutput('residual2'),
          htmlOutput('mcalc'),
          br(),
          h5(strong('XTX')),
          div(
            tableOutput('xtxmatrix'),
            style = "overflow-x: auto;"),
          br(),
          h5(strong('(XTX)-1')),
          div(
            tableOutput('xtxinvmatrix'),
            style = "overflow-x: auto;"),
          br(),
          br(),
          strong(textOutput('manovaTitle')),
          dataTableOutput('manovaResult1'),
          htmlOutput('manovaResult2'),
          htmlOutput('ciB'),
          htmlOutput('ciMean'),
          htmlOutput('ciNew'),
          style = "font-size:110%" ),
        size = "l", easyClose = TRUE
      )
    )
  })
  
  
  
  observeEvent(input$checkAnova2, {
    
    checked = input$checkAnova2
    
    if(checked){
      showElement(id="divAnova2")
    } else {
      hideElement(id="divAnova2")
    }
    
  })
  
  observeEvent(input$checkMeanResp2, {
    
    checked = input$checkMeanResp2
    
    if(checked){
      showElement(id="divMeanResp2")
    } else {
      hideElement(id="divMeanResp2")
    }
    
  })
  
  observeEvent(input$checkNewObs2, {
    
    checked = input$checkNewObs2
    
    if(checked){
      showElement(id="divNewObs2")
    } else {
      hideElement(id="divNewObs2")
    }
    
  })
  
  
}


# wl model 34an leh la2..
modelToString <- function(B){
  idx = 1:length(B)
  elements = c(B[1])
  elements = c(elements, paste0(B[-1],'X',idx))
  string = ''
  
  for(i in idx) {
    
    if(B[i] < 0 | i == 1){
      sign = ''
    }
    else {
      sign = '+'
    }
    string = paste(string, sign, elements[i])
    
  }
  return(string)
  
}