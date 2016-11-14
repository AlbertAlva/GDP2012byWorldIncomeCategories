
###   this function for removing punctuation.
##x <- c(1,2,"?",3); ifelse(x=="?",NA,x)

setwd("C:/Users/Angel Mail 1/Desktop/albert/SMU data science/Course Work/Doing Data Science/CaseStudy/GDP2012byWorldIncomeCategories/Analysis/Data")


libraries <- c('ggplot2', 'dplyr', 'lubridate', 'tidyr', 'stringr')
lapply(libraries, FUN = function(y) {
  do.call('require', list(y))})

#This code chunk titled TidyData explains the steps to prepare the data for evaluation
#ASSIGNMENT
##Answer Questions
# 1.Merge the data based on the country shortcode.
#  How many of the IDs match?
#  2.Sort the data frame in ascending order by GDP (so United States is last).
#  a. What is the 13th country in the resulting data frame?
#  b. What are the average GDP rankings for the "High income: OECD" and "High income: nonOECD" groups?
#  c. Plot the GDP for all of the countries. Use ggplot2 to color your plot by Income Group.
#  d. Cut the GDP ranking into 5 separate quantile groups.
#  e. Make a table versus Income.Group.
#  f  How many countries are Lower middle income but among the 38 nations with highest GDP?

GDPORIGINAL <- subset(read.csv("GDPRAW.csv",skip = 5, nrows = 190 ,header = FALSE,stringsAsFactors = FALSE), select =  c(2,3,5,6))
names(GDPORIGINAL) <- c("CountryCode", "Countryrank", "Economy", "GDP")
GDPORIGINAL[!complete.cases(GDPORIGINAL),]

GDPORIGINAL$Countryrank <- as.numeric(GDPORIGINAL$Countryrank, na.exclude(GDPORIGINAL$Countryrank) )
GDPORIGINAL$GDP <- as.numeric(gsub("[^[:digit:]]","", GDPORIGINAL$GDP))
GDPORIGINAL$Economy <- gsub('[[:punct:] ]+','',GDPORIGINAL$Economy)

EDUORIGINAL <- subset(read.csv("EDURAW.csv",header = TRUE,stringsAsFactors = FALSE), select =  c(2,3,4,5))
names(EDUORIGINAL) <-gsub('[[:punct:] ]+','',names(EDUORIGINAL))
EDUORIGINAL <- na.omit(EDUORIGINAL)
EDUORIGINAL<- EDUORIGINAL[complete.cases(EDUORIGINAL$IncomeGroup),]
EDUORIGINAL$LongName <- gsub('[[:punct:] ]+',' ', EDUORIGINAL$LongName)
str(EDUORIGINAL)

write.csv(GDPORIGINAL,"GDPORIGINAL.csv")
write.csv(EDUORIGINAL,"EDUORIGINAL.csv")

