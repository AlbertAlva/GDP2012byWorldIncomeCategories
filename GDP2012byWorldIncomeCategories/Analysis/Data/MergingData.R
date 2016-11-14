#This portion of the code is to merge the data

setwd("C:/Users/Angel Mail 1/Desktop/albert/SMU data science/Course Work/Doing Data Science/CaseStudy/GDP2012byWorldIncomeCategories/Analysis/Data")


libraries <- c('ggplot2', 'dplyr', 'lubridate', 'tidyr', 'stringr','doBy')
lapply(libraries, FUN = function(y) {
  do.call('require', list(y))})

#merge
#doBy::orderBy(GDP,GDPEDU)

#CHECKING VARIABLES AND CHECKING FOR MISSING DATA

GDPEDU<- merge(GDPORIGINAL,EDUORIGINAL,by.x = "CountryCode",
               by.y = "CountryCode",all.x = TRUE,all.y = FALSE)
str(GDPEDU)
head(GDPEDU)
summary(GDPEDU)
GDPEDU[!complete.cases(GDPEDU),]
#Answer 1 189 of EDU matched the 190 GDP "South Sudan" did not match

write.csv(GDPEDU,"GDPEDU.csv")

#  The merged dataset is ready for analysis
