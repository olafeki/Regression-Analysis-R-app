library(shiny)
library(shinyalert)
library(shinyjs)
library(ggplot2)
library(linreg)
library(cvreg)

source('reg_ui.R')
source('reg_server.R')
source('fit_model.R')

shinyApp(ui = ui, server = server)

