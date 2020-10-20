# This is the data to merge MICS6 household information and women level information
# I will upload the hh.dta and wm.dta later. For this data we don't download 
# from the UNICEF. We use the data from Professor Tang directly.
#read and clean data
library(dplyr)
library(foreign)
library(haven)
library(data.table)
hh<-read_dta("D:\\tang_data\\hh.dta")
hh<-dplyr::select(hh,HH1,HH2,HH12,HC1A,HC1B,HC2,HH7,HH6,helevel,HHSEX,HH17,PSU)
hh$hID<-paste(hh$HH1,hh$HH2,sep = "_")
sum(duplicated(hh$hID))
length(unique(hh$HH1))
length(unique(hh$PSU))
wm<-read_dta("D:\\tang_data\\wm.dta")
sum(wm$WM1!=wm$HH1)

#########################
# we want to check the last birth year to ensure all the women in the data
# set have given live births in last two years preceeding the survey
#wm$BH4Y_last
#max(wm$BH4Y_last)
#wm$BH4Y_last<-as.numeric(wm$BH4Y_last)
#table(wm$BH4Y_last)
#wm<-wm[wm$BH4Y_last>=2015,]
#table(wm$BH4Y_last)
#wm<-wm[wm$BH4Y_last!=9999,]
#table(wm$BH4Y_last)
#table(wm$BH4Y_last,wm$WM6Y)
#class(wm$WM6Y)
#wm<-wm[wm$WM6Y-wm$BH4Y_last<=2,]
#table(wm$BH4Y_last,wm$WM6Y)
#wm<-wm[wm$WM6Y-wm$BH4Y_last<=1,]
#table(wm$BH4Y_last,wm$WM6Y)
#(wm$WM6M)
#table(wm$WM6M,wm$WM6Y)
#table(wm$BH4M_last)
#wm$BH4M_last<-as.numeric(wm$BH4M_last)
#table(wm$BH4M_last)
#wm<-wm[wm$BH4M_last!=99,]
#table(wm$BH4M_last)
#index1<-which(wm$WM6Y==2017&wm$BH4Y_last==2016&wm$WM6M>wm$BH4M_last)
#length(index1)
#index2<-which(wm$WM6Y==2018&wm$BH4Y_last==2017&wm$WM6M>wm$BH4M_last)
#length(index2)
#wm<-wm[-index2,]
#dim(wm)
#table(wm$WM6Y,wm$BH4Y_last)
###############################################
# selet variables into wm, and create the variable hID to
#represent the household ID
wm<-dplyr::select(wm,WB3Y,HH1,CM11,CM8,HH2,MA1,WM6Y,
                  welevel,WB3Y,WB4,WDOBLC,MN2,MN3A,MN3D,MN3C,MN19A,MN19C,MN19D,MN5,wscore,
                  CM17,wmweight,WAGE,windex5,PN13U,PN13N,PN22U,PN22N)
wm$hID<-paste(wm$HH1,wm$HH2,sep = "_")
sum(duplicated(wm$hID))
new<-base::merge(wm,hh,by=c("hID","HH1","HH2"),all=F)
dim(new)

# HH1 is the sampling cluster
colnames(new)[names(new)=="HH1"]<-"cluster"

# reset the year as 2018. The survey was conducted in 2017 and 2018 
# but most in 2018

new$year<-2018
table(new$year)
# check the women's age, and make it as a categorical variable age groups
table(new$WAGE)
colnames(new)[names(new)=='WAGE']<-"wmage"
new$wmage<-factor(new$wmage,levels = 1:7,
                  labels = c("15-19","20-24",
                             "25-29","30-34",
                             "35-39","40-44",
                             "45-49"))
