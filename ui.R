library(plotly)
library(shiny)

source("setup.R")  


function(req) {
  htmlTemplate("index.html",
               area=selectInput("area","Select your Area:", choices = unique(areas$Name), selected = 'Aguilar in Las Animas'),               contacts=renderTable("contacts"),
               contact_info=renderTable("contact"),
               permits=renderTable("permits"),
               co=renderTable("co"),
               demo=renderTable("demo"),
               mobile=renderTable("mobile"),
               sdo_estimates=renderTable("sdo"),
               census_estimates=renderTable("census"),
               annexations=renderTable("annex")
               )
}

