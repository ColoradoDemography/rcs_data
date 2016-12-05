library(readxl)
library(tidyr)
library(dplyr)
library(stringr)
library(car)

bp=read_excel("construction_data.xlsx", sheet = 1)%>%
  select(-Btot2010:-PlaceFIPS)%>%
  gather(variable, value, -county:-place)%>%
  filter(place!="00000")%>%
  mutate(month=str_sub(str_sub(variable, 1,4),2,4),
         month=ordered(month, levels=c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec")),
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
         month=ordered(month, levels=c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec")),
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
         month=ordered(month, levels=c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec")),
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
  mutate(half_year=ifelse(str_sub(str_sub(variable, 4, 6), 1,1)=="j", "firstHalf", "secondHalf"),
         year=as.integer(paste0("20", str_sub(variable, -2,-1))),
         county=as.numeric(county),
         place=as.numeric(place), 
         id=as.numeric(paste0(county,place)))%>%
  select(id, county, place, half_year, year, mobile=value)%>%
  filter(year<2016)%>%
  spread(half_year, mobile)

contact=read.csv("contact_info.csv", stringsAsFactors = FALSE)%>%
  filter(PlaceFIPS!=0)%>% 
  select(county=CountyFIPS, place=PlaceFIPS, FirstName=FIRST_NAME, MiddleName=MIDDLE_NAME, LastName=LAST_NAME, Title=TITLE, 
         Email=EMAIL_ADDRESS, Address=MAIL_ADDRESS, City=MAIL_CITY,ZipCode=MAIL_ZIP, Phone=WORK_PHONE, Fax=FAX)%>%
  mutate(id=as.numeric(paste0(county,place)))

areas=read.csv("RCS County Place names.csv", stringsAsFactors = FALSE)%>%
  mutate(id=as.numeric(paste0(countyfips,placefips)))

sdo=read.csv("rcs_sdo.csv", stringsAsFactors = FALSE)%>%
  rename(county=CountyFIPS, place=PlaceFIPS)%>%
  gather(variable, value, -county:-place)%>%
  mutate(year=paste0("20", str_sub(variable, -2,-1)),
         variable=str_sub(variable,1,-3))%>%
  spread(variable, value)%>%
  select(county, place, year, Population=Tp, HousingUnits=Thu)%>%
  mutate(id=as.numeric(paste0(county,place)))
  
census_p=read.csv("rcs_census.csv", stringsAsFactors = FALSE)%>%
  rename(county=COUNTY, place=PLACE)%>%
  gather(variable, Population, -county, -place)%>%
  mutate(year=str_sub(variable, -4,-1))%>%
  select(county, place, year, Population)

census_h=read.csv("rcs_census_housing.csv", stringsAsFactors = FALSE)%>%
  gather(variable, value, -county, -place)%>%
  separate(variable, into=c("variable", "year"), sep="_")%>%
  spread(variable, value)%>%
  rename(HousingUnits=hu, Permits=perm)%>%
  select(county, place, year, HousingUnits,Permits)

census=inner_join(census_p, census_h)%>%
  mutate(id=as.numeric(paste0(county,place)))

annex=read.csv("rcs_annex.csv")%>%
  rename(county=CountyFIPS, place=PlaceFIPS)%>%
  gather(variable, value, -county:-place)%>%
  mutate(year=str_sub(variable, -4,-1),
         year=recode(year, "1011=2011; 1112=2012; 1213=2013; 1314=2014; 1415=2015"),
         variable=str_sub(variable, 1,-5),
         id=as.numeric(paste0(county,place)))%>%
  spread(variable, value)%>%
  select(id, county, place,year, PopulationChange=PopChange, HousingUnitChange=HUChange, HouseholdChange=HHChange, GroupQuartersChange=GQChange )


# Functions #

