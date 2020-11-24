
library(plotly)
source("setup.R")

function(input, output, session) {
  observeEvent(input$area, {
 
    plNm <- reactive(input$area)
    plName <- as.character(isolate(plNm()))
    
  idSel = areas %>% filter( Name== plName ) %>%  select(id)
  
  
  
   output$permits=renderTable({ 
    bp%>%
      filter(id==idSel$id)%>%
      select(year:December)},
    digits=0, 
    include.rownames=FALSE
    )
  
  output$co=renderTable({
    co%>%
      filter(id==idSel$id)%>%
      select(year:December)},
    digits=0, 
    include.rownames=FALSE
  )

  output$demo=renderTable({
    demo%>%
      filter(id==idSel$id)%>%
      select(year:December)},
    digits=0, 
    include.rownames=FALSE
  )

  output$mobile=renderTable({
    mobile%>%
      filter(id==idSel$id)%>%
      select(year, JantoJun, JultoDec)},
    digits=0, 
    include.rownames=FALSE
  )
 

})
}
