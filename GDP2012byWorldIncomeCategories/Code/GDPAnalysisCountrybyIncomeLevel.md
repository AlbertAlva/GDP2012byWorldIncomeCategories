# World 2012 GDP by Country Analysis
Albert Alva  
November 7, 2016  



## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.
getwd()
#Assignment
This assignment is a case study of the 2012 Gross National Product of the World.  It requires downloading
data from the web, tidying the data, merging data sets and analyzing the results.
1 Merge the data based on the country short code. How many of the IDs match?
2 Sort the data frame in ascending order by GDP (so United States is last). What is the 13th
country in the resulting data frame?
3 What are the average GDP rankings for the "High income: OECD" and "High income:
nonOECD" groups?
4 Plot the GDP for all of the countries. Use ggplot2 to color your plot by Income Group.
5 Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group.
How many countries are Lower middle income but among the 38 nations with highest
GDP?
##Deliverable
The deliverable is a Markdown file uploaded to Git Hub containing the following:
• Introduction to the project. The introduction should not start with “For my project I …”.
The introduction needs to be written as if you are presenting the work to someone who
has given you the data to analyze and wants to understand the result. In other words,
pretend it’s not a case study for a course. Pretend it’s a presentation for a client.

• Code for downloading, tidying, and merging data in a R Markdown file. The code should
be in a make file style, meaning that the source RMD document pulls in separate files for
importing data, cleaning the data, and data analysis.

• Brief explanations of the purpose of the code. The explanations should appear as a
sentence or two before or after the code chunk. Even though you will not be hiding the
code chunks (so that I can see the code), you need to pretend that the client can’t see
them.

• Code to answer the five questions above (plus the answers) in the same R Markdown file.

• Clear answers to the questions. Just the code to answer the questions is not enough, even
if the code is correct and gives the correct answer. You must state the answer in a
complete sentence outside the code chunk.

• Conclusion to the project. Summarize your findings from this exercise.




##Data
Two data sets were downloaded from cloudfrount.net:/
The Gross Domestic Product data for the 190 ranked countries:
      https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
  The educational data from this data set:
      https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
Original data sources (if the links above don’t work):

###Gathering Data
Gross Domestic Product data set was obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
It contains Countries, World GDP Ranking and Gross Domestic Product for 2012.

The code reads two data sets comma delimited files from the internet.
 the file locations are:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
 SHA-1 hash of file is 18dd2f9ca509a8ace7d8de3831a8f842124c533d

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

The functions used were in the Basic package and the repmis package.
Required: gdata, tidyr, repmis

setwd("C:/Users/Angel Mail 1/Desktop/albert/SMU data science/Course Work/Doing Data Science/CaseStudy/DoingDataScienceCaseStudyOne/analysis")



```r
setwd("Analysis/data")
library(gdata)
```

```
## gdata: read.xls support for 'XLS' (Excel 97-2004) files ENABLED.
```

```
## 
```

```
## gdata: read.xls support for 'XLSX' (Excel 2007+) files ENABLED.
```

```
## 
## Attaching package: 'gdata'
```

```
## The following object is masked from 'package:stats':
## 
##     nobs
```

```
## The following object is masked from 'package:utils':
## 
##     object.size
```

```
## The following object is masked from 'package:base':
## 
##     startsWith
```

```r
library(tidyr)
library(repmis)
library(data.table)
```

```
## 
## Attaching package: 'data.table'
```

```
## The following object is masked from 'package:gdata':
## 
##     last
```
#The file was scanned to obtain the SHA-1 hash.
#This data set is the gross domestic product for 2012 by country in US Dollars


```r
setwd("Analysis/data")

GDPRaw<- data.frame(scan_https("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"))
```

```
## SHA-1 hash of file is 18dd2f9ca509a8ace7d8de3831a8f842124c533d
```

```r
EDURaw <- data.frame(scan_https("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"))
```

```
## SHA-1 hash of file is 20be6ae8245b5a565a815c18a615a83c34745e5e
```

