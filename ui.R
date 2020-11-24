# Revision of RCS_Data application V2020 A. Bickford November 2020

library(plotly)
library(shiny)

source("setup.R")  

function(req) {
  htmlTemplate("index.html",
               area=selectInput("area","Select your Area:", choices = unique(areas$Name)),               
               permits=tableOutput("permits"),
               co=tableOutput("co"),
               demo=tableOutput("demo"),
               mobile=tableOutput("mobile")
               )
}

