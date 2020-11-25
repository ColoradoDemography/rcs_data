library(plotly)
library(shiny)

source("setup.R")  

function(req) {
  htmlTemplate("index.html",
               area=selectInput("area","Select your Area:", choices = unique(areas$Name)),               
               contact_info=tableOutput("contact"),
               permits=tableOutput("permits"),
               co=tableOutput("co"),
               demo=tableOutput("demo"),
               mobile=tableOutput("mobile"),
               sdo_estimates=tableOutput("sdo"),
               census_estimates=tableOutput("census"),
               annexations=tableOutput("annex")
               )
}