```r
write.table(GDPRaw, "GDPRaw.csv", sep = ",", col.names = TRUE)
write.table(EDURaw, "EDURaw.csv", sep = ",", col.names = TRUE)

#The raw data was output to txt files.



getwd()
```

```
## [1] "C:/Users/Angel Mail 1/Desktop/albert/SMU data science/Course Work/Doing Data Science/CaseStudy/GDP2012byWorldIncomeCategories/Analysis/data"
```


```r
setwd("Analysis/data")

getwd()
```

```
## [1] "C:/Users/Angel Mail 1/Desktop/albert/SMU data science/Course Work/Doing Data Science/CaseStudy/GDP2012byWorldIncomeCategories/Analysis/data"
```

```r
###   this function for removing punctuation.
##x <- c(1,2,"?",3); ifelse(x=="?",NA,x)


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

#Two data set are to be written GDP and

#The GDP data was imported with no headers since it contained a header and space before the data
#the column headings were also on seperate lines and one without a label.  The data was imported
#without column labels and skipped the first 5 rows to strip off the header and labels.
#label V and the column number was temperarilly assigned to the columns
#Reimported the data.

ncol <- max(count.fields("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", sep = ",", skip = 5))

GDPoriginal <- data.table(read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", fill = TRUE, header = FALSE, col.names = paste0("V", seq_len(ncol)),skip = 5,nrows = 190, stringsAsFactors = FALSE, na.strings = FALSE ))

str(GDPoriginal)
```

```
## Classes 'data.table' and 'data.frame':	190 obs. of  10 variables:
##  $ V1 : chr  "USA" "CHN" "JPN" "DEU" ...
##  $ V2 : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ V3 : logi  NA NA NA NA NA NA ...
##  $ V4 : chr  "United States" "China" "Japan" "Germany" ...
##  $ V5 : chr  " 16,244,600 " " 8,227,103 " " 5,959,718 " " 3,428,131 " ...
##  $ V6 : chr  "" "" "" "" ...
##  $ V7 : logi  NA NA NA NA NA NA ...
##  $ V8 : logi  NA NA NA NA NA NA ...
##  $ V9 : logi  NA NA NA NA NA NA ...
##  $ V10: logi  NA NA NA NA NA NA ...
##  - attr(*, ".internal.selfref")=<externalptr>
```

```r
summary(GDPoriginal)
```

```
##       V1                  V2            V3               V4           
##  Length:190         Min.   :  1.00   Mode:logical   Length:190        
##  Class :character   1st Qu.: 48.25   NA's:190       Class :character  
##  Mode  :character   Median : 95.50                  Mode  :character  
##                     Mean   : 95.49                                    
##                     3rd Qu.:142.75                                    
##                     Max.   :190.00                                    
##       V5                 V6               V7             V8         
##  Length:190         Length:190         Mode:logical   Mode:logical  
##  Class :character   Class :character   NA's:190       NA's:190      
##  Mode  :character   Mode  :character                                
##                                                                     
##                                                                     
##                                                                     
##     V9            V10         
##  Mode:logical   Mode:logical  
##  NA's:190       NA's:190      
##                               
##                               
##                               
## 
```

```r
GDPSUB <- subset(GDPoriginal,select = c(1,2,4,5) )

#The names() function was used to name the columns

names(GDPSUB) <- c("CountryCode","Rank","Economy","GDP" )

dir()
```

```
## [1] "AverageGDPofIncomeGroups.html" "EDURaw.csv"                   
## [3] "EDUSUB.csv"                    "GDPEDU.csv"                   
## [5] "GDPRaw.csv"                    "GDPSUB.csv"                   
## [7] "Plots.pdf"
```

```r
head(GDPSUB)
```

```
##    CountryCode Rank        Economy          GDP
## 1:         USA    1  United States  16,244,600 
## 2:         CHN    2          China   8,227,103 
## 3:         JPN    3          Japan   5,959,718 
## 4:         DEU    4        Germany   3,428,131 
## 5:         FRA    5         France   2,612,878 
## 6:         GBR    6 United Kingdom   2,471,784
```

