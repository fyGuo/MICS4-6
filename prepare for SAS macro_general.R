# prepraration for the adjusted prevalence
library(dplyr)
library(foreign)
df<-read.csv("merge4_6.csv")
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
#####################
# the data is ready now
df<-df[,-1]
str(df)
####################################################################
df$ANCp[df$ANCp=="Yes"]<-1
df$ANCp[df$ANCp=="No"]<-0
df$ANCp<-as.numeric(df$ANCp)

df$dvp[df$dvp=="Yes"]<-1
df$dvp[df$dvp=="No"]<-0
df$dvp<-as.numeric(df$dvp)

# create the province-year: to present provinces-year

df<-mutate(df,province_year=paste(province,year,sep='_'))
df$province_year %>% table
write.foreign(df,"province_year.txt","province_year.sas",
              package = "SAS")
# create upy: urabn_province_year
df<-mutate(df,upy=paste(year,urban,province,sep="_"))
write.foreign(df,"urban_province_year.txt","urban_province_year.sas",
              package = "SAS")
###################
# select the Kasai region
dfkasai<-df[df$province=="Kasai Occidental"|
                    df$province=="Kasai Oriental",]
dfkasai<-mutate(dfkasai,winyear=paste(windex5,year,sep="_"))
write.foreign(dfkasai,"dfkasai","dfkasai.sas",
              package = "SAS")
# select the kivu region
dfkivu<-df[df$province=="Nord Kivu"|
                    df$province=="Sud Kivu",]
dfkivu<-mutate(dfkivu,winyear=paste(windex5,year,sep="_"))
write.foreign(dfkivu,"dfkivu","dfkivu.sas",
              package = "SAS")
# select the other region
dfother<-df[!(df$province %in% c("Nord Kivu","Sud Kivu",
                                "Kasai Occidental","Kasai Oriental")),]
dfother<-mutate(dfother,winyear=paste(windex5,year,sep="_"))
write.foreign(dfother,"dfother","dfother.sas",
              package = "SAS")
