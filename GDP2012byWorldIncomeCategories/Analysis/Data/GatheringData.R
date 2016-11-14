
setwd("C:/Users/Angel Mail 1/Desktop/albert/SMU data science/Course Work/Doing Data Science/CaseStudy/GDP2012byWorldIncomeCategories/Analysis/Data")

## This code chuck is Data_Gathering.  The code reads two data sets comma delimited files from the internet.
# the file locations are:
#
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

# the functions used were in the Basic package and the repmis package.

#libraries <- c('rms', 'mice', 'knitr', 'ff', 'ffbase', "ffbase")
libraries <- c('ggplot2', 'dplyr', 'lubridate', 'tidyr', 'stringr')
lapply(libraries, FUN = function(y) {
  do.call('require', list(y))})

#The file was scanned to obtain the SHA-1 hash.

#This data set is the gross domestic product for 2012 by country in US Dollars

#scan_https("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv")

GDPRAW <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv")
EDURAW <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")


write.csv(GDPRAW, "GDPRAW.csv")
write.csv(EDURAW, "EDURAW.csv")



# this was the first attempt at importing the data
# The data was imported using the read.csv function creating the dataframe GDP.Raw.

#The raw data was output to txt files.
# after a series of analsys of the data, the following data set w
