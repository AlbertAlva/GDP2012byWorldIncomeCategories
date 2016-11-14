# MakeData
Albert Alva  
November 14, 2016  

##Gathering Data
The first task in the project was to obtain the data. Gross Domestic Product data set was obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv. It contains Countries, World GDP Ranking and Gross Domestic Product for 2012. The income categories for the counties was obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv.
The functions used were in the package listed below.
 	repmis   
 	 R2HTML, 
 	stats, ggplot2
 	tidyr
 	 data.table. 


```r
libraries <- c('ggplot2', 'dplyr', 'lubridate', 'tidyr', 'stringr')
GDPRAW <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv")
EDURAW <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")
write.csv(GDPRAW, "GDPRAW.csv")
write.csv(EDURAW, "EDURAW.csv")
```
###Tidy Data
This code chunk titled TidyData explains the steps to prepare the data for evaluation.

Two data set are to be written GDPORIGINAL and EDUORIGINAL. They are subsets of the original data. Both datasets where written with just the variables needed to answer the research questions. The **view()** function was used to view the raw data to decide how to cut the data.
The GDP data was imported with no headers since it contained a header and space before the data the column headings were also on seperate lines and one without a label. The data was imported without column labels and skipped the first 5 rows to strip off the header and labels. label V and the column number was temperarilly assigned to the columns Reimported the data. The EDU data was imported with headers and required little transformation beyond subsetting with the **subset()** function. The **names()** function was used to rename the variables. The **gsub("[^[:digit:]]",""** function removed commas from number fields and the  **gsub('[[:punct:] ]+** was used to eliminate punctuation from text.


```r
libraries <- c('ggplot2', 'dplyr', 'lubridate', 'tidyr', 'stringr','stats')
GDPORIGINAL <- subset(read.csv("GDPRAW.csv",skip = 5, nrows = 190 ,header = FALSE,stringsAsFactors = FALSE), select =  c(2,3,5,6))
names(GDPORIGINAL) <- c("CountryCode", "Countryrank", "Economy", "GDP")
GDPORIGINAL[!complete.cases(GDPORIGINAL),]
```

```
## [1] CountryCode Countryrank Economy     GDP        
## <0 rows> (or 0-length row.names)
```

```r
GDPORIGINAL$Countryrank <- as.numeric(GDPORIGINAL$Countryrank, na.exclude(GDPORIGINAL$Countryrank) )
GDPORIGINAL$GDP <- as.numeric(gsub("[^[:digit:]]","", GDPORIGINAL$GDP))
GDPORIGINAL$Economy <- gsub('[[:punct:] ]+','',GDPORIGINAL$Economy)
EDUORIGINAL <- subset(read.csv("EDURAW.csv",header = TRUE,stringsAsFactors = FALSE), select =  c(2,3,4,5))
names(EDUORIGINAL) <-gsub('[[:punct:] ]+','',names(EDUORIGINAL))
EDUORIGINAL <- na.omit(EDUORIGINAL)
EDUORIGINAL<- EDUORIGINAL[complete.cases(EDUORIGINAL$IncomeGroup),]
EDUORIGINAL$LongName <- gsub('[[:punct:] ]+',' ', EDUORIGINAL$LongName)
summary(GDPRAW)
```

```
##        X            Gross.domestic.product.2012   X.1         
##         :102                      :135          Mode:logical  
##  ABW    :  1   178                :  2          NA's:330      
##  ADO    :  1   .. Not available.  :  1                        
##  AFG    :  1   1                  :  1                        
##  AGO    :  1   10                 :  1                        
##  ALB    :  1   100                :  1                        
##  (Other):223   (Other)            :189                        
##                           X.2               X.3      X.4    
##                             :101              :101    :324  
##    East Asia & Pacific      :  1   ..         : 23   a:  1  
##    Euro area                :  1    767       :  2   b:  1  
##    Europe & Central Asia    :  1    1,008     :  1   c:  1  
##    Latin America & Caribbean:  1    1,129     :  1   d:  1  
##    Lower middle income      :  1    1,129,598 :  1   e:  1  
##  (Other)                    :224   (Other)    :201   f:  1  
##    X.5            X.6            X.7            X.8         
##  Mode:logical   Mode:logical   Mode:logical   Mode:logical  
##  NA's:330       NA's:330       NA's:330       NA's:330      
##                                                             
##                                                             
##                                                             
##                                                             
## 
```

```r
str(GDPRAW)
```

```
## 'data.frame':	330 obs. of  10 variables:
##  $ X                          : Factor w/ 229 levels "","ABW","ADO",..: 1 1 1 1 215 38 102 51 68 72 ...
##  $ Gross.domestic.product.2012: Factor w/ 195 levels "",".. Not available.  ",..: 1 1 195 1 3 104 115 126 137 148 ...
##  $ X.1                        : logi  NA NA NA NA NA NA ...
##  $ X.2                        : Factor w/ 230 levels "","  East Asia & Pacific",..: 1 1 67 1 219 51 108 83 78 218 ...
##  $ X.3                        : Factor w/ 207 levels ""," 1,008 "," 1,129 ",..: 1 191 207 1 40 178 143 100 66 63 ...
##  $ X.4                        : Factor w/ 7 levels "","a","b","c",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ X.5                        : logi  NA NA NA NA NA NA ...
##  $ X.6                        : logi  NA NA NA NA NA NA ...
##  $ X.7                        : logi  NA NA NA NA NA NA ...
##  $ X.8                        : logi  NA NA NA NA NA NA ...
```

```r
summary(GDPORIGINAL)
```

```
##  CountryCode         Countryrank       Economy               GDP          
##  Length:190         Min.   :  1.00   Length:190         Min.   :      40  
##  Class :character   1st Qu.: 48.25   Class :character   1st Qu.:    7005  
##  Mode  :character   Median : 95.50   Mode  :character   Median :   27638  
##                     Mean   : 95.49                      Mean   :  377652  
##                     3rd Qu.:142.75                      3rd Qu.:  205289  
##                     Max.   :190.00                      Max.   :16244600
```

```r
str(GDPORIGINAL)
```

```
## 'data.frame':	190 obs. of  4 variables:
##  $ CountryCode: chr  "USA" "CHN" "JPN" "DEU" ...
##  $ Countryrank: num  1 2 3 4 5 6 7 8 9 10 ...
##  $ Economy    : chr  "UnitedStates" "China" "Japan" "Germany" ...
##  $ GDP        : num  16244600 8227103 5959718 3428131 2612878 ...
```

```r
summary(EDUORIGINAL)
```

```
##  CountryCode          LongName         IncomeGroup       
##  Length:234         Length:234         Length:234        
##  Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character  
##     Region         
##  Length:234        
##  Class :character  
##  Mode  :character
```

```r
str(EDUORIGINAL)
```

```
## 'data.frame':	234 obs. of  4 variables:
##  $ CountryCode: chr  "ABW" "ADO" "AFG" "AGO" ...
##  $ LongName   : chr  "Aruba" "Principality of Andorra" "Islamic State of Afghanistan" "People s Republic of Angola" ...
##  $ IncomeGroup: chr  "High income: nonOECD" "High income: nonOECD" "Low income" "Lower middle income" ...
##  $ Region     : chr  "Latin America & Caribbean" "Europe & Central Asia" "South Asia" "Sub-Saharan Africa" ...
```

```r
write.csv(GDPORIGINAL,"GDPORIGINAL.csv")
write.csv(EDUORIGINAL,"EDUORIGINAL.csv")
```

```r
GDPEDU<- merge(GDPORIGINAL,EDUORIGINAL,by.x = "CountryCode",
by.y = "CountryCode",all.x = TRUE,all.y = FALSE)

str(GDPEDU)
```

```
## 'data.frame':	190 obs. of  7 variables:
##  $ CountryCode: chr  "ABW" "AFG" "AGO" "ALB" ...
##  $ Countryrank: num  161 105 60 125 32 26 133 172 12 27 ...
##  $ Economy    : chr  "Aruba" "Afghanistan" "Angola" "Albania" ...
##  $ GDP        : num  2584 20497 114147 12648 348595 ...
##  $ LongName   : chr  "Aruba" "Islamic State of Afghanistan" "People s Republic of Angola" "Republic of Albania" ...
##  $ IncomeGroup: chr  "High income: nonOECD" "Low income" "Lower middle income" "Upper middle income" ...
##  $ Region     : chr  "Latin America & Caribbean" "South Asia" "Sub-Saharan Africa" "Europe & Central Asia" ...
```

```r
summary(GDPEDU)
```

```
##  CountryCode         Countryrank       Economy               GDP          
##  Length:190         Min.   :  1.00   Length:190         Min.   :      40  
##  Class :character   1st Qu.: 48.25   Class :character   1st Qu.:    7005  
##  Mode  :character   Median : 95.50   Mode  :character   Median :   27638  
##                     Mean   : 95.49                      Mean   :  377652  
##                     3rd Qu.:142.75                      3rd Qu.:  205289  
##                     Max.   :190.00                      Max.   :16244600  
##    LongName         IncomeGroup           Region         
##  Length:190         Length:190         Length:190        
##  Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character  
##                                                          
##                                                          
## 
```

```r
str(GDPEDU)
```

```
## 'data.frame':	190 obs. of  7 variables:
##  $ CountryCode: chr  "ABW" "AFG" "AGO" "ALB" ...
##  $ Countryrank: num  161 105 60 125 32 26 133 172 12 27 ...
##  $ Economy    : chr  "Aruba" "Afghanistan" "Angola" "Albania" ...
##  $ GDP        : num  2584 20497 114147 12648 348595 ...
##  $ LongName   : chr  "Aruba" "Islamic State of Afghanistan" "People s Republic of Angola" "Republic of Albania" ...
##  $ IncomeGroup: chr  "High income: nonOECD" "Low income" "Lower middle income" "Upper middle income" ...
##  $ Region     : chr  "Latin America & Caribbean" "South Asia" "Sub-Saharan Africa" "Europe & Central Asia" ...
```

```r
write.csv(GDPEDU,"GDPEDU.csv")
```