```r
str(GDPSUB)
```

```
## Classes 'data.table' and 'data.frame':	190 obs. of  4 variables:
##  $ CountryCode: chr  "USA" "CHN" "JPN" "DEU" ...
##  $ Rank       : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ Economy    : chr  "United States" "China" "Japan" "Germany" ...
##  $ GDP        : chr  " 16,244,600 " " 8,227,103 " " 5,959,718 " " 3,428,131 " ...
##  - attr(*, ".internal.selfref")=<externalptr>
```

```r
## the Contrycode,Economy and GDP vectors were imported as factors .
   #Using repmis as.character and as.numeric
  #to change the vector format

# the ifelse function replaces a value in a vector

library(foreign)
library(stringr)
library(plyr)
library(reshape2)
```

```
## 
## Attaching package: 'reshape2'
```

```
## The following objects are masked from 'package:data.table':
## 
##     dcast, melt
```

```
## The following object is masked from 'package:tidyr':
## 
##     smiths
```

```r
# The (GDPSUB$Economy) gsub("[^[:digit:]]","",data) removed the "," from
#the GDP field

GDPSUB$GDP <- as.numeric(gsub("[^[:digit:]]","", GDPSUB$GDP))


str(GDPSUB)
```

```
## Classes 'data.table' and 'data.frame':	190 obs. of  4 variables:
##  $ CountryCode: chr  "USA" "CHN" "JPN" "DEU" ...
##  $ Rank       : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ Economy    : chr  "United States" "China" "Japan" "Germany" ...
##  $ GDP        : num  16244600 8227103 5959718 3428131 2612878 ...
##  - attr(*, ".internal.selfref")=<externalptr>
```

```r
head(GDPSUB)
```

```
##    CountryCode Rank        Economy      GDP
## 1:         USA    1  United States 16244600
## 2:         CHN    2          China  8227103
## 3:         JPN    3          Japan  5959718
## 4:         DEU    4        Germany  3428131
## 5:         FRA    5         France  2612878
## 6:         GBR    6 United Kingdom  2471784
```

```r
tail(GDPSUB)
```

```
##    CountryCode Rank               Economy GDP
## 1:         FSM  185 Micronesia, Fed. Sts. 326
## 2:         STP  186 São Tomé and Principe 263
## 3:         PLW  187                 Palau 228
## 4:         MHL  188      Marshall Islands 182
## 5:         KIR  189              Kiribati 175
## 6:         TUV  190                Tuvalu  40
```

```r
summary(GDPSUB)
```

```
##  CountryCode             Rank          Economy               GDP          
##  Length:190         Min.   :  1.00   Length:190         Min.   :      40  
##  Class :character   1st Qu.: 48.25   Class :character   1st Qu.:    7005  
##  Mode  :character   Median : 95.50   Mode  :character   Median :   27638  
##                     Mean   : 95.49                      Mean   :  377652  
##                     3rd Qu.:142.75                      3rd Qu.:  205289  
##                     Max.   :190.00                      Max.   :16244600
```

```r
### All fields in the data set are tidy



## data set Tidy

## dataset two



EDUSUB <- subset(data.table(read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",fill = TRUE,header = TRUE, blank.lines.skip = TRUE,stringsAsFactors = FALSE,strip.white = TRUE,na.strings = FALSE)),select = c(1,2,3))


#The names() function was used to name the columns
names(EDUSUB) <- c("CountryCode","LongName","IncomeGroup") # getting rid of .

#EDUSUB$Longname2 <-gsub("[[:punct:]]","", EDUSUB$LongName)
#EDUSUB$Longname<-EDUSUB$Longname2

# this data is tidy
summary(GDPSUB)
```