table(new$wmage)
# so we don't need WB3Y anymore
new<-select(new,-WB3Y)
str(new)
new
# CM11 total number of livebirths
colnames(new)[names(new)=='CM11']<-"livebirths"
table(new$livebirths)
 str(new)
 # CM8 HAVE YOU EVER GIVEN BIRTH TO A BOY OR GIRL WHO WAS BORN ALIVE BUT LATER DIED?
 table(new$CM8)
 colnames(new)[names(new)=='CM8']<-"deadchild"
 new$deadchild[new$deadchild==2]<-0
 new$deadchild<-factor(new$deadchild,levels = 0:1,
                       labels = c("No","Yes")) 
table(new$deadchild) 
str(new)
# MA1 marriage status
table(new$MA1)
new$MA1<-factor(new$MA1,levels = 1:3,
                labels=c("married","living with a partner","single"))
table(new$MA1)
colnames(new)[names(new)=='MA1']<-"marital"

str(new)
new
# WM6Y survey year we can drop it out
new<-select(new,-WM6Y)
# welevel women's education level
# 0 below primary 1 primary 2 lower secondaty 3 upper secondary 4 higher
table(new$welevel)
new$welevel[new$welevel==3|new$welevel==4]<-2
table(new$welevel)
new$welevel<-new$welevel+1
table(new$welevel)
new$welevel<-factor(new$welevel,levels = 1:3, 
                    labels = c("below primary","primary","secondary+"))
str(new)
new
# WB4 AGE 15-24	1
#      AGE 25-4 2 so we drop it
new<-select(new,-WB4)
# WDOBLC is the date of the survey year, just drop
new<-select(new,-WDOBLC)
str(new)
# we use wscore instead of windex5
summary(new$wscore)
 str(new)
new
 #  check the CM17 here Check BH4: 
 #Last birth occurred within the last 2 years, that is, since (month of interview) in (year of interview minus 2)?
table(new$CM17)

new<-new[new$CM17==1 & is.na(new$CM17)!=T,] 
new
new<-select(new,-CM17)
dim(new)
str(new)
new
# HH12 the consent
table(new$HH12)
new<-select(new,-HH12)
str(new)
# HC1A reiligon of the household head
# HC1B mother language of the household head
# HC2 ethnics of the household head
new<-select(new,-HC1A,-HC1B,-HC2)
new
str(new)
# HH7 province 
table(new$HH7)
colnames(new)[names(new)=='HH7']<-"province"
new$province<-factor(new$province,levels = 1:26,
                     labels = c("Kinshasa","Kongo Central","Kwango","Kwilu","Maindombe","Equateur",
                                 "Sud Ubangi","Nord Ubangi","Mongala","Tshuapa","Tshopo",
                                 "Bas Uele","Haut Uele","Ituri","Nord Kivu","Sud Kivu",
                                 "Maniema","Haut Katanga","Lualaba","Haut Lomami",
                                 "Tanganyika","Lomami","Kasai Oriental","Sankuru",
                                 "Kasai Central","Kasai"))
str(new)
# HH6 urban
table(new$HH6)
colnames(new)[names(new)=='HH6']<-"urban"
table(new$urban)
new$urban[new$urban==2]<-0
new$urban<-factor(new$urban,levels = c(0,1),labels = c("rural","urban"))
str(new)
# helevel head of household education level
table(new$helevel)
new<-new[new$helevel!=9,]
table(new$helevel)
new$helevel[new$helevel==3|new$helevel==4]<-2
table(new$helevel)
new$helevel<-new$helevel+1
table(new$helevel)
new$helevel<-factor(new$helevel,levels = 1:3, 
                    labels = c("below primary","primary","secondary+"))
table(new$helevel)
str(new)
# HHsex
table(new$HHSEX)
colnames(new)[names(new)=='HHSEX']<-"hhsex"
new$hhsex[new$hhsex==2]<-0
table(new$hhsex)
new$hhsex<-factor(new$hhsex,levels = 0:1,labels = c("female","male"))
table(new$hhsex)
str(new)
# HH17 translate ,drop it
new<-select(new,-HH17,-PSU)
dim(new)
str(new)
write.csv(new,"Merged Data//merge_mics6.csv")
