
library(survey)
# prepraration for the adjusted prevalence
library(dplyr)
library(foreign)
df<-read.csv("Merged data\\merge4_6.csv")
table(df$province)
dim(df)
table(df$year)

sapply(df, function(x){is.na(x) %>% sum})
df<-df[!is.na(df$helevel),]
sapply(df, function(x){is.na(x) %>% sum})
df<-df[!is.na(df$marital),]
sapply(df, function(x){is.na(x) %>% sum})
sapply(df, function(x){is.na(x) %>% sum})
df<-df[!is.na(df$ANC_doc),]
sapply(df, function(x){is.na(x) %>% sum})
dim(df)
table(df$year)

#now it is clean
#####################################################
# let's see some basic characterics to see if 3 surveys are comparable
# participants numbers in each year
table(df$year)
# first this is the age distribution of 3 surveys
# we replace the age into 10 year cuts

df$age[df$wmage=="15-19"]<-"15-19"
df$age[df$wmage %in% c("20-24","25-29")]<-"20-29"
df$age[df$wmage %in% c("30-34","35-39")]<-"30-39"
df$age[df$wmage %in% c("40-44","45-49")]<-"40-49"
df$age
t<-tapply(df$age, df$year, table)
t$ `2010` %>% prop.table()*100
t$`2018` %>% prop.table()*100
table(df$wmage,df$year) %>% chisq.test()
# education level 
t<-tapply(df$welevel, df$year, table)
t$ `2010` %>% prop.table()*100
t$`2018` %>% prop.table()*100
table(df$welevel,df$year) %>% chisq.test()

# place of reisdence
t<-tapply(df$urban, df$year, table)
t$ `2010` %>% prop.table()*100
t$`2018` %>% prop.table()*100
table(df$urban,df$year) %>% chisq.test()
# provinces living in
t<-tapply(df$province, df$year, table)
t$ `2010` %>% prop.table()*100
t$`2018` %>% prop.table()*100
table(df$province,df$year) %>% chisq.test()
# wscore
t<-tapply(df$windex5, df$year, table)
t$ `2010` %>% prop.table()*100
t$`2018` %>% prop.table()*100
table(df$province,df$year) %>% chisq.test()
# household header's sex
t<-tapply(df$hhsex, df$year, table)
t$ `2010` %>% prop.table()*100
t$`2018` %>% prop.table()*100
table(df$hhsex,df$year) %>% chisq.test()
# household header's education level
t<-tapply(df$helevel, df$year, table)
t$ `2010` %>% prop.table()*100
t$`2018` %>% prop.table()*100
table(df$helevel,df$year) %>% chisq.test()

# marital status
t <- tapply(df$marital, df$year, table)
t