```
##  CountryCode             Rank          Economy               GDP          
##  Length:190         Min.   :  1.00   Length:190         Min.   :      40  
##  Class :character   1st Qu.: 48.25   Class :character   1st Qu.:    7005  
##  Mode  :character   Median : 95.50   Mode  :character   Median :   27638  
##                     Mean   : 95.49                      Mean   :  377652  
##                     3rd Qu.:142.75                      3rd Qu.:  205289  
##                     Max.   :190.00                      Max.   :16244600
```

```r
str(GDPSUB)
```

```
## Classes 'data.table' and 'data.frame':	190 obs. of  4 variables:
##  $ CountryCode: chr  "USA" "CHN" "JPN" "DEU" ...
##  $ Rank       : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ Economy    : chr  "United States" "China" "Japan" "Germany" ...
##  $ GDP        : num  16244600 8227103 5959718 3428131 2612878 ...
##  - attr(*, ".internal.selfref")=<externalptr>
```

```r
summary(EDUSUB)
```

```
##  CountryCode          LongName         IncomeGroup       
##  Length:234         Length:234         Length:234        
##  Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character
```

```r
str(EDUSUB)
```

```
## Classes 'data.table' and 'data.frame':	234 obs. of  3 variables:
##  $ CountryCode: chr  "ABW" "ADO" "AFG" "AGO" ...
##  $ LongName   : chr  "Aruba" "Principality of Andorra" "Islamic State of Afghanistan" "People's Republic of Angola" ...
##  $ IncomeGroup: chr  "High income: nonOECD" "High income: nonOECD" "Low income" "Lower middle income" ...
##  - attr(*, ".internal.selfref")=<externalptr>
```

```r
## the two datasets are tidy
write.csv(GDPSUB,"GDPSUB.csv")
write.csv(EDUSUB,"EDUSUB.csv")
```



```r
setwd("Analysis/data")

#This portion of the code is to merge the data


#merge
#doBy::orderBy(GDP,GDPEDU)

#CHECKING VARIABLES AND CHECKING FOR MISSING DATA

str(GDPSUB)
```

```
## Classes 'data.table' and 'data.frame':	190 obs. of  4 variables:
##  $ CountryCode: chr  "USA" "CHN" "JPN" "DEU" ...
##  $ Rank       : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ Economy    : chr  "United States" "China" "Japan" "Germany" ...
##  $ GDP        : num  16244600 8227103 5959718 3428131 2612878 ...
##  - attr(*, ".internal.selfref")=<externalptr>
```

```r
summary(GDPSUB)
```

```
##  CountryCode             Rank          Economy               GDP          
##  Length:190         Min.   :  1.00   Length:190         Min.   :      40  
##  Class :character   1st Qu.: 48.25   Class :character   1st Qu.:    7005  
##  Mode  :character   Median : 95.50   Mode  :character   Median :   27638  
##                     Mean   : 95.49                      Mean   :  377652  
##                     3rd Qu.:142.75                      3rd Qu.:  205289  
##                     Max.   :190.00                      Max.   :16244600
```

```r
GDPSUB[!complete.cases(GDPSUB),]
```

```
## Empty data.table (0 rows) of 4 cols: CountryCode,Rank,Economy,GDP
```

```r
str(EDUSUB)
```

```
## Classes 'data.table' and 'data.frame':	234 obs. of  3 variables:
##  $ CountryCode: chr  "ABW" "ADO" "AFG" "AGO" ...
##  $ LongName   : chr  "Aruba" "Principality of Andorra" "Islamic State of Afghanistan" "People's Republic of Angola" ...
##  $ IncomeGroup: chr  "High income: nonOECD" "High income: nonOECD" "Low income" "Lower middle income" ...
##  - attr(*, ".internal.selfref")=<externalptr>
```

```r
summary(EDUSUB)
```

```
##  CountryCode          LongName         IncomeGroup       
##  Length:234         Length:234         Length:234        
##  Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character
```

```r
EDUSUB[!complete.cases(EDUSUB),]
```

```
## Empty data.table (0 rows) of 3 cols: CountryCode,LongName,IncomeGroup
```

```r
GDPEDU<- merge(GDPSUB,EDUSUB,by.x = "CountryCode",
               by.y = "CountryCode",all.x = TRUE,all.y = FALSE)

str(GDPEDU)
```

