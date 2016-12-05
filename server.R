
library(plotly)
source("setup.R")

function(input, output, session) {

  id=reactive({filter(areas, Name==input$area)%>%
                              select(id)})
  
  output$contact=renderTable({
    contact%>%
      filter(id==id())%>%
      gather(Field, Current)
  })
  
  output$permits=renderTable({
    bp%>%
      filter(id==id()$id)%>%
      select(year:sep)
  })
  
  output$co=renderTable({
    id()
  })

    
}
