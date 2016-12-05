library(readxl)
library(tidyr)
library(dplyr)
library(stringr)

bp=read_excel("construction_data.xlsx", sheet = 1)%>%
  select(-Btot2010:-PlaceFIPS)%>%
  gather(variable, value, -county:-place)%>%
  filter(place!="00000")%>%
  mutate(month=str_sub(str_sub(variable, 1,4),2,4),
         year=as.integer(paste0("20", str_sub(variable, -2,-1))),
         county=as.numeric(county),
         place=as.numeric(place), 
         id=as.numeric(paste0(county,place)))%>%
  select(id, county, place, month, year, permits=value)%>%
  filter(year<2016)%>%
  spread(month, permits)

co=read_excel("construction_data.xlsx", sheet = 2)%>%
  select(-C1011:-C2021)%>%
  rename(county=CountyFIPS, place=PlaceFIPS)%>%
  gather(variable, value, -county:-place)%>%
  mutate(month=str_sub(str_sub(variable, 1,4),2,4),
         year=as.integer(paste0("20", str_sub(variable, -2,-1))),
         county=as.numeric(county),
         place=as.numeric(place), 
         id=as.numeric(paste0(county,place)))%>%
  select(id,county, place, month, year, certs=value)%>%
  filter(year<2016)%>%
  spread(month, certs)


demo=read_excel("construction_data.xlsx", sheet = 3)%>%
  select(-D1011:-D2021)%>%
  rename(county=CountyFIPS, place=PlaceFIPS)%>%
  gather(variable, value, -county:-place)%>%
  mutate(month=str_sub(str_sub(variable, 1,4),2,4),
         year=as.integer(paste0("20", str_sub(variable, -2,-1))),
         county=as.numeric(county),
         place=as.numeric(place), 
         id=as.numeric(paste0(county,place)))%>%
  select(id,county, place, month, year, demo=value)%>%
  filter(year<2016)%>%
  spread(month, demo)

mobile=read_excel("construction_data.xlsx", sheet = 4)%>%
  rename(county=CountyFIPS, place=PlaceFIPS)%>%
  gather(variable, value, -county:-place)%>%
  mutate(half_year=ifelse(str_sub(str_sub(variable, 4, 6), 1,1)=="j", "first", "second"),
         year=as.integer(paste0("20", str_sub(variable, -2,-1))),
         county=as.numeric(county),
         place=as.numeric(place), 
         id=as.numeric(paste0(county,place)))%>%
  select(id, county, place, half_year, year, mobile=value)%>%
  filter(year<2016)%>%
  spread(half_year, mobile)

contact=read.csv("contact_info.csv", stringsAsFactors = FALSE)%>%
  filter(Plac!=0)%>% 
  select(county=CouNumber, place=Plac, Area, FirstName=FIRST_NAME, MiddleName=MIDDLE_NAME, LastName=LAST_NAME, Title=TITLE, 
         Email=EMAIL_ADDRESS, Address=MAIL_ADDRESS, City=MAIL_CITY,ZipCode=MAIL_ZIP, Phone=WORK_PHONE, Fax=FAX)%>%
  mutate(id=as.numeric(paste0(county,place)))

areas=read.csv("RCS County Place names.csv", stringsAsFactors = FALSE)%>%
  mutate(id=as.numeric(paste0(countyfips,placefips)))