```
## Classes 'data.table' and 'data.frame':	190 obs. of  6 variables:
##  $ CountryCode: chr  "ABW" "AFG" "AGO" "ALB" ...
##  $ Rank       : int  161 105 60 125 32 26 133 172 12 27 ...
##  $ Economy    : chr  "Aruba" "Afghanistan" "Angola" "Albania" ...
##  $ GDP        : num  2584 20497 114147 12648 348595 ...
##  $ LongName   : chr  "Aruba" "Islamic State of Afghanistan" "People's Republic of Angola" "Republic of Albania" ...
##  $ IncomeGroup: chr  "High income: nonOECD" "Low income" "Lower middle income" "Upper middle income" ...
##  - attr(*, ".internal.selfref")=<externalptr> 
##  - attr(*, "sorted")= chr "CountryCode"
```

```r
summary(GDPEDU)
```

```
##  CountryCode             Rank          Economy               GDP          
##  Length:190         Min.   :  1.00   Length:190         Min.   :      40  
##  Class :character   1st Qu.: 48.25   Class :character   1st Qu.:    7005  
##  Mode  :character   Median : 95.50   Mode  :character   Median :   27638  
##                     Mean   : 95.49                      Mean   :  377652  
##                     3rd Qu.:142.75                      3rd Qu.:  205289  
##                     Max.   :190.00                      Max.   :16244600  
##    LongName         IncomeGroup       
##  Length:190         Length:190        
##  Class :character   Class :character  
##  Mode  :character   Mode  :character  
##                                       
##                                       
## 
```

```r
GDPEDU[!complete.cases(GDPEDU),]
```

```
##    CountryCode Rank     Economy   GDP LongName IncomeGroup
## 1:         SSD  131 South Sudan 10220       NA          NA
```

```r
#Answer 1 189 of EDU matched the 190 GDP "South Sudan" did not match


attach(GDPEDU)
summary(GDPEDU)
```

```
##  CountryCode             Rank          Economy               GDP          
##  Length:190         Min.   :  1.00   Length:190         Min.   :      40  
##  Class :character   1st Qu.: 48.25   Class :character   1st Qu.:    7005  
##  Mode  :character   Median : 95.50   Mode  :character   Median :   27638  
##                     Mean   : 95.49                      Mean   :  377652  
##                     3rd Qu.:142.75                      3rd Qu.:  205289  
##                     Max.   :190.00                      Max.   :16244600  
##    LongName         IncomeGroup       
##  Length:190         Length:190        
##  Class :character   Class :character  
##  Mode  :character   Mode  :character  
##                                       
##                                       
## 
```

```r
str(EDUSUB)
```

```
## Classes 'data.table' and 'data.frame':	234 obs. of  3 variables:
##  $ CountryCode: chr  "ABW" "ADO" "AFG" "AGO" ...
##  $ LongName   : chr  "Aruba" "Principality of Andorra" "Islamic State of Afghanistan" "People's Republic of Angola" ...
##  $ IncomeGroup: chr  "High income: nonOECD" "High income: nonOECD" "Low income" "Lower middle income" ...
##  - attr(*, ".internal.selfref")=<externalptr>
```

```r
write.csv(GDPEDU,"GDPEDU.csv")

#  The merged dataset is ready for analysis
```



```r
setwd("Analysis/data")

library(doBy)
library(R2HTML)
#attach(GDPEDU)

#elimiated the non matching observation
GDPEDU <- na.omit(GDPEDU)
GDPEDU[!complete.cases(GDPEDU),]
```

```
## Empty data.table (0 rows) of 6 cols: CountryCode,Rank,Economy,GDP,LongName,IncomeGroup
```

```r
#ordering the data set by GDP to tell the 13th from the top
GDPEDU<-orderBy(~GDP,data=GDPEDU)
GDPEDU$LongName[13]
```

```
## [1] "St. Kitts and Nevis"
```

