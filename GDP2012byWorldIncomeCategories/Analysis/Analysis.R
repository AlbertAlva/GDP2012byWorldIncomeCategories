
setwd("C:/Users/Angel Mail 1/Desktop/albert/SMU data science/Course Work/Doing Data Science/CaseStudy/GDP2012byWorldIncomeCategories/Analysis/Data")


libraries <- c('ggplot2', 'dplyr', 'lubridate',
               'tidyr', 'stringr','data.table','dtplyr','doBy','stats','R2HTML')
lapply(libraries, FUN = function(y) {
  do.call('require', list(y))})
str(GDPEDU)

GDPEDU2 <- na.omit(GDPEDU)
GDPEDU2[!complete.cases(GDPEDU2),]
#ordering the data set by GDP to tell the 13th from the top

#2a the 13th country on the list is St. Kitts and Nevis"
GDPEDU2<-orderBy(~GDP,data=GDPEDU2)
GDPEDU2$LongName[13]
write.csv(GDPEDU2,"GDPEDU2.csv")

GDPEDU2 <- data.table(GDPEDU2)

#  b. What are the average GDP rankings for the "High income: OECD" and "High income: nonOECD" groups?
#attach(GDPEDU)

GDPR <- GDPEDU2[,mean(Countryrank, na.rm = TRUE), by = IncomeGroup, ]
names(GDPR) <- c("Income Group", "Average GDP")
GDPR

HTML(GDPR,"AverageGDPofIncomeGroups.html")
HTMLEndFile("AverageGDPofIncomeGroups.html")


#High income: nonOECD Mean = 91.91304
#High income: OECD Mean =   32.96667

#  c. Plot the GDP for all of the countries. Use ggplot2 to
#color your plot by Income Group.
attach(GDPEDU2)
myplot <- data.table(GDPEDU2$IncomeGroup,GDPEDU2$Economy,GDPEDU2$Region)
names(myplot)  <- c("IncomeGroup","Economy","Region")
attach(myplot)
library(ggplot2)
#g = ggplot(myplot,aes(IncomeGroup, fill= IncomeGroup))
g = ggplot(myplot,aes(IncomeGroup))
g = g + geom_bar(aes(fill= Economy))
g = g+ggtitle("Organzation for Economic Cooperation and Development\n (OECD) 2012 GDP\n Country Count by GDP Income Group")
g= g+labs(x="GDP Income Group", y="Number of Countries")
g= g+theme(axis.text.x  = element_text(size=8), legend.position = "none")
g
detach(myplot)


#  d. Cut the GDP ranking into 5 separate quantile groups.
library(stats)
library(data.table)
library(R2HTML)

qx <- quantile(GDPEDU2$Countryrank, probs= seq(0, 1, 0.20), na.rm = TRUE)
GDPEDU2$GdpQuantiles <- as.character(cut(GDPEDU2$Countryrank, qx, include.lowest = FALSE))

str(GDPEDU2$GdpQuantiles)
head(GDPEDU2$GdpQuantiles)
summary(GDPEDU2$GdpQuantiles)

attach(GDPEDU2)


Qd <- GDPEDU2[IncomeGroup=="Lower middle income", .N ,by=c("IncomeGroup", "GdpQuantiles")]

Qd #  e. Make a table versus Income.Group.


HTML(Qd, "IncomeGroupsinHighest38.html")
HTMLEndFile("IncomeGroupsinHighest38.html")
getwd()


#  f  How many countries are Lower middle income
#       but among the 38 nations with highest GDP?

#####16 members of the lower middle income group were in the highest 38

# The project calls for countrycode and income group

