# Modification of RCS_Data application V20 A. Bickford 2020

library(tidyverse)
library(readxl)



bp <- read_excel("construction_data_long.xlsx", sheet = 1) %>%
  filter(placeFIPS !="00000") %>%
  mutate(county = countyFIPS,
         place=placeFIPS,
         id= paste0(county,place),
         permits = value) %>%
  select(id, county, place, month, year, permits)%>%
  spread(month, permits) %>%
  select(id, county, place, year, January, February, March, April, May,
             June, July, August, September, October, November, December)


co=read_excel("construction_data_long.xlsx", sheet = 2) %>%
  filter(placeFIPS !="00000") %>%
  mutate(county = countyFIPS,
         place=placeFIPS,
         id= paste0(county,place),
         certs = value) %>%
  select(id,county, place, month, year, certs) %>%
  spread(month, certs) %>%
  select(id, county, place, year, January, February, March, April, May,
         June, July, August, September, October, November, December)


demo=read_excel("construction_data_long.xlsx", sheet = 3) %>%
  filter(placeFIPS !="00000") %>%
  mutate(county = countyFIPS,
         place=placeFIPS,
         id= paste0(county,place),
         demo = value) %>%
  select(id,county, place, month, year, demo) %>%
  spread(month, demo) %>%
  select(id, county, place, year, January, February, March, April, May,
         June, July, August, September, October, November, December)


mobile=read_excel("construction_data_long.xlsx", sheet = 4) %>%
  filter(placeFIPS !="00000") %>%
  mutate(half_year = month,
         county = countyFIPS,
         place = placeFIPS,
         id = paste0(county,place),
         mobile = value)  %>%
  select(id, county, place, half_year, year, mobile)%>%
  spread(half_year, mobile) %>%
  select(id, county, place, year, JantoJun, JultoDec)


areas=read_excel("RCS County Place names.xlsx") %>%
  mutate(id= paste0(countyfips,placefips))