```r
#2a the 13th country on the list is St. Kitts and Nevis"

write.csv(GDPEDU,"GDPEDU.csv")

#  b. What are the average GDP rankings for the "High income: OECD" and "High income: nonOECD" groups?
#attach(GDPEDU)

#GDPEDU[, mean(GDPEDU$Rank, na.rm = TRUE), by = GDPEDU$IncomeGroup]

#GDPEDU[,mean(Rank, na.rm = TRUE), by = IncomeGroup]
str(GDPEDU)
```

```
## Classes 'data.table' and 'data.frame':	189 obs. of  6 variables:
##  $ CountryCode: chr  "TUV" "KIR" "MHL" "PLW" ...
##  $ Rank       : int  190 189 188 187 186 185 184 183 182 181 ...
##  $ Economy    : chr  "Tuvalu" "Kiribati" "Marshall Islands" "Palau" ...
##  $ GDP        : num  40 175 182 228 263 326 472 480 596 684 ...
##  $ LongName   : chr  "Tuvalu" "Republic of Kiribati" "Republic of the Marshall Islands" "Republic of Palau" ...
##  $ IncomeGroup: chr  "Lower middle income" "Lower middle income" "Lower middle income" "Upper middle income" ...
##  - attr(*, ".internal.selfref")=<externalptr>
```

```r
GDPR <-GDPEDU[, mean(GDPEDU$Rank , na.rm = TRUE), by = GDPEDU$IncomeGroup]
names(GDPR) <- c("Income Group", "Average GDP")
GDPR
```

```
##            Income Group Average GDP
## 1:  Lower middle income    95.30688
## 2:  Upper middle income    95.30688
## 3:           Low income    95.30688
## 4: High income: nonOECD    95.30688
## 5:    High income: OECD    95.30688
```

```r
HTML(GDPR,"AverageGDPofIncomeGroups.html")
HTMLEndFile("AverageGDPofIncomeGroups.html")


#High income: nonOECD Mean = 91.91304
#High income: OECD Mean =   32.96667

#  c. Plot the GDP for all of the countries. Use ggplot2 to
#color your plot by Income Group.
```



```
## [1] "C:/Users/Angel Mail 1/Desktop/albert/SMU data science/Course Work/Doing Data Science/CaseStudy/GDP2012byWorldIncomeCategories/Plots"
```

```
##               IncomeGroup              Economy stringsAsFactors
##   1: High income: nonOECD                Aruba            FALSE
##   2:           Low income          Afghanistan            FALSE
##   3:  Lower middle income               Angola            FALSE
##   4:  Upper middle income              Albania            FALSE
##   5: High income: nonOECD United Arab Emirates            FALSE
##  ---                                                           
## 186:  Lower middle income          Yemen, Rep.            FALSE
## 187:  Upper middle income         South Africa            FALSE
## 188:           Low income     Congo, Dem. Rep.            FALSE
## 189:           Low income               Zambia            FALSE
## 190:           Low income             Zimbabwe            FALSE
```

```
## The following objects are masked from GDPEDU:
## 
##     Economy, IncomeGroup
```

![](GDPAnalysisCountrybyIncomeLevel_files/figure-html/PlottingData-1.png)<!-- -->

```
## Warning: 'mode(width)' differs between new and previous
## 	 ==> NOT changing 'width'
```

```
## png 
##   2
```

```
##  chr [1:189] "(152,190]" "(152,190]" "(152,190]" "(152,190]" ...
```

```
##    Length     Class      Mode 
##       189 character character
```

```
##            IncomeGroup        qGDP  N
## 1: Lower middle income   (152,190] 16
## 2: Lower middle income   (114,152]  9
## 3: Lower middle income  (76.2,114] 11
## 4: Lower middle income (38.6,76.2] 13
## 5: Lower middle income    (1,38.6]  5
```

```
## [1] "C:/Users/Angel Mail 1/Desktop/albert/SMU data science/Course Work/Doing Data Science/CaseStudy/GDP2012byWorldIncomeCategories/Plots"
```




