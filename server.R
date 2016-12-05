
library(plotly)
source("setup.R")

function(input, output, session) {

  id=reactive({as.numeric(filter(areas, Name==input$area)%>%
                              select(id))})
  
  output$contact=renderTable({
    contact%>%
      filter(id==id())%>%
      gather(Field, Current)}, 
    include.rownames=FALSE
  )
  
  output$permits=renderTable({ 
    bp%>%
      filter(id==id())%>%
      select(year:dec)},
    digits=0, 
    include.rownames=FALSE
    )
  
  output$co=renderTable({
    co%>%
      filter(id==id())%>%
      select(year:dec)},
    digits=0, 
    include.rownames=FALSE
  )

  output$demo=renderTable({
    demo%>%
      filter(id==id())%>%
      select(year:dec)},
    digits=0, 
    include.rownames=FALSE
  )

  output$mobile=renderTable({
    mobile%>%
      filter(id==id())%>%
      select(-id:-place)},
    digits=0, 
    include.rownames=FALSE
  )
  
  output$sdo=renderTable({
    sdo%>%
      filter(id==id())%>%
      mutate(PopulationChange=Population-lag(Population),
             HousingUnitChange=HousingUnits-lag(HousingUnits))%>%
      select(year, Population, HousingUnits, PopulationChange, HousingUnitChange)%>%
      filter(year<2015)},
                         digits = 0, 
    include.rownames=FALSE)

output$census=renderTable({
  census%>%
    filter(id==id())%>%
    mutate(PopulationChange=Population-lag(Population),
           HousingUnitChange=HousingUnits-lag(HousingUnits))%>%
    select(year, Population, HousingUnits, PopulationChange, HousingUnitChange)%>%
    filter(year<2015)},
  digits = 0, 
  include.rownames=FALSE)

output$annex=renderTable({
  annex%>%
    filter(id==id())%>%
    select(year, PopulationChange:GroupQuartersChange)%>%
    filter(year<2015)},
  digits = 0, 
  include.rownames=FALSE)

}
